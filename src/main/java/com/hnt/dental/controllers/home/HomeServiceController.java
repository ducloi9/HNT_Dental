package com.hnt.dental.controllers.home;

import com.hnt.dental.service.ServiceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "HomeServiceController", value = {
        "/service",
        "/service/detail"
})
public class HomeServiceController extends HttpServlet {

    private static final ServiceService service;

    static {
        service = new ServiceService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        switch (action) {
            case "/service":
                try {
                    service.getAll(req, resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/service/detail":
                try {
                    service.getServiceById(req, resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String action = req.getServletPath();
//        switch (action) {

    }
}
