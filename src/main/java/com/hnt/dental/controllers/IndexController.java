package com.hnt.dental.controllers;

import com.hnt.dental.dto.response.DoctorDetailDto;
import com.hnt.dental.dto.response.ServiceDetailDto;
import com.hnt.dental.dto.response.ServiceSearchHomeDto;
import com.hnt.dental.service.DoctorService;
import com.hnt.dental.service.ServiceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "IndexController", value = {
        "/home",
        "/home/htnDental"
})
public class IndexController extends HttpServlet {
    private static final ServiceService service;
    private static final DoctorService doctorService;

    static {
        service = new ServiceService();
        doctorService = new DoctorService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        switch (action) {
            case "/home":
                try {
                    List<ServiceSearchHomeDto> sevices =  service.getAllServiceHome();
                    List<ServiceDetailDto> topService = service.getTopService();
                    List<DoctorDetailDto> topDoctor = doctorService.getTopDoctor();
                    req.setAttribute("services", sevices);
                    req.setAttribute("topService", topService);
                    req.setAttribute("topDoctor", topDoctor);
                    req.getRequestDispatcher("/WEB-INF/templates/home/index.jsp").forward(req, resp);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/home/htnDental":
                req.getRequestDispatcher("/WEB-INF/templates/home/htn-dental.jsp").forward(req, resp);
                break;
            default:
        }
    }
}
