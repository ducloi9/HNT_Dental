package com.hnt.dental.controllers.management;

import com.hnt.dental.entities.Account;
import com.hnt.dental.util.ServletUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "IndexControllerManagement", value = "/management-router")
public class IndexController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        System.out.println(action);
        Account account = (Account) req.getSession().getAttribute("account");
        switch (account.getRole()) {
            case 1:
                ServletUtils.redirect(req, resp, "/management/dashboard");
                break;
            case 2:
            case 4:
                ServletUtils.redirect(req, resp, "/management/booking");
                break;
            case 3:
                ServletUtils.redirect(req, resp, "/management/doctor");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/403");
                break;
        }
    }
}
