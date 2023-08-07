package com.hnt.dental.controllers.home;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "HomePaymentController", value = {
        "/payment",
        "/payment/success",
        "/payment/error",
})
public class HomePaymentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getServletPath();
        switch (action) {
            case "/payment/success":
                req.getRequestDispatcher("/WEB-INF/templates/home/payment/payment-success.jsp").forward(req, resp);
                break;
            case "/payment/error":
                req.getRequestDispatcher("/WEB-INF/templates/home/payment/payment-error.jsp").forward(req, resp);
                break;
            default:
        }

    }
}
