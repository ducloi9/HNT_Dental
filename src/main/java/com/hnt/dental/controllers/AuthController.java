
package com.hnt.dental.controllers;

import com.hnt.dental.exception.SystemRuntimeException;
import com.hnt.dental.service.AuthService;
import com.hnt.dental.service.BookingService;
import com.hnt.dental.util.ServletUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AuthController", value = {
        "/auth/login",
        "/auth/register",
        "/auth/logout",
        "/auth/verification",
        "/auth/verification/result",
        "/auth/forgot",
        "/auth/forgot/confirm",
        "/auth/profile",
        "/auth/service-history",
        "/auth/my-appointment",
        "/auth/my-appointment/detail",
        "/auth/my-patient",
        "/auth/patient-booking-history"
        ,"/auth/my-appointment/detail1",
        "/auth/detail-history-booking",
        "/auth/changePassword",


})
@MultipartConfig(maxFileSize = 16177216)
public class AuthController extends HttpServlet {

    private static final AuthService service;

    static {
        service = new AuthService();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        switch (action) {
            case "/auth/login":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/login.jsp");
                break;
            case "/auth/register":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/register.jsp");
                break;
            case "/auth/logout":
                service.logout(req, resp);
                break;
            case "/auth/forgot":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/forgot-password.jsp");
                break;
            case "/auth/forgot/confirm":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/forgot-password-confirm.jsp");
                break;
            case "/auth/verification":
                service.verification(req, resp);
                break;
            case "/auth/verification/result":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/verification-result.jsp");
                break;
            case "/auth/profile":

                try {
                    service.getProfile(req, resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/auth/service-history":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/service-history.jsp");
                break;
            case "/auth/my-patient":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/my-patient.jsp");
                break;
            case "/auth/my-appointment":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/my-appointment.jsp");
                break;
                case "/auth/my-appointment/detail":
                ServletUtils.requestDispatcher(req, resp, "/WEB-INF/templates/home/my-appointment-detail.jsp");
                break;
                default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getServletPath();
        try {
            switch (action) {
                case "/auth/login":
                    service.login(req, resp);
                    break;
                case "/auth/register":
                    service.register(req, resp);
                    break;
                case "/auth/forgot":
                    service.forgot(req, resp);
                    break;
                case "/auth/forgot/confirm":
                    service.forgotConfirm(req, resp);
                    break;
                case "/auth/changePassword":
                    service.changePassword(req, resp);
                    break;
                case "/auth/profile":
                    service.updateProfile(req, resp);
                    break;
                default:
            }
        } catch (SQLException e) {
            throw new SystemRuntimeException("Server error: " + e.getMessage());
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}

