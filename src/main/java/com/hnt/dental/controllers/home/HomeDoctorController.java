package com.hnt.dental.controllers.home;

import com.hnt.dental.entities.Service;
import com.hnt.dental.service.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "HomeDoctorController", value = {
        "/doctor",
        "/doctor/detail"
})
public class HomeDoctorController extends HttpServlet {
    private static final DoctorService service;

    static {
        service = new DoctorService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        switch (action) {
            case "/doctor":
                service.getAll(req, resp);
                break;
            case "/doctor/detail":
                service.getDoctorById(req, resp);
                break;
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO
    }
}
