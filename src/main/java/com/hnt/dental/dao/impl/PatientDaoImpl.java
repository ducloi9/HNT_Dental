package com.hnt.dental.dao.impl;

import com.hnt.dental.constant.BookingStatusEnum;
import com.hnt.dental.dao.AccountDao;
import com.hnt.dental.dao.PatientDao;
import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Patient;
import com.hnt.dental.util.ConnectionUtils;
import com.hnt.dental.util.DateUtils;
import org.apache.commons.lang3.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PatientDaoImpl implements PatientDao {
    private static AccountDao accountDao;

    static {
        accountDao = new AccountDaoImpl();
    }

    private static final String SAVE_PATIENT = "INSERT INTO patients" +
            "(id,dob, full_name, gender, phone, address)  " +
            "VALUES(?, ?, ?, ?, ?, ?)";

    private static final String DETAIL_PATIENT = "SELECT p.id, p.full_name, p.dob, p.gender,p.address,p.description ,p.phone,p.status,a.email  " +
            "                       FROM patients p inner join  accounts a on p.id = a.id " +
            "                      where p.id = ?";
    private static final String DELETE_PATIENT = "DELETE FROM patients " +
            "WHERE id=?";
    private static final String CREATE_PATIENT = "INSERT INTO patients " +
            "            ( id,full_name, dob, gender, phone, address,created_at) " +
            "            VALUES(?,?,?,?,?,?,?)  ";

    private static final String UPDATE_PATIENT = "UPDATE patients " +
            "           SET full_name=?, dob=?, gender=?, phone=?, address=?, description=?,status=?,created_at=?, updated_at=? " +
            "                      WHERE id=?";
    private static final String GET_PATIENT_BY_ID = "SELECT * FROM patients where id =?";
    private static final String GET_ALL_PATIENTS = "SELECT a.id, p.full_name, p.dob,p.gender,p.status " +
            "FROM patients p " +
            "INNER JOIN accounts a ON p.id = a.id " +
            "WHERE LOWER(p.full_name) LIKE ? " +
            "OR LOWER(a.email) LIKE ? " +
            "OR LOWER(p.dob) LIKE ? " +
            "LIMIT ?, ?";
    private static final String COUNT_PATIENT = "SELECT COUNT(*) FROM patients p " +
            "INNER JOIN accounts a ON p.id = a.id " +
            "WHERE LOWER(p.full_name) LIKE ? " +
            "OR LOWER(a.email) LIKE ? " +
            "OR LOWER(p.dob) LIKE ? ";
    private static final String SQL_COUNT_PATIENT_DASHBOARD = "select count(*) from patients p " +
            "inner join accounts a on p.id = a.id " +
            "where a.is_verified = 1";

    @Override
    public Patient DetailPatients(String id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(DETAIL_PATIENT, id);
        assert rs != null;
        if (rs.next()) {
            return (Patient.builder().account(Account.builder()
                            .email(rs.getString("email"))
                            .build())
                    .id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .dob(rs.getDate("dob").toLocalDate())
                    .gender(rs.getBoolean("gender"))
                    .description(rs.getString("description"))
                    .phone(String.valueOf(rs.getInt("phone")))
                    .address(rs.getString("address"))
                    .status(Boolean.parseBoolean(rs.getString("status")))
                    .build());
        }
        return null;

    }

    @Override
    public List<Patient> getAll(Integer offset, Integer limit) throws SQLException {
        return null;
    }

    @Override
    public List<Patient> getAll(Integer offset, Integer limit, String search) throws SQLException {
        List<Patient> patients = new ArrayList<>();
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_PATIENTS, search, search, search, offset, limit);
        while (rs.next()) {
            patients.add(
                    Patient.builder()
                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            //.email(rs.getString("email"))
                                            .build()
                            )
                            .fullName(rs.getString("full_name"))
                            .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                            .gender(rs.getBoolean("gender"))
                            .status(rs.getBoolean("status"))
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return patients;
    }

    @Override
    public Optional<Patient> get(int id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(GET_PATIENT_BY_ID, id);
        assert rs != null;
        if (rs.next()) {
            return Optional.ofNullable(Patient.builder()
                    .fullName(rs.getString("full_name"))
                    .account(Account.builder()
                            .email("email")
                            .build())
                    .phone(rs.getString("phone"))
                    .address(rs.getString("address"))
                    .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                    .gender(rs.getBoolean("gender"))
                    .description(rs.getString("description"))

                    .build());
        }
        ConnectionUtils.closeConnection();
        return Optional.empty();
    }


    @Override
    public Long save(Patient patient) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(CREATE_PATIENT, patient.getAccount().getId(), patient.getFullName(), patient.getDob(),
                patient.getGender(), patient.getPhone(), patient.getAddress(), patient.getCreatedAt());
        return null;
    }

    @Override
    public void update(Patient patient) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_PATIENT, patient.getFullName(),
                patient.getDob(), patient.getGender(), patient.getPhone(), patient.getAddress(), patient.getDescription(), patient.getStatus(), patient.getCreatedAt(), patient.getUpdatedAt(),
                patient.getAccount().getId());
    }

    @Override
    public void delete(Patient patient) throws SQLException {
        accountDao.delete(Account.builder().id(patient.getId()).build());
        ConnectionUtils.executeUpdate(DELETE_PATIENT, patient.getId());
    }

    @Override
    public Integer count(String search) throws Exception {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_PATIENT, search, search, search);
        assert rs != null;
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    private static final String COUNT_APPOINTMENT = "SELECT COUNT(*) FROM booking b " +
            "                        JOIN service s JOIN service_type st ON b.service_id = s.id AND b.service_type_id = st.id";

    private static final String GET_PROFILE_PATIENT = "SELECT p.full_name, p.dob, p.gender,p.address,p.description, p.phone,a.email, a.image FROM hnt_dental.patients p " +
            "inner join accounts a on a.id = p.id " +
            "where p.id = ? ";

    private static final String HISTORY_APPOINTMENT = "SELECT b.time,b.id, b.status ,b.date ,s.name,st.name as type " +
            "                                                        FROM booking b " +
            "                                                         INNER JOIN service s  " +
            "                                                         INNER JOIN service_type st " +
            "                                                         ON b.service_id = s.id  " +
            "                                                         AND b.service_type_id = st.id " +
            "                                                     where b.account_id=?";


    @Override
    public List<BookingDto> getAppointment(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(HISTORY_APPOINTMENT, id);
        assert rs != null;
        List<BookingDto> list = new ArrayList<>();
        while (rs.next()) {
            list.add(BookingDto.builder().serviceResDto(ServiceResDto.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .build()).serviceTypeDto(ServiceTypeDto.builder()
                            .nameType(rs.getString("type"))
                            .build())
                    .date(rs.getDate("date").toLocalDate())
                    .status(BookingStatusEnum.getBookingStatusString(rs.getInt("status")))
                    .id(rs.getLong("id"))
                    .time(rs.getTime("time").toLocalTime())
                    .build());
        }
        return list;
    }

    @Override
    public Integer countAppointment() throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_APPOINTMENT);
        assert rs != null;
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }


    private static final String DETAIL_APPOINTMENT = "SELECT b.id, b.date, b.name, b.status, b.time, b.account_id, br.result, b.doctor_id, b.service_id " +
            "FROM booking b " +
            "LEFT JOIN booking_result br ON b.id = br.booking_id " +
            "WHERE b.id = ?";

    @Override
    public BookingDto detailAppointment(String id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(DETAIL_APPOINTMENT, id);
        assert rs != null;
        if (rs.next()) {
            return (BookingDto.builder().bookingResultDto(BookingResultDto.builder()
                            .result(rs.getString("result"))
                            .build())
                    .id(rs.getLong("id"))
                    //.status(String.valueOf(rs.getBoolean("status")))
                    .name(rs.getString("name"))
                    .time(rs.getTime("time").toLocalTime())
                    .account_id(rs.getInt("account_id"))
                    .date(rs.getDate("date").toLocalDate())
                    .status(BookingStatusEnum.getBookingStatusString(rs.getInt("status")))
                    .doctor_id(rs.getInt("doctor_id"))  // Set the doctor_id
                    .service_id(rs.getInt("service_id")) // Set the service_id
                    .build());
        }
        return null;
    }

    private static final String SAVE_SERVICE_FEEDBACK = "INSERT INTO feedback " +
            "( booking_id, service_id, star, description, created_at, updated_at, is_show) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";

    private static final String SAVE_DOCTOR_FEEDBACK = "INSERT INTO feedback " +
            "( booking_id, doctor_id, star, description, created_at, updated_at, is_show) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";


    @Override
    public void saveServiceReview(Long id, Integer service_id, int star, String description) throws SQLException {
        LocalDateTime now = LocalDateTime.now();
        try {
            ConnectionUtils.executeUpdate(
                    SAVE_SERVICE_FEEDBACK,
                    id,
                    service_id,
                    star,
                    description,
                    Timestamp.valueOf(now),
                    Timestamp.valueOf(now),
                    true
            );
        } catch (SQLException e) {
            // Handle the exception appropriately, e.g., log the error or throw a custom exception
            e.printStackTrace();
            throw new SQLException("Failed to save service feedback: " + e.getMessage());
        }
    }

    @Override
    public void saveDoctorReview(Long id, Integer doctor_id, int star, String description) throws SQLException {
        LocalDateTime now = LocalDateTime.now();
        try {
            ConnectionUtils.executeUpdate(
                    SAVE_DOCTOR_FEEDBACK,
                    id,
                    doctor_id,
                    star,
                    description,
                    Timestamp.valueOf(now),
                    Timestamp.valueOf(now),
                    true
            );
        } catch (SQLException e) {
            // Handle the exception appropriately, e.g., log the error or throw a custom exception
            e.printStackTrace();
            throw new SQLException("Failed to save service feedback: " + e.getMessage());
        }
    }
    
    private static final String HISTORY_SERVICE = " SELECT  " +
            " s.id, s.name, st.name as 'type', sf.fee, b.status " +
            "FROM  " +
            " service s  " +
            "    INNER JOIN booking b on s.id = b.service_id " +
            "    INNER JOIN service_fee sf on ( b.service_type_id = sf.service_type AND b.service_id = sf.service_id) " +
            "    INNER JOIN service_type st on sf.service_type = st.id " +
            "WHERE b.account_id = ?";

    @Override
    public List<BookingDto> getService(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(HISTORY_SERVICE, id);
        assert rs != null;
        List<BookingDto> list = new ArrayList<>();
        while (rs.next()) {
            list.add(BookingDto.builder()
                    .serviceResDto(ServiceResDto.builder()
                            .name(rs.getString("name"))
                            .build()).serviceTypeDto(ServiceTypeDto.builder()
                            .nameType(rs.getString("type"))
                            .build()).serviceFeeDto(ServiceFeeDto.builder()
                            .fee(rs.getDouble("fee"))
                            .build())
                    .status(BookingStatusEnum.getBookingStatusString(rs.getInt("status")))
                    .service_id(rs.getInt("id"))
                    .build());
        }
        return list;
    }


    private static final String MY_PATIENT_OF_DOCTOR = "SELECT b.name ,b.gender ,b.id, b.date,b.age,s.name ,st.name as type " +
            "                                                              FROM booking b " +
            "                                                               INNER JOIN service s  " +
            "                                                                 INNER JOIN service_type st " +
            "                                                                ON b.service_id = s.id  " +
            "                                                              AND b.service_type_id = st.id " +
            "                                                             WHERE LOWER(b.name) LIKE ?  " +
            "                                                             OR LOWER(b.age) LIKE ? " +
            "                                                            OR LOWER(b.date) LIKE ? " +
            "     LIMIT ?,?";

    @Override
    public List<BookingDto> getMyPatient(Integer offset, Integer limit, String search) throws SQLException {
        List<BookingDto> list = new ArrayList<>();
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(MY_PATIENT_OF_DOCTOR, search, search, search, offset, limit);
        while (rs.next()) {
            list.add(
                    BookingDto
                            .builder().serviceResDto(ServiceResDto.builder()
                                    //.id(rs.getLong("id"))
                                    .name(rs.getString("name"))
                                    .build()).serviceTypeDto(ServiceTypeDto.builder()
                                    .nameType(rs.getString("type"))
                                    .build())
                            .date(rs.getDate("date").toLocalDate())
                            .gender(rs.getBoolean("gender"))
                            .age(rs.getInt("age"))
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return list;
    }


    @Override
    public Long countPatientDashboard() throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_PATIENT_DASHBOARD);
        assert rs != null;
        if (rs.next()) {
            return rs.getLong(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    @Override
    public ProfileDto getProfile(Long id) throws SQLException {
        ResultSet resultSet = ConnectionUtils.executeQuery(GET_PROFILE_PATIENT, id);
        if (resultSet.next()) {
            return ProfileDto.builder()
                    .fullName(resultSet.getString("full_name"))
                    .email(resultSet.getString("email"))
                    .phone("0" + resultSet.getString("phone"))
                    .dob(resultSet.getDate("dob").toLocalDate())
                    .address(resultSet.getString("address"))
                    .description(resultSet.getString("description"))
                    .image(resultSet.getString("image"))
                    .build();
        }
        return new ProfileDto();
    }

    @Override
    public Patient updatePatient(Patient patient) throws SQLException {
        return null;
    }

}