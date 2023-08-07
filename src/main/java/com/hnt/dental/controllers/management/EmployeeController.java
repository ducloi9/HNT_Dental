package com.hnt.dental.controllers.management;

import com.hnt.dental.service.EmployeeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "EmployeeController", value = {
        "/management/employee",
        "/management/employee/create",
        "/management/employee/update",
        "/management/employee/delete"
})
@MultipartConfig(maxFileSize = 16177216) // Copy Upload
public class EmployeeController extends HttpServlet {

    private static final EmployeeService employeeService;

    static {
        employeeService = new EmployeeService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        try {
            switch (action) {
                case "/management/employee":
                    employeeService.getAll(req, resp);
                    break;
                case "/management/employee/create":
                    req.getRequestDispatcher("/WEB-INF/templates/management/employee/create.jsp").forward(req, resp);
                    break;
                case "/management/employee/update":
                    employeeService.updateRender(req, resp);
                    break;
                case "/management/employee/delete":
                    employeeService.delete(req, resp);
                    break;
                default:
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        try {
            switch (action) {
                case "/management/employee/create":
                    employeeService.create(req, resp);
                    break;
                case "/management/employee/update":
                    employeeService.update(req, resp);
                    break;
                default:
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
