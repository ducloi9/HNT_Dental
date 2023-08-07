package com.hnt.dental.service;

import com.hnt.dental.dao.*;
import com.hnt.dental.dao.impl.*;
import com.hnt.dental.dto.response.DashboardDto;
import com.hnt.dental.dto.response.StatisticDto;
import com.hnt.dental.entities.Patient;
import com.hnt.dental.util.ServletUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public class DashboardService {
    private static final DoctorDao dao;
    private static final PatientDao patient;
private static final BookingDao booking;
private static final PaymentDao payment;
    static {
        dao = new DoctorDaoImpl();
        patient = new PatientDaoImpl();
        booking = new BookingDaoImpl();
        payment = new PaymentDaoImpl();

    }

    public void getAll(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String type = req.getParameter("type") == null ? "7" : req.getParameter("type");
        int countDoctor = dao.countDoctorDashboard();
        Long countPatient = patient.countPatientDashboard();
        Long countBooking = booking.countBookingDashboard();
        Double countRevenue = payment.countRevenue();
        List<StatisticDto> getStatisticBookingTime = booking.getStatisticBookingTime(type);
        List<DashboardDto> getBookingToday = booking.getAllBookingToday();
        String countRevenueString = String.format("%,.0f", countRevenue);
        req.setAttribute("countDoctor", countDoctor);
        req.setAttribute("countPatient", countPatient);
        req.setAttribute("getStatisticBookingTime", getStatisticBookingTime);
        req.setAttribute("countBooking", countBooking);
        req.setAttribute("countRevenue", countRevenueString);
        req.setAttribute("getBookingToday", getBookingToday);
        ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/management/dashboard/index.jsp");
    }
}
