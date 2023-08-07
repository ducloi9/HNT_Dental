package com.hnt.dental.dao;

import com.hnt.dental.dto.response.BlogResDto;
import com.hnt.dental.entities.Blogs;
import com.hnt.dental.entities.CategoryBlog;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


public interface BlogDao extends GenericDao<Blogs> {




    void changeStatus(int id, String status) throws SQLException;

    List<Blogs> getAllBlog(int offset, int limit, String search, String status, String category) throws SQLException;

    Integer countListBlogSummary(String search,String status, String category) throws SQLException;

    Blogs getBlogID(int id) throws Exception;

    List<CategoryBlog> getListCategoryBlog() throws SQLException;

    List<BlogResDto> getListBlogRelated(long id, long categoryId ) throws SQLException;

    List<Blogs> RecentPosts() throws Exception;

    Integer countListBlogs(String search) throws SQLException;

    List<BlogResDto> getListBlogsFilter(Integer offset, Integer limit, String search, String oder, Integer categoryId ) throws SQLException;
}
