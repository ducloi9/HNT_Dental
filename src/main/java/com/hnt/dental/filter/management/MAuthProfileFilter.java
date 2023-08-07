package com.hnt.dental.filter.management;

import com.hnt.dental.constant.RoleEnum;
import com.hnt.dental.entities.Account;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "MAuthProfileFilte", urlPatterns = "/auth/profile")
public class MAuthProfileFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        Account account = (Account) req.getSession().getAttribute("account");

        if (account != null) {
                chain.doFilter(request, response);
            }
         else {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
        }
    }
}
