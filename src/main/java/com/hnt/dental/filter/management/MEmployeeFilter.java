package com.hnt.dental.filter.management;

import com.hnt.dental.constant.RoleEnum;
import com.hnt.dental.entities.Account;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "MEmployeeFilter", urlPatterns = "/management/employee/*")
public class MEmployeeFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse reqs = (HttpServletResponse) response;

        Account account = (Account) req.getSession().getAttribute("account");
        if (account != null) {
            if (account.getRole() == RoleEnum.ROLE_ADMIN.ordinal()) {
                chain.doFilter(request, response);
            } else {
                reqs.sendRedirect(req.getContextPath() + "/403");
            }
        } else {
            reqs.sendRedirect(req.getContextPath() + "/auth/login");
        }
    }
}
