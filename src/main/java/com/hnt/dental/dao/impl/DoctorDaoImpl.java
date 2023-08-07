package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.AccountDao;
import com.hnt.dental.dao.DoctorDao;
import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.*;
import com.hnt.dental.util.ConnectionUtils;
import com.hnt.dental.util.DateUtils;
import org.apache.commons.lang3.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class DoctorDaoImpl implements DoctorDao {

    private static AccountDao accountDao;

    static {
        accountDao = new AccountDaoImpl();
    }

    private static final String SQL_GET_ALL_SERVICE_BY_ID_DOCTOR = "select s.id, s.name, GROUP_CONCAT(st.name SEPARATOR ',')" +
            " as type, CONCAT(MIN(sf.fee), ' ~ ', MAX(sf.fee)) as fee, s.image from service s " +
            "inner join service_doctor sd on sd.id_service = s.id " +
            "inner join doctors d on d.id = sd.id_doctor " +
            "inner join service_fee sf on sf.service_id = s.id " +
            "inner join service_type st on st.id = sf.service_type " +
            "where sd.id_doctor = ? " +
            "group by s.id";
    private static final String SQL_GET_DOCTOR_BY_ID = "select * from doctors " +
            "where id = ?";


    private static final String SQL_GET_SUMMARY = "SELECT" +
            "  d.id," +
            "  d.full_name," +
            "  dr.name AS rank_name," +
            "  d.image," +
            "  LEFT(d.description, 50) AS description " +
            "FROM" +
            "  doctors d" +
            "  INNER JOIN doctor_rank dr ON d.rank_id = dr.id " +
            "WHERE" +
            "   d.full_name LIKE ? " +
            "ORDER BY d.id " +
            "LIMIT ? OFFSET ? ";


    private static final String SQL_COUNT = "SELECT " +
            "  COUNT(*)" +
            "  FROM" +
            "    doctors d" +
            "    INNER JOIN doctor_rank dr ON d.rank_id = dr.id" +
            "    INNER JOIN accounts a ON d.id = a.id" +
            "  WHERE" +
            "    LOWER(d.full_name) LIKE ?" +
            "    OR LOWER(d.position) LIKE ?" +
            "    OR LOWER(dr.name) LIKE ?" +
            "  ORDER BY" +
            "    d.id";

    private static final String SQL_COUNT_DOCTOR = "SELECT " +
            "  COUNT(*)" +
            "  FROM" +
            "    doctors d" +
            "    INNER JOIN doctor_rank dr ON d.rank_id = dr.id" +
            "    INNER JOIN accounts a ON d.id = a.id" +
            "  WHERE" +
            "    (LOWER(d.full_name) LIKE ?" +
            "    OR LOWER(d.position) LIKE ?" +
            "    OR LOWER(dr.name) LIKE ?)" +
            "    AND d.status LIKE ?" +
            "    AND d.gender LIKE ?" +
            "  ORDER BY" +
            "    d.id";
    private static final String SQL_GET_TOP_DOCTOR = "select * from doctors " +
            "ORDER BY RAND() LIMIT 4";


    private static final String GET_ALL_DOCTORS = "SELECT d.id, d.full_name, d.dob, d.gender, d.phone, d.status, d.rank_id, d.description, d.position, a.email, dr.name " +
            "FROM doctors d " +
            "INNER JOIN accounts a ON d.id = a.id " +
            "LEFT JOIN doctor_rank dr ON d.rank_id = dr.id " +
            "WHERE (LOWER(d.full_name) LIKE ? " +
            "OR LOWER(d.position) LIKE ? " +
            "OR LOWER(dr.name) LIKE ?) " +
            "AND d.status LIKE ? " +
            "AND d.gender LIKE ? " +
            "LIMIT ?, ?";


    private static final String GET_DOCTORS_BY_ID = "SELECT * FROM hnt_dental.doctors where id=?";
    private static final String SAVE_DOCTOR = "INSERT INTO hnt_dental.doctors " +
            "(id, full_name, phone, dob, rank_id, position, description, gender, address, status , created_at, updated_at) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String UPDATE_DOCTOR = "UPDATE hnt_dental.doctors " +
            "SET full_name = ?, gender = ?, phone = ?, dob = ?, position = ?, address = ?, description = ?, rank_id = ?,status=?, updated_at = ? " +
            "WHERE id = ?";

    private static final String SQL_UPDATE_BOOKING_STATUS = "UPDATE hnt_dental.booking SET status = ? WHERE id = ?";
    private static final String DELETE_DOCTOR = "DELETE FROM doctors WHERE id=?";

    private static final String MY_PATIENT_DETAIL_QUERY = "SELECT p.id,p.full_name ,b.name, a.email, p.phone, p.gender, p.dob, b.date, b.time ,b.status " +
            "FROM patients p " +
            "INNER JOIN booking b ON b.account_id = p.id " +
            "INNER JOIN doctors d ON d.id = b.staff_id " +
            "JOIN accounts a ON a.id = p.id " +
            "WHERE p.id = ? " +
            "ORDER BY p.id ASC ";

    private static final String SQL_GET_ALL_APPOINTMENT_DOCTOR =
            "SELECT b.id, p.full_name AS patient_full_name, d.full_name, p.id AS patient_id, s.name, b.date, b.time, b.status, p.gender " +
                    "FROM booking b " +
                    "INNER JOIN patients p ON b.account_id = p.id " +
                    "INNER JOIN service s ON b.service_id = s.id " +
                    "LEFT JOIN doctors d ON b.staff_id = d.id " +
                    "LIMIT ?, ?";

    private static final String SQL_GET_APPOINTMENT_DETAILS =
            "SELECT b.id, p.full_name AS patient_full_name, d.full_name, p.id AS patient_id, s.name, b.date, b.time, b.status, p.gender " +
                    "FROM booking b " +
                    "INNER JOIN patients p ON b.account_id = p.id " +
                    "INNER JOIN service s ON b.service_id = s.id " +
                    "LEFT JOIN doctors d ON b.staff_id = d.id " +
                    "WHERE b.id = ?";
    private static final String COUNT_APPOINTMENT = "SELECT COUNT(*) FROM booking b " +
            "INNER JOIN patients p ON b.account_id = p.id " +
            "INNER JOIN service s ON b.service_id = s.id " +
            "JOIN accounts a ON a.id = p.id " +
            "LEFT JOIN doctors d ON b.staff_id = d.id ";
    private static final String MY_PATIENT_DOCTOR_QUERY =
            "SELECT p.id, p.full_name, b.date, b.time,b.status, p.gender, p.dob, b.created_at,b.name, a.email, p.phone " +
                    "FROM patients p " +
                    "JOIN booking b ON b.account_id = p.id " +
                    "JOIN doctors d ON d.id = b.staff_id " +
                    "JOIN accounts a ON a.id = p.id " +
                    "ORDER BY p.id ASC " +
                    "LIMIT ?, ?";

    private static final String SQL_COUNT_DOCTOR_DASHBOARD = "select count(*) from doctors d " +
            "inner join accounts a on d.id = a.id " +
            "where a.is_verified = 1";
    private static final String SQL_GET_PROFILE_DOCTOR = "select d.full_name, d.dob, d.gender, d.address,d.description,d.phone , a.email, a.image from doctors d " +
            "inner join accounts a on a.id = d.id " +
            "where d.id = ?";

    @Override
    public List<Doctors> getAllDoctor(int offset, int limit, String search, String status, String gender) throws SQLException {
        List<Doctors> doctors = new ArrayList<>();
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        status = StringUtils.isNotEmpty(status) ? status : "%";
        gender = StringUtils.isNotEmpty(gender) ? gender : "%";
        ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_DOCTORS, search, search, search, status, gender, offset, limit);
        while (rs.next()) {
            doctors.add(
                    Doctors.builder()
                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            .email(rs.getString("email"))
                                            .build()
                            )
                            .doctorRank(DoctorRank.builder()
                                    .name(rs.getString("name"))
                                    .build())
                            .id(rs.getLong("id"))
                            .fullName(rs.getString("full_name"))
                            .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                            .gender(rs.getBoolean("gender"))
                            .phone(rs.getString("phone"))
                            .description(rs.getString("description"))
                            .position(rs.getString("position"))
                            .rankId(rs.getInt("rank_id"))
                            .status(rs.getBoolean("status"))
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return doctors;
    }


    @Override
    public Integer countGetALLDoctor(String search, String status, String gender) throws SQLException {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        status = StringUtils.isNotEmpty(status) ? status : "%";
        gender = StringUtils.isNotEmpty(gender) ? gender : "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_DOCTOR, search, search, search, status, gender);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    @Override
    public List<BookingDto> getMyAppointments(int offset, int limit) throws SQLException {
        List<BookingDto> MyAppointments = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_APPOINTMENT_DOCTOR, offset, limit);
        while (rs.next()) {
            MyAppointments.add(
                    BookingDto.builder()
                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            .build()
                            )
                            .service(Service.builder()
                                    .name(rs.getString("name"))
                                    .build())
                            .patient(Patient.builder()
                                    .id(rs.getLong("patient_id"))
                                    .fullName(rs.getString("patient_full_name"))
                                    .gender(rs.getBoolean("gender"))
                                    .build())
                            .id(rs.getLong("id"))
                            .date(rs.getDate("date").toLocalDate())
                            .time(rs.getTime("time").toLocalTime())
                            .status(String.valueOf(rs.getBoolean("status") ? 1 : 0))
                            .build()
            );
        }
        return MyAppointments;
    }

    @Override
    public Optional<BookingDto> getAppointmentDetails(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_APPOINTMENT_DETAILS, id);
        assert rs != null;
        if (rs.next()) {
            return Optional.ofNullable(BookingDto.builder()
                    .id(rs.getLong("id"))
                    .date(rs.getDate("date").toLocalDate())
                    .time(rs.getTime("time").toLocalTime())
                    .status(String.valueOf(rs.getBoolean("status") ? 1 : 0))
                    .account(
                            Account.builder()
                                    .id(rs.getLong("id"))
                                    .build())
                    .service(Service.builder()
                            .name(rs.getString("name"))
                            .build())
                    .patient(Patient.builder()
                            .id(rs.getLong("patient_id"))
                            .fullName(rs.getString("patient_full_name"))
                            .gender(rs.getBoolean("gender"))
                            .build())
                    .build());
        }
        ConnectionUtils.closeConnection();
        return Optional.empty();
    }


    private static final String SQL_GET_LIST_DOCTOR_AVAILABLE = "SELECT DISTINCT d.full_name, d.id " +
            "FROM doctors d " +
            "INNER JOIN service_doctor sd ON d.id = sd.id_doctor " +
            "INNER JOIN doctor_rank dr ON dr.id = d.rank_id " +
            "INNER JOIN doctor_of_rank dor ON dor.rank_id = dr.id " +
            "INNER JOIN service_type st ON st.id = dor.type_id " +
            "WHERE sd.id_service = ? " +
            "  AND st.id = ? " +
            "  AND d.id NOT IN (" +
            "    SELECT DISTINCT d .id " +
            "    FROM doctors d " +
            "    INNER JOIN booking b ON d.id = b.doctor_id " +
            "    INNER JOIN service_doctor sd ON d.id = sd.id_doctor " +
            "    INNER JOIN doctor_rank dr ON dr.id = d.rank_id " +
            "    INNER JOIN doctor_of_rank dor ON dor.rank_id = dr.id " +
            "    INNER JOIN service_type st ON st.id = dor.type_id " +
            "    WHERE b.date = ? " +
            "      AND b.time = ? " +
            "      AND b.id <> ? " +
            "  )";
    private static final String GET_PROFILE_BY_ID_SQL = "SELECT * FROM doctors d " +
            "INNER JOIN accounts a ON d.id = a.id " +
            "WHERE d.id = ?";

    @Override
    public List<DoctorSummaryRes> getListDoctorAvailable(LocalDate date, LocalTime time, Long typeId, Long serviceId, Long bookingId) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_LIST_DOCTOR_AVAILABLE, serviceId, typeId, date, time, bookingId);
        List<DoctorSummaryRes> result = new ArrayList<>();
        while (rs.next()) {
            result.add(DoctorSummaryRes.builder()
                    .id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .build());
        }
        return result;
    }

    @Override
    public int countDoctorDashboard() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_DOCTOR_DASHBOARD);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return 0;
    }

    @Override
    public ProfileDto getProfileDoctor(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_PROFILE_DOCTOR, id);
        if (rs.next()) {
            return ProfileDto.builder()
                    .fullName(rs.getString("full_name"))
                    .dob(rs.getDate("dob").toLocalDate())
                    .gender(rs.getBoolean("gender"))
                    .address(rs.getString("address"))
                    .description(rs.getString("description"))
                    .phone("0" + rs.getString("phone"))
                    .email(rs.getString("email"))
                    .image(rs.getString("image"))
                    .build();
        }
        return new ProfileDto();
    }

    public static void main(String[] args) {
        try {
            System.out.println(new DoctorDaoImpl().getProfileDoctor(1L));
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    @Override
    public List<Doctors> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }


    @Override
    public Optional<Doctors> get(int id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(GET_DOCTORS_BY_ID, id);
        assert rs != null;
        if (rs.next()) {
            return Optional.ofNullable(Doctors.builder()
                    .fullName(rs.getString("full_name"))
                    .account(
                            Account.builder()
                                    .id(rs.getLong("id"))
                                    .email("email")
                                    .build())
                    .id(rs.getLong("id"))
                    .phone(rs.getString("phone"))
                    .address(rs.getString("address"))
                    .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                    .gender(rs.getBoolean("gender"))
                    .position(rs.getString("position"))
                    .description(rs.getString("description"))
                    .status(rs.getBoolean("status"))
                    .rankId(rs.getInt("rank_id"))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return Optional.empty();
    }

    public Optional<DoctorDetailDto> getDoctorDetail(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_DOCTOR_BY_ID, id);
        if (rs.next()) {
            return Optional.ofNullable(DoctorDetailDto.builder()
                    .id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .position(rs.getString("position"))
                    .image(rs.getString("image"))
                    .description(rs.getString("description"))
                    .rankName(rs.getString("rank_id"))
                    .dob(rs.getDate("dob"))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return Optional.empty();
    }

    @Override
    public List<ServiceResDto> getAllServiceByIdDoctor(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_SERVICE_BY_ID_DOCTOR, id);
        List<ServiceResDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(ServiceResDto.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .type(rs.getString("type"))
                    .fee(rs.getString("fee"))
                    .image(rs.getString("image"))
                    .build());
        }
        return result;
    }
    @Override
    public List<RankDto> getAllRanks() throws SQLException {
        List<RankDto> ranks = new ArrayList<>();
        String sql = "SELECT id, name FROM doctor_rank WHERE id IN (SELECT DISTINCT rank_id FROM doctors)";

        ResultSet rs = ConnectionUtils.executeQuery(sql);

        while (rs.next()) {
            long id = rs.getLong("id");
            String name = rs.getString("name");
            ranks.add(new RankDto(id, name));
        }

        return ranks;
    }

    @Override
    public Long save(Doctors doctors) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SAVE_DOCTOR, doctors.getAccount().getId(), doctors.getFullName(), doctors.getPhone(),
                (doctors.getDob()), doctors.getRankId(), doctors.getPosition(), doctors.getDescription(), doctors.getGender(),
                doctors.getAddress(), doctors.getStatus(), doctors.getCreatedAt(), doctors.getUpdatedAt());

        return doctors.getAccount().getId();
    }

    @Override
    public void updateBookingStatus(BookingDto booking) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_UPDATE_BOOKING_STATUS, booking.getStatus(), booking.getId());
    }


    @Override
    public List<PatitentsDto> MyPatientDoctor(Integer offset, Integer limit) throws SQLException {
        List<PatitentsDto> patients = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(MY_PATIENT_DOCTOR_QUERY, offset, limit);
        while (rs.next()) {
            patients.add(
                    PatitentsDto.builder()

                            .id(rs.getLong("id"))
                            .fullName(rs.getString("full_name"))
                            .dob(rs.getDate("dob") != null ? DateUtils.convertDateToLocalDate(rs.getDate("dob")) : null)
                            .phone(rs.getString("phone"))
                            .gender(rs.getBoolean("gender"))

                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            .email(rs.getString("email"))
                                            .build()
                            )
                            .booking(
                                    Booking.builder()
                                            .name((rs.getString("name")))
                                            .date(rs.getDate("date").toLocalDate())
                                            .time(rs.getTime("time").toLocalTime())
                                            .status(rs.getBoolean("status") ? 1 : 0)

                                            .build()

                            )
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return patients;
    }

    private static final String MY_PATIENTS_DETAIL_QUERY = "SELECT DISTINCT p.id, p.full_name, b.name, a.email, p.phone, p.gender, p.dob, b.date, b.time, b.status " +
            "FROM patients p " +
            "INNER JOIN booking b ON b.account_id = p.id " +
            "INNER JOIN doctors d ON d.id = b.staff_id " +
            "JOIN accounts a ON a.id = p.id " +
            "WHERE p.id = ? " +
            "ORDER BY p.id ASC " +
            "LIMIT ?, ?";

    @Override
    public List<PatitentsDto> getPatientDetails(Long id, Integer offset, Integer limit) throws SQLException {
        List<PatitentsDto> patient = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(MY_PATIENTS_DETAIL_QUERY, Long.valueOf(id), offset, limit);
        while (rs.next()) {
            patient.add(
                    PatitentsDto.builder()

                            .id(rs.getLong("id"))
                            .fullName(rs.getString("full_name"))
                            .phone(rs.getString("phone"))
                            .gender(rs.getBoolean("gender"))
                            .dob(rs.getDate("dob").toLocalDate())

                            .booking(
                                    Booking.builder()
                                            .date(rs.getDate("date").toLocalDate())
                                            .time(rs.getTime("time").toLocalTime())
                                            .status(rs.getBoolean("status") ? 1 : 0)

                                            .name(rs.getString("name"))
                                            .build()
                            )
                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            .email(rs.getString("email"))
                                            .build()
                            )
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return patient;
    }

    @Override
    public void update(Doctors doctors) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_DOCTOR, doctors.getFullName(), doctors.getGender(), doctors.getPhone(), doctors.getDob(),
                doctors.getPosition(), doctors.getAddress(), doctors.getDescription(), doctors.getRankId(), doctors.getStatus(),
                doctors.getUpdatedAt(), doctors.getAccount().getId());

    }

    @Override
    public void delete(Doctors doctors) throws SQLException {
        accountDao.delete(Account.builder().id(doctors.getId()).build());
        ConnectionUtils.executeUpdate(DELETE_DOCTOR, doctors.getId());
    }

    @Override
    public List<DoctorSummaryRes> getListDoctorSummary(Integer offset, Integer limit, String search) throws SQLException {
        search = "%" + search + "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SUMMARY, search, limit, offset);
        List<DoctorSummaryRes> result = new ArrayList<>();
        while (rs.next()) {
            result.add(DoctorSummaryRes.builder()
                    .id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .rankName(rs.getString("rank_name"))
                    .image(rs.getString("image"))
                    .description(rs.getString("description"))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return result;
    }

    @Override
    public List<DoctorDetailDto> getDoctorDetailDto() throws SQLException {

        return null;
    }

    @Override
    public Integer countListDoctorSummary(String search) throws SQLException {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT, search, search, search);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    @Override
    public Integer countMyAppointments() throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_APPOINTMENT);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    private static final String COUNT_PATIENT = "SELECT COUNT(*) FROM patients p " +
            "JOIN booking b ON b.account_id = p.id " +
            "JOIN doctors d ON d.id = b.staff_id " +
            "JOIN accounts a ON a.id = p.id";

    @Override
    public Integer countPatitent() throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_PATIENT);
        assert rs != null;
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    private static final String COUNT_PATIENT_DETAILS = "SELECT COUNT(*) FROM (" +
            "SELECT DISTINCT p.id " +
            "FROM patients p " +
            "JOIN booking b ON b.account_id = p.id " +
            "JOIN doctors d ON d.id = b.staff_id " +
            "JOIN accounts a ON a.id = p.id " +
            "WHERE p.id = ?" +
            ") AS count_table";

    @Override
    public Integer countPatitentDetails(Long id) throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_PATIENT_DETAILS, id);
        assert rs != null;
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    @Override
    public List<DoctorSummaryRes> getListDoctorAvailable(LocalDate date, LocalTime time, Long typeId, Long serviceId) throws SQLException {
        return null;
    }


    @Override
    public List<DoctorDetailDto> getTopDoctor() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_TOP_DOCTOR);
        List<DoctorDetailDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(DoctorDetailDto.builder()
                    .id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .position(rs.getString("position"))
                    .image(rs.getString("image"))
                    .description(rs.getString("description"))
                    .rankName(rs.getString("rank_id"))
                    .dob(rs.getDate("dob"))
                    .build());
        }
        return result;
    }


    @Override
    public List<MypatientResDto> getPatientDetail(Long id) throws SQLException {
        List<MypatientResDto> patients = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(MY_PATIENT_DETAIL_QUERY, id);
        while (rs.next()) {
            String status = rs.getString("status").equals("1") ? "rejected" : "approved";
            patients.add(
                    MypatientResDto.builder()
                            .id(rs.getLong("id"))
                            .Name(rs.getString("name"))
                            .phone(rs.getString("phone"))
                            .gender(rs.getString("gender"))
                            .dob(rs.getString("dob"))
                            .time(rs.getString("time"))
                            .date(DateUtils.convertLocalDateToString(rs.getDate("date").toLocalDate()))
                            .status(status)
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return patients;
    }


    @Override
    public Account getProfile(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(GET_PROFILE_BY_ID_SQL, id);
        assert rs != null;
        if (rs.next()) {
            return Account.builder()
                    .id(rs.getLong("id"))
                    .email(rs.getString("email"))
                    .password(rs.getString("password"))
                    .role(rs.getInt("role"))
                    .isVerified(rs.getBoolean("is_verified"))
//                    .image(rs.getLong("image"))
                    .doctors(Doctors.builder()
                            .gender(rs.getBoolean("gender"))
                            .fullName(rs.getString("full_name"))
                            .phone(rs.getString("phone"))
                            .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                            .address(rs.getString("address"))
                            .description(rs.getString("description"))
                            .build())
                    .build();
        }
        return null;
    }

}
