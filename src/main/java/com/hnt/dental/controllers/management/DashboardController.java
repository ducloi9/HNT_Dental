package com.hnt.dental.controllers.management;

import com.hnt.dental.service.DashboardService;
import com.hnt.dental.service.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "DashboardController", value = {
        "/management/dashboard"

})

public class DashboardController extends HttpServlet {
    private static final DashboardService dashboardService;

    static {
        dashboardService = new DashboardService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            dashboardService.getAll(req, resp);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
    }

