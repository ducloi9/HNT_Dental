package com.hnt.dental.service;

import com.google.gson.Gson;
import com.hnt.dental.constant.RoleEnum;
import com.hnt.dental.dao.*;
import com.hnt.dental.dao.impl.*;
import com.hnt.dental.dto.response.ApiResponse;
import com.hnt.dental.dto.response.BookingDto;
import com.hnt.dental.dto.response.ProfileDto;
import com.hnt.dental.entities.*;
import com.hnt.dental.exception.SystemRuntimeException;
import com.hnt.dental.util.AesUtils;

import com.hnt.dental.util.CaptchaUtils;
import com.hnt.dental.util.ImageUtils;
import com.hnt.dental.util.ServletUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.apache.commons.lang3.StringUtils;

import java.io.EOFException;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.ResourceBundle;


public class AuthService {
    private static final AccountDao accountDao;
    private static final PatientDao patientDao;
    private static final DoctorDao doctorDao;
    private static final EmployeeDao employeeDao;
    private static final VerificationDao verificationDao;

    private static final ResourceBundle bundle = ResourceBundle.getBundle("application");
    private static final ResourceBundle bundleMessage = ResourceBundle.getBundle("message");

    static {
        accountDao = new AccountDaoImpl();
        patientDao = new PatientDaoImpl();
        doctorDao = new DoctorDaoImpl();
        employeeDao = new EmployeeDaoImpl();
        verificationDao = new VerificationDaoImpl();
    }

    public void login(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String message = null;

        Account account = accountDao.findByEmail(email);

        if (account != null) {
            try {
                String passwordEncrypt = AesUtils.encrypt(password);
                if (StringUtils.equals(passwordEncrypt, account.getPassword())) {
                    if (Boolean.TRUE.equals(account.getIsVerified())) {
                        account.setPassword(null);
                        req.getSession().setAttribute("account", account);
                        message = "success";
                    } else {
                        message = "account_not_verified";
                    }
                } else {
                    message = "password_incorrect";
                }
            } catch (Exception e) {
                throw new SystemRuntimeException("Error encrypt");
            }
        } else {
            message = "email_incorrect";
        }
        ApiResponse<Account> response = new ApiResponse<>();
        response.setStatus(false);
        response.setMessage(message);
        ServletUtils.apiResponse(resp, new Gson().toJson(response));
    }

    public void register(HttpServletRequest req, HttpServletResponse resp) {
        String fullName = req.getParameter("fullName");
        String dob = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        try {
            if (accountDao.findByEmail(email) != null) {
                ApiResponse<Account> response = new ApiResponse<>();
                response.setStatus(false);
                response.setMessage("email_existed");
                ServletUtils.apiResponse(resp, new Gson().toJson(response));
            } else {

                Long id = accountDao.save(
                        Account.builder()
                                .email(email)
                                .password(AesUtils.encrypt(password))
                                .role(RoleEnum.ROLE_PATIENT.ordinal())
                                .createdAt(LocalDateTime.now())
                                .updatedAt(LocalDateTime.now())
                                .isVerified(false)
                                .build()
                );

                patientDao.save(
                        Patient.builder()
                                .account(Account.builder().id(id).build())
                                .fullName(fullName)
                                .dob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                                .address(address)
                                .phone(phone)
                                .gender(StringUtils.equals(gender, "Nam"))
                                .build()
                );

                String captcha = CaptchaUtils.getCaptcha(6);

                verificationDao.save(
                        Verification.builder()
                                .email(email)
                                .code(captcha)
                                .createdAt(LocalDateTime.now())
                                .updatedAt(LocalDateTime.now())
                                .build()
                );

                String url = bundle.getString("server.url") + "/auth/verification?email=" + email + "&code=" + captcha;
                MailService.sendMailConfirm(fullName, url, email);

                ApiResponse<Account> response = new ApiResponse<>();
                response.setStatus(false);
                response.setMessage("success");
                ServletUtils.apiResponse(resp, new Gson().toJson(response));
            }
        } catch (Exception e) {
            throw new SystemRuntimeException(e.getMessage());
        }
    }

    public void verification(HttpServletRequest req, HttpServletResponse resp) {
        String email = req.getParameter("email");
        String code = req.getParameter("code");
        try {
            Verification verification = verificationDao.findByEmail(email);

            if (verification != null && StringUtils.equals(verification.getCode(), code) && (StringUtils.equals(code, verification.getCode()))) {
                Account account = accountDao.findByEmail(email);
                account.setIsVerified(true);
                accountDao.update(account);
                verificationDao.delete(verification);
                req.setAttribute("success", true);
                ServletUtils.requestDispatcher(req, resp, "/auth/verification/result");
            } else {
                req.setAttribute("success", false);
                ServletUtils.requestDispatcher(req, resp, "/auth/verification/result");
            }
        } catch (Exception e) {
            throw new SystemRuntimeException("Error decrypt");
        }
    }

    public void forgot(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        String email = req.getParameter("email");
        try {
            Account account = accountDao.findByEmail(email);
            if (account != null) {
                String captcha = CaptchaUtils.getCaptcha(6);

                verificationDao.save(
                        Verification.builder()
                                .email(email)
                                .code(captcha)
                                .createdAt(LocalDateTime.now())
                                .updatedAt(LocalDateTime.now())
                                .createdBy(account.getId())
                                .build()
                );
                String url = bundle.getString("server.url") + "/auth/forgot/confirm?email=" + email + "&code=" + captcha;
                MailService.sendMailForgotPassword(account.getEmail(), url, email);
                ServletUtils.apiResponse(resp, new Gson().toJson(ApiResponse.builder().status(true).message("success").build()));
            } else {
                ServletUtils.apiResponse(resp, new Gson().toJson(ApiResponse.builder().status(false).message("email_not_existed").build()));
            }
        } catch (Exception e) {
            throw new SystemRuntimeException("Error encrypt");
        }
    }

    public void forgotConfirm(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String code = req.getParameter("code");
        String password = req.getParameter("newPassword");
        try {
            Verification verification = verificationDao.findByEmail(email);

            if (verification != null && StringUtils.equals(verification.getCode(), code) && (StringUtils.equals(code, verification.getCode()))) {
                Account account = accountDao.findByEmail(email);
                account.setPassword(AesUtils.encrypt(password));
                account.setUpdatedAt(LocalDateTime.now());
                accountDao.update(account);
                ServletUtils.apiResponse(resp, new Gson().toJson(ApiResponse.builder().status(true).message("success").build()));
            } else {
                ServletUtils.apiResponse(resp, new Gson().toJson(ApiResponse.builder().status(false).message("token-invalid").build()));
            }

        } catch (Exception e) {
            ServletUtils.apiResponse(resp, new Gson().toJson(ApiResponse.builder().status(false).message("error").build()));
        }
    }

    public void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.getSession().removeAttribute("account");
        ServletUtils.redirect(req, resp, "/auth/login");
    }

    public void historyBooking(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        resp.setContentType("text/html;charset=UTF-8");
        BookingDao dao = new BookingDaoImpl();
        List<BookingDto> list = null;
        try {
            list = dao.getAllHistory();
            int page = 1;
            String pageStr = req.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
            final int PAGE_SIZE = 8;
            req.setAttribute("list", list.subList((page - 1) * PAGE_SIZE, page * PAGE_SIZE));
            ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/service-history.jsp");
        } catch (SQLException e) {
            throw new EOFException();

        }
    }

    public void history(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        resp.setContentType("text/html;charset=UTF-8");
        String id = req.getParameter("id");
        BookingDao dao = new BookingDaoImpl();
        BookingDto detail = dao.DetailHistory(id);
        req.setAttribute("d", detail);
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/my-appointment-detail.jsp");

    }

    public void getProfile(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        Account account = (Account) req.getSession().getAttribute("account");
        String error = req.getParameter("error");
        String success = req.getParameter("success");
        ProfileDto profileDto = null;
        switch (account.getRole()) {
            case 0://patient
                profileDto = patientDao.getProfile(account.getId());
                break;
            case 1:// admin
            case 3:
            case 4:
                profileDto = employeeDao.getProfileEmployee(account.getId());
                break;
            case 2://doctor
                profileDto = doctorDao.getProfileDoctor(account.getId());
                break;
        }
        HttpSession session = req.getSession();
        session.setAttribute("profile", profileDto);
        req.setAttribute("profile", profileDto);
        req.setAttribute("error", error != null ? bundleMessage.getString(error) : null);
        req.setAttribute("success", success != null ? bundleMessage.getString(success) : null);
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/profile.jsp");
    }

    public void changePassword(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Account account = (Account) req.getSession().getAttribute("account");
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (StringUtils.equals(newPassword, confirmPassword)) {
            try {
                Account accountMain = accountDao.findByEmail(account.getEmail());
                if (StringUtils.equals(AesUtils.encrypt(oldPassword), accountMain.getPassword())) {
                    accountMain.setPassword(AesUtils.encrypt(newPassword));
                    accountDao.update(accountMain);
                    ServletUtils.redirect(req, resp, "/auth/profile?success=change_password_success");
                } else {
                    ServletUtils.redirect(req, resp, "/auth/profile?error=old_password_invalid");
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        } else {
            ServletUtils.redirect(req, resp, "/auth/profile?error=confirm_password_invalid");
        }
    }

    public void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        Part img = req.getPart("image");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String dob = req.getParameter("dob");
        String address = req.getParameter("address");
        String description = req.getParameter("description");
        String gender = req.getParameter("gender");

        Account account = (Account) req.getSession().getAttribute("account");
        account = accountDao.findByEmail(account.getEmail());
        if (img.getSize() > 0) {
            account.setImage(ImageUtils.upload(img));
            accountDao.update(account);
        }

        switch (account.getRole()) {
            case 0://patient
                patientDao.update(Patient.builder()
                        .account(Account.builder().id(account.getId()).build())
                        .fullName(fullName)
                        .phone(phone)
                        .dob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                        .address(address)
                        .description(description)
                        .gender(gender.equalsIgnoreCase("Nam"))
                        .createdAt(LocalDateTime.now())
                        .updatedAt(LocalDateTime.now())
                        .build());
                break;
            case 1:// admin
            case 3:
            case 4:
                employeeDao.update(Employee.builder()
                        .account(Account.builder().id(account.getId()).build())
                        .fullName(fullName)
                        .phone(phone)
                        .dob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                        .address(address)
                        .description(description)
                        .gender(gender.equalsIgnoreCase("Nam"))
                        .createdAt(LocalDateTime.now())
                        .updatedAt(LocalDateTime.now())
                        .build());
                break;
            case 2://doctor
                doctorDao.update(Doctors.builder()
                        .account(Account.builder().id(account.getId()).build())
                        .fullName(fullName)
                        .phone(phone)
                        .dob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                        .address(address)
                        .description(description)
                        .gender(gender.equalsIgnoreCase("Nam"))
                        .createdAt(LocalDateTime.now())
                        .updatedAt(LocalDateTime.now())
                        .build());
                break;
        }

        ServletUtils.redirect(req, resp, "/auth/profile?success=update_profile_success");
    }
}
