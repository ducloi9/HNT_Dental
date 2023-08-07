package com.hnt.dental.dao;

import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Doctors;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

public interface DoctorDao extends GenericDao<Doctors> {

    List<DoctorSummaryRes> getListDoctorSummary(Integer offset, Integer limit, String search) throws SQLException;
    List<DoctorDetailDto> getDoctorDetailDto() throws SQLException;
    Optional<DoctorDetailDto> getDoctorDetail(Long id) throws SQLException;
    List<ServiceResDto> getAllServiceByIdDoctor(Long id) throws SQLException;
    Integer countListDoctorSummary(String search) throws SQLException;
    Integer countMyAppointments() throws Exception;
    List<DoctorDetailDto> getTopDoctor() throws SQLException;
    List<MypatientResDto> getPatientDetail(Long id)throws SQLException;

    List<Doctors> getAllDoctor(int offset, int limit,  String search, String status, String gender) throws SQLException;
    List<BookingDto> getMyAppointments(int offset, int limit) throws SQLException;
    Optional<BookingDto> getAppointmentDetails(Long id) throws SQLException;

      void  updateBookingStatus(BookingDto booking) throws SQLException;
    List<PatitentsDto> MyPatientDoctor(Integer offset, Integer limit) throws SQLException;
    List<PatitentsDto> getPatientDetails(Long id, Integer offset, Integer limit) throws SQLException;
    Integer countPatitent() throws Exception;

    Integer countPatitentDetails(Long id) throws Exception;

    List<DoctorSummaryRes> getListDoctorAvailable(LocalDate date, LocalTime time, Long typeId, Long serviceId) throws SQLException;
    Integer countGetALLDoctor(String search, String status, String gender) throws SQLException;

    Account getProfile(Long id) throws SQLException;

    List<DoctorSummaryRes> getListDoctorAvailable(LocalDate date, LocalTime time, Long typeId, Long serviceId, Long bookingId) throws SQLException;

    int countDoctorDashboard() throws SQLException;

    ProfileDto getProfileDoctor(Long id) throws SQLException;
    List<RankDto> getAllRanks() throws SQLException;
}
