package com.hnt.dental.dao.impl;

import com.hnt.dental.constant.BookingStatusEnum;
import com.hnt.dental.constant.PaymentEnum;
import com.hnt.dental.dao.BookingDao;
import com.hnt.dental.dto.response.ServiceTypeDto;
import com.hnt.dental.entities.Booking;
import com.hnt.dental.entities.Service;
import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.*;
import com.hnt.dental.util.ConnectionUtils;
import org.apache.commons.lang3.StringUtils;
import com.hnt.dental.dto.response.BookingDto;
import com.hnt.dental.dto.response.ServiceResDto;

import javax.management.MBeanAttributeInfo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookingDaoImpl implements BookingDao {
    private static final String SAVE_BOOKING = "INSERT INTO booking " +
            "           ( name, phone, gender, age, account_id, service_id,service_type_id, `date`, `time`, decription, status, created_at, updated_at) " +
            "            VALUES(?, ?, ?, ? , ?, ?, ? ,? ,?, ?, ?,?, ?)";
    private static final String GET_ALL_BOOKING = "SELECT b.id, b.name, s.name as service, b.date, b.time, b.status FROM booking b " +
            "            inner join service s on b.service_id = s.id " +
            "            where (LOWER(b.name) like ? OR LOWER(s.name) like ?) AND s.id LIKE ? AND b.status LIKE ? order by b.created_at desc " +
            "LIMIT ?, ?";
    private static final String GET_ALL_BOOKING_STAFF = "SELECT b.id, b.name, s.name as service, b.date, b.time, b.status FROM booking b " +
            "            inner join service s on b.service_id = s.id " +
            "            where b.staff_id = ? AND  (LOWER(b.name) like ? OR LOWER(s.name) like ?) AND s.id LIKE ? AND b.status LIKE ? order by b.created_at desc " +
            "LIMIT ?, ?";
    private static final String GET_ALL_BOOKING_DOCTOR = "SELECT b.id, b.name, s.name as service, b.date, b.time, b.status FROM booking b " +
            "            inner join service s on b.service_id = s.id " +
            "            where b.doctor_id = ? AND  (LOWER(b.name) like ? OR LOWER(s.name) like ?) AND s.id LIKE ? AND b.status LIKE ? order by b.created_at desc " +
            "LIMIT ?, ?";
    private static final String SQL_COUNT_BOOKING = "SELECT count(*) FROM booking b " +
            "                       inner join service s on b.service_id = s.id " +
            "                      where LOWER(b.name) like ? OR LOWER(s.name) like ? order by b.id";

    private static final String SQL_COUNT_BOOKING_STAFF = "SELECT count(*) FROM booking b " +
            "                       inner join service s on b.service_id = s.id " +
            "                      where b.staff_id = ? AND (LOWER(b.name) like ? OR LOWER(s.name) like ?) order by b.id";

    private static final String SQL_COUNT_BOOKING_DOCTOR = "SELECT count(*) FROM booking b " +
            "                       inner join service s on b.service_id = s.id " +
            "                      where b.doctor_id = ? AND (LOWER(b.name) like ? OR LOWER(s.name) like ?) order by b.id";
    private static final String SQL_GET_SERVICE_BY_SERVICE_ID = "select DISTINCT s.name, s.id from booking b " +
            "inner join service s on b.service_id = s.id";

    private static final String SQL_GET_STATUS = "select distinct b.status from booking b ";

    private static final String SQL_GET_PATIENT = "select b.id, b.name, b.gender, b.phone, b.age from booking b " +
            "where b.id = ?";
    private static final String SQL_GET_DOCTOR = "select b.id, d.full_name, dr.name, d.position, d.gender, d.image from booking b " +
            "inner join doctors d on b.doctor_id = d.id " +
            "inner join doctor_rank dr on dr.id = d.rank_id " +
            "where b.id = ?";
    private static final String SQL_GET_SERVICE_BY_BOOKING_ID = "select s.id, s.name,s.image, st.name  as serviceType, st.id as typeID , p.fee from booking b " +
            "inner join service s on b.service_id = s.id " +
            "inner join service_type st on st.id = b.service_type_id " +
            "inner join payment p on p.booking_id = b.id " +
            "where b.id = ? ";
    private static final String SQL_GET_BOOKING_DETAIL_BY_BOOKING_ID = "select b.date, b.time, b.status as statusBooking, d.id as doctorID, d.full_name as doctorName ," +
            " e.full_name as employeeName, e.id as employeeId, p.status as statusPayment, p.type, b.decription  from booking b " +
            "LEFT join doctors d on b.doctor_id = d.id " +
            "LEFT join employees e on e.id = b.staff_id " +
            "inner join payment p on p.booking_id = b.id " +
            "where b.id = ? ";
    private static final String HISTORY_PATIENT = "SELECT  b.fee ,b.account_id, b.status ,b.time,b.date ,s.name  FROM booking b join service s " +
            " where b.service_id = s.id ";
    private static final String HISTORY_DETAIL = "SELECT b.date,b.name, b.age, b.email,b.decription,b.status,b.phone,s.name as service FROM booking b join service_type s " +
            "                       on b.service_id = s.id where b.id =?";

    private static final String UPDATE_BOOKING_FOR_MARKETING = "UPDATE hnt_dental.booking " +
            "SET   doctor_id=?, staff_id=?, status=? " +
            "WHERE id=? ";

    private static final String INSERT_BOOKING_RESULT = "INSERT INTO booking_result " +
            "(booking_id, result, created_at, updated_at) " +
            "VALUES(?, ?, ?, ?)";
    private static final String SQL_UPDATE_BOOKING_RESULT = "UPDATE booking_result " +
            "SET  `result`= ?, updated_at=? " +
            "WHERE booking_id = ? ";

    private static final String SQL_GET_BOOKING_RESULT_BY_ID = "select * from booking_result " +
            "where booking_id = ? ";

    private static final String SQL_COUNT_BOOKING_DASHBOARD = "SELECT count(*) FROM booking";

    private static final String SQL_GET_BOOKING_TODAY = "SELECT b.id, b.name, b.service_id, s.name as serviceName, " +
            "b.service_type_id, st.name as serviceType, b.date ,b.status FROM booking b " +
            "left join service s on s.id = b.service_id " +
            "left join service_type st on st.id = b.service_type_id " +
            "WHERE  date >= CURDATE() AND date < CURDATE() + INTERVAL 1 DAY ";

    private static final String SQL_GET_STATISTIC_7Day = " Select p.day , coalesce(count(u.id), 0) as count from ( " +
            "                   Select curdate() as day " +
            "                          union " +
            "                    Select date_sub(Curdate(),interval 1 day) " +
            "                          union " +
            "                    Select date_sub(Curdate(),interval 2 day) " +
            "                          union " +
            "                    Select date_sub(Curdate(),interval 3 day) " +
            "                          union " +
            "                    Select date_sub(Curdate(),interval 4 day) " +
            "                         union " +
            "                   Select date_sub(Curdate(),interval 5 day) " +
            "                        union " +
            "                Select date_sub(Curdate(),interval 6 day))as p " +
            "                left join booking as u on p.day = u.date group by p.day order by p.day asc";

    private static final String SQL_GET_STATISTIC_14Day = "SELECT p.day, COALESCE(COUNT(u.id), 0) AS count" +
            " FROM (" +
            "    SELECT CURDATE() AS day" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 7 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 8 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 9 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 11 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 12 DAY)" +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 13 DAY)" +
            " ) AS p" +
            " LEFT JOIN booking AS u ON p.day = u.date" +
            " GROUP BY p.day" +
            " ORDER BY p.day ASC";

    private static final String SQL_GET_STATISTIC_30Day = "SELECT p.day, COALESCE(COUNT(u.id), 0) AS count " +
            "FROM ( " +
            "    SELECT CURDATE() AS day " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 1 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 2 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 4 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 6 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 8 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 9 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 11 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 12 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 13 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 14 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 15 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 16 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 17 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 18 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 19 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 20 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 21 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 22 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 23 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 24 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 25 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 26 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 27 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 28 DAY) " +
            "    UNION SELECT DATE_SUB(CURDATE(), INTERVAL 29 DAY) " +
            ") AS p " +
            "LEFT JOIN booking AS u ON p.day = u.date " +
            "GROUP BY p.day " +
            "ORDER BY p.day ASC ";

    private static final String SQL_UPDATE_STATUS = "UPDATE booking SET status = ? WHERE id = ?";


    private static String SQL_GET_BOOKING_FOR_DOCTOR = "SELECT b.id, b.name,s.name as serviceName, b.date,b.time,b.status FROM hnt_dental.booking b " +
            "left join service s on s.id = b.service_id " +
            "where b.doctor_id = ?";

    private static String SQL_GET_BOOKING_FOR_STAFF = "SELECT b.id, b.name,s.name as serviceName, b.date,b.time,b.status FROM hnt_dental.booking b " +
            "left join service s on s.id = b.service_id " +
            "where b.staff_id = ?";

    @Override
    public void updateBookingDetail(Booking bookingDetailDto) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_BOOKING_FOR_MARKETING, bookingDetailDto.getDoctors().getId(),
                bookingDetailDto.getEmployee().getId(), bookingDetailDto.getStatus(), bookingDetailDto.getId());
    }

    @Override
    public void updateBookingResult(BookingResult bookingResult) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_UPDATE_BOOKING_RESULT, bookingResult.getResult(),
                bookingResult.getUpdatedAt(), bookingResult.getBookingId());
    }

    @Override
    public Long insertBookingId(BookingResult bookingResult) throws SQLException {
        return ConnectionUtils.executeUpdateForIdentity(INSERT_BOOKING_RESULT, bookingResult.getBookingId(),
                bookingResult.getResult(), bookingResult.getCreatedAt(), bookingResult.getUpdatedAt());
    }

    @Override
    public BookingResult getBookingResultById(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_BOOKING_RESULT_BY_ID, id);
        while (rs.next()) {
            return BookingResult.builder()
                    .result(rs.getString("result"))
                    .build();
        }
        return null;
    }

    @Override
    public Long countBookingDashboard() throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_BOOKING_DASHBOARD);
        while (rs.next()) {
            return rs.getLong(1);
        }
        return null;
    }


    @Override
    public List<DashboardDto> getAllBookingToday() throws SQLException {
        List<DashboardDto> dashboardDtoList = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_BOOKING_TODAY);
        while (rs.next()) {
            dashboardDtoList.add(DashboardDto.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .service(Service.builder().id(rs.getLong("service_id")).name(rs.getString("serviceName")).build())
                    .serviceType(ServiceType.builder().id(rs.getLong("service_type_id")).name(rs.getString("serviceType")).build())
                    .time(rs.getDate("date").toLocalDate())
                    .status(BookingStatusEnum.getBookingStatusString(rs.getInt("status")))
                    .build());
        }
        return dashboardDtoList;
    }

    @Override
    public List<StatisticDto> getStatisticBookingTime(String type) throws SQLException {
        List<StatisticDto> statisticDtoList = new ArrayList<>();
        ResultSet rs = null;
        switch (type) {
            case "14":
                rs = ConnectionUtils.executeQuery(SQL_GET_STATISTIC_14Day);
                break;
            case "30":
                rs = ConnectionUtils.executeQuery(SQL_GET_STATISTIC_30Day);
                break;
            default:
                rs = ConnectionUtils.executeQuery(SQL_GET_STATISTIC_7Day);
                break;
        }
        while (rs.next()) {
            statisticDtoList.add(StatisticDto.builder()
                    .date(LocalDate.parse(rs.getString("day"), DateTimeFormatter.ofPattern("yyyy-MM-dd")))
                    .count(rs.getInt("count"))
                    .build());
        }
        return statisticDtoList;
    }

    @Override
    public void updateStatus(Booking booking) {
        try {
            ConnectionUtils.executeUpdate(SQL_UPDATE_STATUS, booking.getStatus(), booking.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public List<Booking> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }

    @Override
    public Optional<Booking> get(int id) throws SQLException {
        return Optional.empty();
    }

    @Override
    public Long save(Booking booking) throws SQLException, ClassNotFoundException {
        return ConnectionUtils.executeUpdateForIdentity(SAVE_BOOKING, booking.getName(), booking.getPhone(), booking.isGender(), booking.getAge(),
                booking.getAccount().getId(), booking.getService().getId(), booking.getTypeId(), booking.getDate(), booking.getTime(),
                booking.getDescription(), booking.getStatus(), booking.getCreatedAt(), booking.getUpdatedAt());
    }

    @Override
    public void update(Booking booking) throws SQLException {

    }

    @Override
    public void delete(Booking booking) throws SQLException {

    }

    @Override
    public List<BookingManagementDto> getAllBookingSummary(int offset, int limit, String search, String serviceId, String status, Long staff, Long doctor) throws SQLException {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        serviceId = StringUtils.isNotEmpty(serviceId) ? serviceId : "%";
        status = StringUtils.isNotEmpty(status) ? status : "%";
        ResultSet rs = null;
        if (staff == null && doctor == null) {
            rs = ConnectionUtils.executeQuery(GET_ALL_BOOKING, search, search, serviceId, status, offset, limit);
        }
        if (staff != null) {
            rs = ConnectionUtils.executeQuery(GET_ALL_BOOKING_STAFF, staff, search, search, serviceId, status, offset, limit);
        }
        if (doctor != null) {
            rs = ConnectionUtils.executeQuery(GET_ALL_BOOKING_DOCTOR, doctor, search, search, serviceId, status, offset, limit);
        }
        List<BookingManagementDto> list = new ArrayList<>();
        while (rs.next()) {
            list.add(BookingManagementDto.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .service(Service.builder().name(rs.getString("service")).build())
                    .date(rs.getDate("date").toLocalDate())
                    .time(rs.getTime("time").toLocalTime())
                    .status(BookingStatusEnum.getBookingStatusString(rs.getInt("status")))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return list;
    }

    @Override
    public Integer countListBookingSummary(String search, Long staff, Long doctor) throws SQLException {
        search = "%" + search + "%";
        ResultSet rs = null;
        if (staff == null && doctor == null) {
            rs = ConnectionUtils.executeQuery(SQL_COUNT_BOOKING, search, search);
        }
        if (staff != null) {
            rs = ConnectionUtils.executeQuery(SQL_COUNT_BOOKING_STAFF, staff, search, search);
        }
        if (doctor != null) {
            rs = ConnectionUtils.executeQuery(SQL_COUNT_BOOKING_DOCTOR, doctor, search, search);
        }
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }


    @Override
    public List<BookingManagementDto> getServiceByServiceId() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SERVICE_BY_SERVICE_ID);
        List<BookingManagementDto> list = new ArrayList<>();
        while (rs.next()) {
            list.add(BookingManagementDto.builder()
                    .service(Service.builder().name(rs.getString("name")).id(rs.getLong("id")).build())
                    .build());
        }
        ConnectionUtils.closeConnection();
        return list;
    }

    public List<BookingDto> getAllHistory() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(HISTORY_PATIENT);
        List<BookingDto> list = new ArrayList<>();
        while (true) {
            assert rs != null;
            if (!rs.next()) break;
            list.add(BookingDto
                    .builder().serviceResDto(ServiceResDto.builder()
                            .name(rs.getString("name"))
                            .build())
                    .date(rs.getDate("date").toLocalDate())
                    .status(String.valueOf(rs.getBoolean("status")))
                    .time(LocalTime.parse(String.valueOf(rs.getTime("time"))))
                    .fee(rs.getDouble("fee"))
                    .account_id(rs.getInt("account_id"))
                    .build());
        }
        return list;

    }


    @Override
    public BookingDto DetailHistory(String id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(HISTORY_DETAIL, id);

        assert rs != null;

//        if (rs.next()) {
//            return (BookingDto.builder()
//                    .phone(rs.getInt("phone"))
//                    .status(String.valueOf(rs.getBoolean("status")))
//                    .name(rs.getString("name"))
//                    .email(rs.getString("email"))
//                    .age(rs.getInt("age"))
//                    .decription(rs.getString("decription"))
//                    .date(rs.getDate("date").toLocalDate())
//                    .build());
//        }
        return null;

    }


    @Override
    public BookingDetailPatientDto getPatientByBookingId(Long id) throws SQLException {
        BookingDetailPatientDto bookingDetailPatientDto = new BookingDetailPatientDto();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_PATIENT, id);
        if (rs.next()) {
            bookingDetailPatientDto = BookingDetailPatientDto
                    .builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .gender(rs.getBoolean("gender"))
                    .phone(rs.getString("phone"))
                    .age(rs.getInt("age"))
                    .build();
        }
        ConnectionUtils.closeConnection();
        return bookingDetailPatientDto;
    }

    @Override
    public BookingDetailDoctorDto getDoctorByBookingId(Long id) throws SQLException {
        BookingDetailDoctorDto bookingDetailDoctorDto = new BookingDetailDoctorDto();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_DOCTOR, id);
        if (rs.next()) {
            bookingDetailDoctorDto = BookingDetailDoctorDto
                    .builder()
                    .id(rs.getLong("id"))
                    .doctors(
                            Doctors.builder()
                                    .fullName(rs.getString("full_name"))
                                    .gender(rs.getBoolean("gender"))
                                    .position(rs.getString("position"))
                                    .image(rs.getString("image"))
                                    .build())
                    .doctorRank(
                            DoctorRank.builder()
                                    .name(rs.getString("name"))
                                    .build())
                    .build();
        }
        ConnectionUtils.closeConnection();
        return bookingDetailDoctorDto;
    }

    @Override
    public BookingDetailServiceDto getServiceByBookingId(Long id) throws SQLException {
        BookingDetailServiceDto bookingDetailServiceDto = new BookingDetailServiceDto();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SERVICE_BY_BOOKING_ID, id);
        if (rs.next()) {
            bookingDetailServiceDto = BookingDetailServiceDto
                    .builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .image(rs.getString("image"))
                    .type(rs.getString("serviceType"))
                    .fee(rs.getDouble("fee"))
                    .typeId(rs.getLong("typeID"))
                    .build();
        }
        return bookingDetailServiceDto;
    }

    @Override
    public BookingDetailDto getBookingDetailById(Long id) throws SQLException {
        BookingDetailDto bookingDetailDto = new BookingDetailDto();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_BOOKING_DETAIL_BY_BOOKING_ID, id);
        if (rs.next()) {
            bookingDetailDto = BookingDetailDto
                    .builder()
                    .date(rs.getDate("date").toLocalDate())
                    .time(rs.getTime("time").toLocalTime())
                    .status(BookingStatusEnum.getBookingStatusString(rs.getInt("statusBooking")))
                    .doctors(Doctors.builder().id(rs.getLong("doctorID")).fullName(rs.getString("doctorName")).build())
                    .employee(Employee.builder().id(rs.getLong("employeeId")).fullName(rs.getString("employeeName")).build())
                    .payment(Payment.builder().status(rs.getBoolean("statusPayment")).type(rs.getInt("type")).build())
                    .decription(rs.getString("decription"))
                    .paymentType(PaymentEnum.getPaymentString(rs.getInt("type")))
                    .build();
        }
        return bookingDetailDto;
    }
}
