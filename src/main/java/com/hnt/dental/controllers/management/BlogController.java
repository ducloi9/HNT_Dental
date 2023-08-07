package com.hnt.dental.controllers.management;

import com.hnt.dental.dao.CategoryBlogDao;
import com.hnt.dental.dao.impl.CategoryBlogDaoImpl;
import com.hnt.dental.entities.CategoryBlog;
import com.hnt.dental.service.BlogService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "BlogController", value = {
        "/management/blog",
        "/management/blog/create",
        "/management/blog/update",
        "/management/blog/delete"
})
@MultipartConfig
public class BlogController extends HttpServlet {

    private static final BlogService blogService;

    static {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getServletPath();
        try {
            switch (action) {
                case "/management/blog":
                    blogService.getAllManagement(req, resp);
//        req.getRequestDispatcher("/WEB-INF/templates/management/blogs/index.jsp").forward(req, resp);

                    break;
                case "/management/blog/create":
                    CategoryBlogDaoImpl cateblog = new CategoryBlogDaoImpl();
                    req.setAttribute("cate_list",cateblog.getAll());
                    req.getRequestDispatcher("/WEB-INF/templates/management/blogs/create.jsp").forward(req, resp);
                    break;
                case "/management/blog/update":
                    blogService.updateRender(req, resp);
                    break;
                case "/management/blog/delete":
                    blogService.delete(req, resp);
                    break;
                default:
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //        req.getRequestDispatcher("/WEB-INF/templates/management/blogs/blog_detail.jsp").forward(req, resp);
//    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        try {
            switch (action) {
                case "/management/blog/create":
                    blogService.create(req, resp);
                    break;
                case "/management/blog/update":
                    blogService.update(req, resp);
                    break;
                default:
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
