package com.hnt.dental.dao;

import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.Booking;
import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.BookingResult;

import java.sql.SQLException;
import java.util.List;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface BookingDao extends GenericDao<Booking> {

    List<BookingManagementDto> getAllBookingSummary(int offset, int limit, String search, String serviceId, String status, Long staff, Long doctor) throws SQLException;

    Integer countListBookingSummary(String search, Long staff, Long doctor) throws SQLException;

    List<BookingManagementDto> getServiceByServiceId() throws SQLException;

    BookingDetailPatientDto getPatientByBookingId(Long id) throws SQLException;

    BookingDetailDoctorDto getDoctorByBookingId(Long id) throws SQLException;


    BookingDetailServiceDto getServiceByBookingId(Long id) throws SQLException;

    BookingDetailDto getBookingDetailById(Long id) throws SQLException;

    List<BookingDto> getAllHistory() throws SQLException;

    BookingDto DetailHistory(String id) throws SQLException;

    void updateBookingDetail(Booking bookingDetailDto) throws SQLException;

    void updateBookingResult(BookingResult bookingResult) throws SQLException;

    Long insertBookingId(BookingResult bookingResult) throws SQLException;

    BookingResult getBookingResultById(Long id) throws SQLException;

    Long countBookingDashboard() throws Exception;

    List<DashboardDto> getAllBookingToday() throws SQLException;
    List<StatisticDto> getStatisticBookingTime(String type) throws SQLException;

    void updateStatus(Booking booking);
}
