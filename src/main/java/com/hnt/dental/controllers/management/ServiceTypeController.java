package com.hnt.dental.controllers.management;

import com.hnt.dental.service.ServiceTypeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ServiceTypeController", value = {
        "/management/type",
        "/management/type/create",
        "/management/type/update",
        "/management/type/detail",
        "/management/type/delete",
        "/management/type/type",
        "/management/type/deletemain",
})
public class ServiceTypeController extends HttpServlet {
    private static final ServiceTypeService service;

    static {
        service = new ServiceTypeService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        System.out.println(action);
        if (action.equals("/management/type")) {
            try {
                service.getAllServiceType(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }else if (action.equals("/management/type/detail")) {
            try {
                service.getServiceTypeDetail(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }else if (action.equals("/management/type/delete")) {
            try {
                service.deleteRankOfType(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else if (action.equals("/management/type/deletemain")) {
            try {
                service. deleteServiceType(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        System.out.println(action);
        if (action.equals("/management/type/create")) {
            try {
                service.createServiceType(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else if (action.equals("/management/type/detail")) {
            try {
                service.updateRankOfType(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }else if (action.equals("/management/type/update")) {
            try {
                service. updateServiceType(req, resp);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
}
