package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.CategoryBlogDao;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Blogs;
import com.hnt.dental.entities.CategoryBlog;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.util.ConnectionUtils;
import org.apache.commons.lang3.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CategoryBlogDaoImpl implements CategoryBlogDao {

    private static final String FIND_BY_NAME_SQL = "SELECT * FROM category_blog WHERE name like ?";
    private static final String GET_ALL_CATEGORYBLOG = "SELECT * FROM category_blog";
    private static final String GET_CATEGORYBLOG = "SELECT * FROM category_blog cb inner join blogs b on cb.id = b.category_id where b.id = ?";
    private static final String SAVE_CATEGORYBLOG = "INSERT category_blog " +
            "( name, created_at, updated_at) " +
            "VALUES( ?, ?, ?)";
    private static final String UPDATE_CATEGORYBLOG = "  UPDATE category_blog " +
            "SET name = ?, created_at = ?, updated_at = ? " +
            "WHERE (id = ?)";

    private static final String DELETE_CATEGORYBLOG = "DELETE FROM category_blog " +
            "            WHERE id=?";

    @Override
    public List<CategoryBlog> getAll(Integer offset, Integer limit, String search) throws SQLException {
        search = StringUtils.isNotEmpty(search) ? "%" + search + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_CATEGORYBLOG,search);
        List<CategoryBlog> list = new ArrayList<>();
        while (true) {
            assert rs != null;
            if (!rs.next()) break;
            list.add(CategoryBlog.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return list;
    }

    @Override
    public Optional<CategoryBlog> get(int id) throws SQLException {
        try {
            ResultSet rs = ConnectionUtils.executeQuery(GET_CATEGORYBLOG, id);
            assert rs != null;
            if (rs.next()) {
                return Optional.ofNullable(CategoryBlog.builder()
                        .id(rs.getLong("id"))
                        .name(rs.getString("name"))
                        .build());
            }
            ConnectionUtils.closeConnection();
        } catch (Exception e) {
            System.out.println("get:" + e);
        }
        return Optional.empty();
    }

    @Override
    public Long save(CategoryBlog categoryBlog) throws SQLException, ClassNotFoundException {
        return ConnectionUtils.executeUpdateForIdentity(SAVE_CATEGORYBLOG, categoryBlog.getName(),
                categoryBlog.getCreatedAt(), categoryBlog.getUpdatedAt());
    }

    @Override
    public void update(CategoryBlog categoryBlog) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_CATEGORYBLOG, categoryBlog.getName(),
                categoryBlog.getCreatedAt(), categoryBlog.getUpdatedAt(), categoryBlog.getId());
    }

    @Override
    public void delete(CategoryBlog categoryBlog) throws SQLException {
        ConnectionUtils.executeUpdate(DELETE_CATEGORYBLOG,categoryBlog.getId());
    }

    @Override
    public CategoryBlog findByName(String name) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(FIND_BY_NAME_SQL, name);
        assert rs != null;
        if (rs.next()) {
            return CategoryBlog.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .build();
        }
        return null;
    }

    @Override
    public List<CategoryBlog> getAll() throws SQLException {
        List<CategoryBlog> list = new ArrayList<>();
        try{
            ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_CATEGORYBLOG);
            while (true) {
                assert rs != null;
                if (!rs.next()) break;
                list.add(CategoryBlog.builder()
                        .id(rs.getLong("id"))
                        .name(rs.getString("name"))
                        .build());
            }
            ConnectionUtils.closeConnection();
        }
        catch (Exception ex){
            System.out.println("getAll:" + ex);
        }



        return list;
    }
}
