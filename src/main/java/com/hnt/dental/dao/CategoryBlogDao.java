package com.hnt.dental.dao;

import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.CategoryBlog;

import java.sql.SQLException;
import java.util.List;

public interface CategoryBlogDao  extends GenericDao<CategoryBlog>{

    CategoryBlog findByName(String name) throws SQLException;
    List<CategoryBlog> getAll() throws SQLException;


}
