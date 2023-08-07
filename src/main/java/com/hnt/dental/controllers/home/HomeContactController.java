package com.hnt.dental.controllers.home;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "HomeContactController", value = {
        "/contact",
        "/contact/detail"
})
public class HomeContactController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        switch (action) {
            case "/contact":
                req.getRequestDispatcher("/WEB-INF/templates/home/contact.jsp").forward(req, resp);
                break;
            case "/contact/detail":
                req.getRequestDispatcher("/WEB-INF/templates/home/contact/detail.jsp").forward(req, resp);
                break;
            default:
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
