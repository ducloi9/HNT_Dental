package com.hnt.dental.service;

import com.hnt.dental.constant.BookingStatusEnum;
import com.hnt.dental.constant.PaymentEnum;
import com.hnt.dental.dao.*;
import com.hnt.dental.dao.impl.*;
import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.*;
import com.hnt.dental.exception.SystemRuntimeException;
import com.hnt.dental.util.PagingUtils;
import com.hnt.dental.util.ServletUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Objects;
import java.util.Optional;


public class BookingService {

    private static final ServiceDao dao;
    private static final DoctorDao doctorDao;
    private static final EmployeeDao edao;
    private static final BookingDao adao;

    private static final PaymentDao pdao;
    private static final VNPayService vnPayService;

    static {
        dao = new ServiceDaoImpl();
        adao = new BookingDaoImpl();
        pdao = new PaymentDaoImpl();
        vnPayService = new VNPayService();
        doctorDao = new DoctorDaoImpl();
        edao = new EmployeeDaoImpl();
    }

    public void renderData(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String id = req.getParameter("serviceId");
        String typeId = req.getParameter("typeId");
        List<ServiceTypeDto> getType = dao.getTypeByServiceId(Long.valueOf(id));
        if (getType.isEmpty()) {
            ServletUtils.redirect(req, resp, "/service");
        } else {
            typeId = (typeId == null ? getType.get(0).getIdType() : Long.valueOf(typeId)).toString();
            ServiceDetailDto serviceResDtos = dao.getServiceDetailByServiceId(Long.valueOf(id), Long.valueOf(typeId));

            req.setAttribute("services", serviceResDtos);
            req.setAttribute("types", getType);
            req.setAttribute("typeId", typeId);
            req.setAttribute("id", id);
            ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/booking/booking.jsp");

        }
    }

    public void create(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ClassNotFoundException, ServletException, IOException {
        String error = null;
        String sid = req.getParameter("id");
        String typeId = req.getParameter("typeId");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String age = req.getParameter("age");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        String decription = req.getParameter("decription");
        String payment = req.getParameter("payment");
        BookingDto dto = null;
        try {
            if (name == null || name.isEmpty()) {
                throw new Exception("Name is required");
            }

            if (phone == null || phone.isEmpty()) {
                throw new Exception("Phone is required");
            }

            if (gender == null || gender.isEmpty()) {
                throw new Exception("Email is required");
            }

            if (age == null || age.isEmpty()) {
                throw new Exception("Age is required");
            }

            if (date == null || date.isEmpty()) {
                throw new Exception("Date is required");
            }

            if (time == null || time.isEmpty()) {
                throw new Exception("Time is required");
            }

            if (decription == null || decription.isEmpty()) {
                throw new Exception("Decription is required");
            }

            if (payment == null || payment.isEmpty()) {
                throw new Exception("Payment is required");
            }

            ServiceDetailDto serviceResDtos = dao.getServiceDetailByServiceId(Long.valueOf(sid), Long.valueOf(typeId));

            Account loginInfo = (Account) req.getSession().getAttribute("account");

            dto = BookingDto.builder()
                    .name(name)
                    .phone(Integer.parseInt(phone))
                    .gender(Boolean.parseBoolean(gender))
                    .age(Integer.parseInt(age))
                    .date(LocalDate.parse(date, DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                    .time(LocalTime.parse(time))
                    .description(decription)
                    .payment(payment)
                    .build();


            // hamf nayf chuwa co id doc tor vowi id staff
            Long id = adao.save(Booking.builder()
                    .name(name)
                    .account(Account.builder().id(loginInfo.getId()).build())
                    .service(Service.builder().id(serviceResDtos.getId()).build())
                    .typeId(Long.valueOf(typeId))
                    .phone(Integer.parseInt(phone))
                    .gender(Boolean.parseBoolean(gender))
                    .age(Integer.parseInt(age))
                    .date(LocalDate.parse(date, DateTimeFormatter.ofPattern("dd/MM/yyyy")))
                    .time(LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm")))
                    .description(decription)
                    .payment(payment)
                    .status(BookingStatusEnum.PENDING.ordinal())
                    .createdAt(LocalDateTime.now())
                    .updatedAt(LocalDateTime.now())
                    .build());
            pdao.save(
                    Payment.builder()
                            .account(Account.builder().id(1L).build())
                            .booking(Booking.builder().id(id).build())
                            .serviceFee(ServiceFee.builder().fee(Double.valueOf(serviceResDtos.getFee())).build())
                            .status(false)
                            .type(Objects.requireNonNull(PaymentEnum.getPaymentEnum(payment)).ordinal())
                            .created_at(LocalDateTime.now())
                            .updated_at(LocalDateTime.now())
                            .build()
            );
            adao.insertBookingId(BookingResult.builder()
                    .bookingId(id)
                    .createdAt(LocalDateTime.now())
                    .updatedAt(LocalDateTime.now())
                    .build());
            if (PaymentEnum.getPaymentEnum(payment) == PaymentEnum.CASH) {
                ServletUtils.redirect(req, resp, "/booking/success");
            } else {
                String url = vnPayService.renderPayment(id, Double.parseDouble(serviceResDtos.getFee()), req);
                ServletUtils.redirect(req, resp, url);
            }
            return;
        } catch (Exception e) {
            error = e.getMessage();
        }

        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("appointment", dto);
            List<ServiceTypeDto> getType = dao.getTypeByServiceId(Long.valueOf(sid));
            typeId = (typeId == null ? getType.get(0).getIdType() : Long.valueOf(typeId)).toString();
            ServiceDetailDto serviceResDtos = dao.getServiceDetailByServiceId(Long.valueOf(sid), Long.valueOf(typeId));

            req.setAttribute("services", serviceResDtos);
            req.setAttribute("types", getType);
            req.setAttribute("typeId", typeId);
            req.setAttribute("id", sid);
            ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/booking/booking.jsp");
        } else {
            ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/booking/booking-success.jsp");
        }
    }

    public void paymentCallback(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String vnpTxnRef = req.getParameter("vnp_TxnRef");
        String vnpBankTranNo = req.getParameter("vnp_BankTranNo");
        String vnpTransactionNo = req.getParameter("vnp_TransactionNo");
        String vnpResponseCode = req.getParameter("vnp_ResponseCode");

        if (vnpTxnRef != null && Integer.parseInt(vnpTxnRef) > 0
                && vnpBankTranNo != null && vnpResponseCode != null && vnpResponseCode.equals("00")
                && vnpTransactionNo != null && Integer.parseInt(vnpTransactionNo) > 0) {
            Optional<Payment> payment = pdao.getPaymentByAppointmentId(Long.valueOf(vnpTxnRef));
            if (payment.isPresent() && Boolean.FALSE.equals(payment.get().getStatus())) {
                payment.get().setStatus(true);
                payment.get().setUpdated_at(LocalDateTime.now());
                pdao.update(payment.get());
            } else {
                throw new SystemRuntimeException("Payment not found");
            }
            ServletUtils.redirect(req, resp, "/payment/success");
        } else {
            ServletUtils.redirect(req, resp, "/payment/error");
        }
    }

    public void getAll(HttpServletRequest req, HttpServletResponse resp) {
        String page = req.getParameter("page");
        String search = req.getParameter("search");
        String status = req.getParameter("status");
        String service = req.getParameter("service");
        Account loginInfo = (Account) req.getSession().getAttribute("account");
        int pageNumber = 1;

        if (StringUtils.isNotEmpty(page)) {
            pageNumber = Integer.parseInt(page);
        }

        if (StringUtils.isEmpty(search)) {
            search = "";
        }

        if (StringUtils.isEmpty(status)) {
            status = "";
        }

        if (StringUtils.isEmpty(service)) {
            service = "";
        }

        try {
            Integer totalItem = 0;
            switch (loginInfo.getRole()) {
                case 1:
                case 3:
                    totalItem = adao.countListBookingSummary(search.trim(), null, null);
                    break;
                case 2:
                    totalItem = adao.countListBookingSummary(search.trim(), null, loginInfo.getId());
                    break;
                case 4:
                    totalItem = adao.countListBookingSummary(search.trim(), loginInfo.getId(), null);
                    break;
            }
            Integer totalPage = PagingUtils.getTotalPage(totalItem);
            List<BookingManagementDto> getAllBookingSummary = null;
            switch (loginInfo.getRole()) {
                case 1:
                case 3:
                    getAllBookingSummary = adao.getAllBookingSummary(PagingUtils.getOffset(pageNumber), PagingUtils.DEFAULT_PAGE_SIZE, search.trim(), service.trim(), status.trim(), null, null);
                    break;
                case 2:
                    getAllBookingSummary = adao.getAllBookingSummary(PagingUtils.getOffset(pageNumber), PagingUtils.DEFAULT_PAGE_SIZE, search.trim(), service.trim(), status.trim(), null, loginInfo.getId());
                    break;
                case 4:
                    getAllBookingSummary = adao.getAllBookingSummary(PagingUtils.getOffset(pageNumber), PagingUtils.DEFAULT_PAGE_SIZE, search.trim(), service.trim(), status.trim(), loginInfo.getId(), null);
                    break;
            }


            List<BookingManagementDto> getServiceByServiceId = adao.getServiceByServiceId();
            List<BookingStatus> statuses = BookingStatusEnum.getAllBookingStatus();
            req.setAttribute("services", getServiceByServiceId);
            req.setAttribute("bookings", getAllBookingSummary);
            req.setAttribute("statuses", statuses);
            req.setAttribute("totalPage", totalPage);
            req.setAttribute("currentPage", pageNumber);
            req.setAttribute("search", search);
            req.setAttribute("status", status);
            req.setAttribute("service", service);
            req.setAttribute("url", "/management/booking");
            req.getRequestDispatcher("/WEB-INF/templates/management/booking/index.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void getDetailBooking(HttpServletRequest req, HttpServletResponse resp) {
        String id = req.getParameter("id");
        try {
            BookingDetailPatientDto getDetailPatientBooking = adao.getPatientByBookingId(Long.valueOf(id));
            BookingDetailServiceDto getDetailServiceBooking = adao.getServiceByBookingId(Long.valueOf(id));
            BookingDetailDoctorDto getDetailDoctorBooking = adao.getDoctorByBookingId(Long.valueOf(id));
            BookingDetailDto getBookingDetailById = adao.getBookingDetailById(Long.valueOf(id));
            List<DoctorSummaryRes> getListDoctorAvailable = doctorDao.getListDoctorAvailable(getBookingDetailById.getDate(),
                    getBookingDetailById.getTime(), getDetailServiceBooking.getTypeId(), getDetailServiceBooking.getId(), Long.valueOf(id));
            List<Employee> getEmployeeAvailable = edao.getEmployeeAvailable(getBookingDetailById.getDate(), getBookingDetailById.getTime(), Long.valueOf(id));
            BookingResult getBookingResultById = adao.getBookingResultById(Long.valueOf(id));
            req.setAttribute("patientBooking", getDetailPatientBooking);
            req.setAttribute("doctorBooking", getDetailDoctorBooking);
            req.setAttribute("serviceBooking", getDetailServiceBooking);
            req.setAttribute("booking", getBookingDetailById);
            req.setAttribute("doctors", getListDoctorAvailable);
            req.setAttribute("employee", getEmployeeAvailable);
            req.setAttribute("bookingResult", getBookingResultById);
            req.getRequestDispatcher("/WEB-INF/templates/management/booking/detail.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateBookingForMarketing(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        String fee = req.getParameter("fee");
        String doctor = req.getParameter("doctor");
        String staff = req.getParameter("staff");
        String status = req.getParameter("status");
        String paymentType = req.getParameter("payment_type");
        String paymentStatus = req.getParameter("payment_status");

        String id = req.getParameter("id");

        assert BookingStatusEnum.getBookingStatusEnum(status) != null;
        adao.updateBookingDetail(Booking.builder()
                .id(Long.valueOf(id))
                .doctors(Doctors.builder().id(Objects.equals(doctor, "") ? null : Long.valueOf(doctor)).build())
                .employee(Employee.builder().id(Objects.equals(staff, "") ? null : Long.valueOf(staff)).build())
                .status(BookingStatusEnum.getBookingStatusEnum(status).ordinal())
                .build());
        pdao.updatePaymentForMarketing(Payment.builder()
                .status(paymentStatus.equals("1"))
                .type(PaymentEnum.getPaymentEnum(paymentType).ordinal())
                .serviceFee(ServiceFee.builder().fee(Double.valueOf(fee)).build())
                .booking(Booking.builder().id(Long.valueOf(id)).build())
                .build());
        ServletUtils.redirect(req, resp, "/management/booking/detail?id=" + id);
    }

    public void updateBookingResult(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String bookingId = req.getParameter("id");
        String result = req.getParameter("result");

        adao.updateBookingResult(BookingResult.builder()
                .bookingId(Long.valueOf(bookingId))
                .result(result)
                .updatedAt(LocalDateTime.now())
                .build());
        ServletUtils.redirect(req, resp, "/management/booking/detail?id=" + bookingId);
    }

    public void getSuccessBooking(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String id = req.getParameter("id");
        adao.updateStatus(Booking.builder()
                .id(Long.valueOf(id))
                .status(BookingStatusEnum.DONE.ordinal())
                .build());
        ServletUtils.redirect(req, resp, "/management/booking/detail?id=" + id);
    }
}
