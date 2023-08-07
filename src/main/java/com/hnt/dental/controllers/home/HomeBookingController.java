package com.hnt.dental.controllers.home;

import com.hnt.dental.exception.SystemRuntimeException;
import com.hnt.dental.service.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "HomeBookingController", value = {
        "/booking",
        "/booking/success",
        "/booking/payment/verify",
        "/booking/payment/cancel",
        "/booking/payment/success"
})
public class HomeBookingController extends HttpServlet {
    private static final BookingService service;

    static {
        service = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        try {
            switch (action) {
                case "/booking":
                    service.renderData(req, resp);
                    break;
                case "/booking/success":
                    req.getRequestDispatcher("/WEB-INF/templates/home/booking/booking-success.jsp").forward(req, resp);
                    break;
                case "/booking/payment/verify":
                    service.paymentCallback(req, resp);
                    break;
                default:
            }
        } catch (Exception e) {
            throw new SystemRuntimeException(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            service.create(req, resp);
        } catch (Exception e) {
            throw new SystemRuntimeException(e.getMessage());
        }
    }
}
