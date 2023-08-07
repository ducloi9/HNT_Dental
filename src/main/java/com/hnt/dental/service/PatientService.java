package com.hnt.dental.service;
import com.hnt.dental.dto.response.PatientResDto;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.entities.Feedback;
import com.hnt.dental.util.AesUtils;
import com.hnt.dental.util.CaptchaUtils;
import org.apache.commons.lang3.StringUtils;
import com.hnt.dental.entities.Account;
import com.hnt.dental.exception.SystemRuntimeException;
import com.hnt.dental.util.PagingUtils;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;
import com.hnt.dental.constant.RoleEnum;
import com.hnt.dental.dao.AccountDao;
import com.hnt.dental.dao.PatientDao;
import com.hnt.dental.dao.impl.AccountDaoImpl;
import com.hnt.dental.dao.impl.PatientDaoImpl;
import com.hnt.dental.dao.impl.VerificationDaoImpl;
import com.hnt.dental.entities.Patient;
import com.hnt.dental.util.ServletUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

import com.hnt.dental.dto.response.BookingDto;




public class PatientService {
    private static final PatientDao patientDao;
    private static final AccountDao accountDao;




    static {

        patientDao  = new PatientDaoImpl();
        accountDao = new AccountDaoImpl();

    }

    public void getAll(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String page = req.getParameter("page");
        String search = req.getParameter("search");
        int pageNumber = 1;

        if (StringUtils.isNotEmpty(page)) {
            pageNumber = Integer.parseInt(page);
        }

        if(StringUtils.isEmpty(search)) {
            search = "";
        }
        Integer totalItem = patientDao.count(renderSearch(search.trim()));
        Integer totalPage = PagingUtils.getTotalPage(totalItem);

        List<Patient> patients = patientDao.getAll(PagingUtils.getOffset(pageNumber), PagingUtils.DEFAULT_PAGE_SIZE, renderSearch(search.trim()));

        req.setAttribute("patients", PatientResDto.convert(patients));
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("currentPage", pageNumber);
        req.setAttribute("search", search);
        req.setAttribute("url", "/management/patient");
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/management/patient/index.jsp");
    }


    public void patientDetail(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        resp.setContentType("text/html;charset=UTF-8");
        String id = req.getParameter("id");
        PatientDao dao = new PatientDaoImpl();
        Patient p = dao.DetailPatients(id);
        req.setAttribute("detail", p);
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/management/patient/update.jsp");
    }



    public void delete(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        patientDao.delete(Patient.builder().id((long) id).build());
        ServletUtils.redirect(req, resp, "/management/patient");
    }


    public void create(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String fullName = req.getParameter("full_name");
        String dob = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String description = req.getParameter("description");
        String password = AesUtils.encrypt(CaptchaUtils.getCaptcha(8));
        RoleEnum role = RoleEnum.ROLE_PATIENT;
        Long id = accountDao.save(
                Account.builder()
                        .email(email)
                        .password(password)
                        .role(role.ordinal())
                        .isVerified(true)
                        .build()
        );
        patientDao.save(
                Patient.builder()
                        .account(Account.builder().id(id).build())
                        .fullName(fullName)
                        .dob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                        .gender(Objects.equals(gender, "Nam"))
                        .phone(phone)
                        .address(address)
                        .description(description)
                        .build()
        );
        ServletUtils.redirect(req, resp, "/management/patient");
    }

    public void update(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Long id = Long.valueOf(req.getParameter("id"));
        String fullname = req.getParameter("full_name");
        String dob = req.getParameter("dob");
        String gender = req.getParameter("gender");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        String email = req.getParameter("email");
        RoleEnum role = RoleEnum.ROLE_PATIENT;
        String error = null;
        try {
            Account account = accountDao.findByEmail(email);

            if (account != null && !Objects.equals(account.getId(), id)) {
                throw new SystemRuntimeException(StringUtils.join("Email ", email, " already exists"));
            }

            account = accountDao.get(id.intValue()).isPresent() ? accountDao.get(id.intValue()).get() : null;
            account.setEmail(email);
            account.setRole(role.ordinal());
            account.setUpdatedAt(LocalDateTime.now());
            accountDao.update(account);
            patientDao.update(
                    Patient.builder()
                            .account(Account.builder().id(id).build())
                            .fullName(fullname)
                            .dob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                            .gender(Objects.equals(gender, "nam"))
                            .phone(phone)
                            .status(Objects.equals(status, "active"))
                            .address(address)
                            .description(description)
                            .build()
            );
        } catch (Exception e) {
            error = e.getMessage();
        }

        if (StringUtils.isNotEmpty(error)) {
            ServletUtils.redirect(req, resp, "/management/patient/update?id=" + id + "&error=" + error);
        } else {
            ServletUtils.redirect(req, resp, "/management/patient");
        }
    }
    private String renderSearch(String search){
        if(search.matches("\\d{2}/\\d{2}/\\d{4}")){
            String[] date = search.split("/");
            return StringUtils.join(date[2], "-", date[1], "-", date[0]);
        }
        return search;
    }








    public void historyService(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        Account account = (Account) req.getSession().getAttribute("account");
        if (account != null) {
            try {
                Long patientId = account.getId();
                if (patientId != null) {
                    List<BookingDto> service = patientDao.getService(patientId);
                    if (service != null) {
                        req.setAttribute("service", service);
                        req.setAttribute("id", String.valueOf(patientId));
                        req.setAttribute("url", "/auth/patient-booking-history");

                        req.getRequestDispatcher("/WEB-INF/templates/home/service-history.jsp").forward(req, resp);
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                // throw new SystemRuntimeException();
            }
        }
        //resp.sendRedirect(req.getContextPath() + "/management/service-booking");
    }

    public void historyAppointment(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        Account account = (Account) req.getSession().getAttribute("account");
        if (account != null) {
            try {
                Long patientId = account.getId();
                if (patientId != null) {
                    List<BookingDto> service = patientDao.getAppointment(patientId);
                    if (service != null) {
                        req.setAttribute("service", service);
                        req.setAttribute("id", String.valueOf(patientId));
                        req.setAttribute("url", "/management/my-appointment");

                        req.getRequestDispatcher("/WEB-INF/templates/home/my-appointment.jsp").forward(req, resp);
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                // throw new SystemRuntimeException();
            }
        }
        //resp.sendRedirect(req.getContextPath() + "/management/service-booking");
    }

    public void detailAppointment(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        resp.setContentType("text/html;charset=UTF-8");
        String id = req.getParameter("id");
        PatientDao dao = new PatientDaoImpl();
        BookingDto detail = dao.detailAppointment(id);
        req.setAttribute("d", detail);
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/my-appointment-detail.jsp");

    }
    public void createFeedback(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        resp.setContentType("text/html;charset=UTF-8");
        String feedbackType = req.getParameter("feedbackType"); // Added this line
        String id = req.getParameter("id");
        PatientDao dao = new PatientDaoImpl();
        BookingDto detail = dao.detailAppointment(id);
        req.setAttribute("d", detail);

        // Get the star rating and description from the user
        int star = Integer.parseInt(req.getParameter("star"));
        String description = req.getParameter("description");

        // Save the feedback to the database based on the feedbackType
        if ("service".equals(feedbackType)) {
            dao.saveServiceReview(detail.getId(), detail.getService_id(), star, description);
        } else if ("doctor".equals(feedbackType)) {
            dao.saveDoctorReview(detail.getId(), detail.getDoctor_id(), star, description);
        }

        // Redirect the user to the appointment detail page
        resp.sendRedirect(req.getContextPath() + "/auth/detail-appointment-history?id=" + id);
    }



    public void getAllMyPatient(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String page = req.getParameter("page");
        String search = req.getParameter("search");
        int pageNumber = 1;

        if (StringUtils.isNotEmpty(page)) {
            pageNumber = Integer.parseInt(page);
        }

        if(StringUtils.isEmpty(search)) {
            search = "";
        }
        Integer totalItem = patientDao.count(renderSearch(search.trim()));
        Integer totalPage = PagingUtils.getTotalPage(totalItem);

        List<BookingDto> patients = patientDao.getMyPatient(PagingUtils.getOffset(pageNumber), PagingUtils.DEFAULT_PAGE_SIZE, renderSearch(search.trim()));

        req.setAttribute("list", patients);
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("currentPage", pageNumber);
        req.setAttribute("search", search);
        req.setAttribute("url", "/management/patient");
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/management/doctor/myPatientOfDoctor.jsp");
    }


}





