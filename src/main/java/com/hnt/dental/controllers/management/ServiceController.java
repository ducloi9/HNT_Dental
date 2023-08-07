package com.hnt.dental.controllers.management;

import com.hnt.dental.service.BookingService;
import com.hnt.dental.service.ServiceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ServiceController", value = {
        "/management/service",
        "/management/service/create",
        "/management/service/update",
        "/management/service/detail",
        "/management/service/type",
        "/management/service/createFee",
        "/management/service/updateFee",
        "/management/service/type/detail",
        "/management/service/delete",
        "/management/service/deleteDoctor"
})
public class ServiceController extends HttpServlet {
    private static final ServiceService service;


    static {
        service = new ServiceService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        System.out.println(action);
        switch (action) {
            case "/management/service":
                try {
                    service.getAllServiceManagement(req, resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/management/service/detail":
                try {
                    service.getServiceDetailManagement(req, resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/management/service/create":
                try {
                    req.getRequestDispatcher("/WEB-INF/templates/management/service/create.jsp").forward(req, resp);

                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                //req.getRequestDispatcher("/WEB-INF/templates/management/service/create.jsp").forward(req, resp);
                break;
            case "/management/service/delete":
                req.getRequestDispatcher("/WEB-INF/templates/management/service/delete.jsp").forward(req, resp);
                break;
            case "/management/service/type":
                req.getRequestDispatcher("/WEB-INF/templates/management/service/serviceType.jsp").forward(req, resp);
                break;
            case "/management/service/deleteDoctor":
                try {
                    service.deleteDoctor(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        System.out.println(action);
        if (action.equals("/management/service/update")) {
            try {
                service.updateServiceDetailManagement(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else if (action.equals("/management/service/create")) {
            try {
                service.createServiceDetailManagement(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else if (action.equals("/management/service/createFee")) {
            try {
                service.updateFeeByServiceId(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else if (action.equals("/management/service/updateFee")) {
            try {
                service.updateFee(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
}
