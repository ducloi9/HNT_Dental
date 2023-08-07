package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.BlogDao;
import com.hnt.dental.dao.CategoryBlogDao;
import com.hnt.dental.dto.response.BlogResDto;
import com.hnt.dental.entities.Blogs;
import com.hnt.dental.entities.CategoryBlog;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.util.ConnectionUtils;
import org.apache.commons.lang3.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class BlogDaoImpl implements BlogDao {
    private static CategoryBlogDao categoryBlogDao;

    static {
        categoryBlogDao = new CategoryBlogDaoImpl();
    }
    private static final String GET_ALL_BLOG = "SELECT b.id, b.category_id, b.title, b.brief, b.description, b.create_at, " +
            " b.update_at, b.created_by, b.status " +
            ",e.full_name,cb.name FROM blogs b inner join employees e " +
            "on e.id = b.created_by inner join category_blog cb on b.category_id = cb.id " +
            "where b.title like ?" +
            "LIMIT ?,?";
    private static final String SQL_COUNT_BLOG = "SELECT count(*) FROM blogs b " +
            "                                   inner join category_blog cb on b.category_id = cb.id " +
            "                                  where LOWER(b.title) like ?  AND b.status LIKE ? " +
            "                     AND b.category_id LIKE ?" +
            " order by b.id";
    private static final String SQL_GET_CATEGORY_BY_CATEGORY_ID = "select DISTINCT cb.name, cb.id from blogs b " +
            "            inner join category_blog cb on b.category_id = cb.id;";
    private static final String GET_BLOG_BY_ID = "SELECT b.id,b.image," +
            " b.category_id, b.title, b.brief, b.description, b.create_at, " +
            " b.update_at, b.status " +
            ",cb.name FROM blogs b inner join " +
            "category_blog cb on b.category_id = cb.id " +
            "where (1=1) and b.id = ? ";
    private static final String SAVE_BLOG = "INSERT INTO blogs " +
            "(id, category_id, title, brief, description, create_at, status,image) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_BLOG = "UPDATE blogs" +
            "            SET category_id=?, title= ?,brief= ?, description=?, create_at=?,  update_at= ?" +
            ", status = ?" +
            "            WHERE id = ?";
    private static final String CHANGE_status = "UPDATE blogs " +
            "SET " +
            "`status` = ? " +
            "WHERE `id` = ?";
    private static final String DELETE_BLOG = "DELETE FROM blogs WHERE id=?";
    private static final String GET_CATEGORYBLOG = "SELECT distinct category_id FROM blogs";
    private static final String GET_ALL_BLOGS = " SELECT b.id, b.image,  b.category_id ," +
            "            b.title, b.brief, b.description, b.create_at, b.update_at," +
            "            b.created_by, b.status, e.full_name, cb.name " +
            "            FROM blogs b " +
            "            INNER JOIN category_blog cb ON b.category_id = cb.id " +
            "            LEFT JOIN employees e ON b.created_by = e.id " +
            "            WHERE LOWER(b.title) LIKE ? " +
            "            AND b.status LIKE ? " +
            "            AND b.category_id LIKE ? " +
            "            LIMIT ?, ?";
    private static final String SQL_GET_ALL_BLOGS_RELATE = "SELECT b.id , b.category_id  , " +
            "b.title , b.image , b.brief , b.create_at," +
            " b.description  " +
            "FROM blogs b " +
            "where id != ? and category_id = ? " +
            "ORDER BY create_at DESC " +
            "LIMIT 5";
    private static final String SQL_COUNT_BLOGS = "SELECT COUNT(*) " +
            "FROM blogs b inner join category_blog c on b.category_id = c.id " +
            "where ( title like ? or brief like ? or description like ?) and b.status = '1' ";
    private static final String RECENT_POST = "SELECT id, create_at, title, image FROM blogs order by create_at desc";
    private static final String SQL_GET_ALL_ID_CATEGORY = "SELECT b.id, b.category_id  , " +
            "b.title , b.image , b.brief ,b.create_at," +
            " b.description , c.name " +
            "FROM blogs b inner join category_blog c on b.category_id = c.id " +
            "where ( title like ? or brief like ? or description like ?) and b.category_id = ? and b.status = '1'" +
            " ORDER BY ? LIMIT ? OFFSET ?";
    private static final String SQL_GET_ALL_CATEGORY = "SELECT b.id , b.category_id , " +
            "b.title , b.image , b.brief, b.create_at," +
            " b.description, c.name " +
            "FROM blogs b inner join category_blog c on b.category_id = c.id " +
            "where ( title like ? or brief like ? or description like ?) and b.status = '1'" +
            " ORDER BY ? LIMIT ? OFFSET ?";
    private static final String SQL_LIST_CATEGORY = "select id, name from category_blog";
    private static final String SQL_GET_BLOGS_BY_ID="select b.id, b.category_id, b.title,b.image, b.brief, " +
            "b.description, b.create_at, b.update_at, b.created_by,c.name, e.full_name from blogs b inner join category_blog c " +
            "on b.category_id = c.id inner join employees e on b.created_by = e.id " +
            "where b.id = ?";
    @Override
    public void changeStatus(int id, String status) throws SQLException {
        if (status.equals("0")) {
            ConnectionUtils.executeUpdate(CHANGE_status, 1, id);
        } else {
            ConnectionUtils.executeUpdate(CHANGE_status, 0, id);
        }
    }
    @Override
    public List<Blogs> getAllBlog(int offset, int limit, String search, String status, String category) throws SQLException {
        List<Blogs> blogs = new ArrayList<>();
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        status = !status.equals("all") ? status : "%";
        category = !category.equals("all") ? category : "%";
        ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_BLOGS, search, status, category, offset, limit);
        while (rs.next()) {
            blogs.add(
                    Blogs.builder()
                            .employee(
                                    Employee.builder()
                                            .id(rs.getLong("id"))
                                            .fullName(rs.getString("full_name"))
                                            .build()
                            )
                            .categoryBlog(CategoryBlog.builder()
                                    .name(rs.getString("name"))
                                    .build())
                            .id(rs.getLong("id"))
                            .categoryID(rs.getInt("category_id"))
                            .title(rs.getString("title"))
                            .brief(rs.getString("brief"))
                            .description(rs.getString("description"))
                            .status(rs.getBoolean("status"))
                            .createdAt(rs.getTimestamp("create_at").toLocalDateTime())
                            .createdBy(rs.getLong("created_by"))
                            .image(rs.getString("image"))
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return blogs;
    }
    @Override
    public Integer countListBlogSummary(String search, String status, String category) throws SQLException {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        status = !status.equals("all") ? status : "%";
        category = !category.equals("all") ? category : "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_BLOG, search, status, category);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }
    @Override
    public Blogs getBlogID(int id) throws Exception {
        Blogs blogs = new Blogs();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_BLOGS_BY_ID, id);
        while (rs.next()) {
            CategoryBlog categoryBlog = CategoryBlog.builder()
                    .name(rs.getString("name"))
                    .build();

            if (rs.getObject("category_id") != null) {
                categoryBlog.setId(rs.getLong("category_id"));
            }
            Employee employee = Employee.builder()
                    .fullName(rs.getString("full_name"))
                    .build();
            blogs.setId(rs.getLong("id"));
            blogs.setTitle(rs.getString("title"));
            blogs.setImage(rs.getString("image"));
            blogs.setDescription(rs.getString("description"));
            blogs.setBrief(rs.getString("brief"));
            blogs.setCategoryBlog(categoryBlog);
            blogs.setEmployee(employee);
            blogs.setCreatedAt(rs.getTimestamp("create_at").toLocalDateTime());
        }
        return blogs;
    }
    @Override
    public List<CategoryBlog> getListCategoryBlog() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_LIST_CATEGORY);
        List<CategoryBlog> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    CategoryBlog.builder()
                            .name(rs.getString("name"))
                            .id(rs.getLong("id"))
                            .build()
            );
        }
        return result;
    }
    @Override
    public List<BlogResDto> getListBlogRelated(long id, long categoryId) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_BLOGS_RELATE, id ,categoryId);
        List<BlogResDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    BlogResDto.builder()
                    .id(rs.getLong("id"))
                    .title(rs.getString("title"))
                    .image(rs.getString("image"))
                    .brief(rs.getString("brief"))
                    .description(rs.getString("description"))
                    .create_at(rs.getTimestamp("create_at").toLocalDateTime())
                    .build());
        }
        return result;
    }
    @Override
    public  List<Blogs> RecentPosts() throws Exception {
        List<Blogs> data = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(RECENT_POST);
        try {
            int count = 0;
            while (rs.next()) {
                if (count < 3) {
                    Blogs blogs = new Blogs();
                    blogs.setId(rs.getLong("id"));
                    blogs.setTitle(rs.getString("title"));
                    blogs.setImage(rs.getString("image"));
                    blogs.setCreatedAt(rs.getTimestamp("create_at").toLocalDateTime());
                    data.add(blogs);
                    ++count;
                }

            }
        } catch (Exception e) {
            System.out.println("RecentPost: " + e);
        }
        return data;
    }
    @Override
    public Integer countListBlogs(String search) throws SQLException {
        search = "%" + search + "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_BLOGS, search, search, search);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }
    @Override
    public List<BlogResDto> getListBlogsFilter(Integer offset, Integer limit, String search, String order, Integer categoryId) throws SQLException {
        search = "%" + search + "%";
        ResultSet rs;
        String sqlQuery;
        if (categoryId != null) {
            sqlQuery = SQL_GET_ALL_ID_CATEGORY;
            rs = ConnectionUtils.executeQuery(sqlQuery, search, search, search, categoryId, order, limit, offset);
        } else {
            sqlQuery = SQL_GET_ALL_CATEGORY;
            rs = ConnectionUtils.executeQuery(sqlQuery, search, search, search, order, limit, offset);
        }
        List<BlogResDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    BlogResDto.builder()
                            .categoryBlog(
                                    CategoryBlog.builder()
                                            .name(rs.getString("name"))
                                            .id(rs.getLong("id"))
                                            .build()
                            )
                            .id(rs.getLong("id"))
                            .title(rs.getString("title"))
                            .brief(rs.getString("brief"))
                            .description(rs.getString("description"))
                            .create_at(rs.getTimestamp("create_at").toLocalDateTime())
                            .image(rs.getString("image"))
                            .build()
            );
        }
        return result;
    }
    @Override
    public List<Blogs> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }
    @Override
    public Optional<Blogs> get(int id) throws SQLException {
        try {
            ResultSet rs = ConnectionUtils.executeQuery(GET_BLOG_BY_ID, id);
            assert rs != null;
            if (rs.next()) {
                return Optional.ofNullable(Blogs.builder()
                        .categoryBlog(
                                CategoryBlog.builder()
                                        .name(rs.getString("name"))
                                        .build()
                        )
                        .createdAt(rs.getTimestamp("create_at").toLocalDateTime())
                        .title(rs.getString("title"))
                        .brief(rs.getString("brief"))
                        .description(rs.getString("description"))
                        .status(rs.getBoolean("status"))
                        .build());
            }
            ConnectionUtils.closeConnection();
        } catch (Exception e) {
            System.out.println("get:" + e);
        }
        return Optional.empty();
    }
    @Override
    public Long save(Blogs blog) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SAVE_BLOG, blog.getId(), blog.getCategoryID(), blog.getTitle(), blog.getBrief(),
                blog.getDescription(), blog.getCreatedAt()
                , blog.getStatus(), blog.getImage());
        return null;
    }
    @Override
    public void update(Blogs blog) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_BLOG, blog.getCategoryBlog().getId(), blog.getTitle(),
                blog.getBrief(), blog.getDescription(),blog.getCreatedAt(),
                blog.getUpdatedAt()
                , blog.getStatus(), blog.getId());
    }
    @Override
    public void delete(Blogs blog) throws SQLException {
        categoryBlogDao.delete(CategoryBlog.builder().id(blog.getId()).build());
        ConnectionUtils.executeUpdate(DELETE_BLOG, blog.getId());
    }
    public ArrayList<String> listCategory() throws SQLException {
        ArrayList<String> data = new ArrayList<>();
        try {
            ResultSet rs = ConnectionUtils.executeQuery(GET_CATEGORYBLOG);
            while (rs.next()) {
                String category = rs.getString("category");
                data.add(category);
            }
        } catch (Exception e) {
            System.out.println("getListCategory " + e);
        }
        return data;
    }

}
