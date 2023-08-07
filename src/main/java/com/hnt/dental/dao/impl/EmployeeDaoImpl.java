package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.AccountDao;
import com.hnt.dental.dao.EmployeeDao;
import com.hnt.dental.dto.response.ProfileDto;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.util.ConnectionUtils;
import com.hnt.dental.util.DateUtils;
import org.apache.commons.lang3.StringUtils;

import javax.management.MBeanAttributeInfo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class EmployeeDaoImpl implements EmployeeDao {

    private static AccountDao accountDao;

    static {
        accountDao = new AccountDaoImpl();
    }

    private static final String GET_ALL_EMPLOYEE = "SELECT e.id, e.full_name, e.dob, e.gender, a.email, e.status " +
            "FROM employees e " +
            "INNER JOIN accounts a ON e.id = a.id " +
            "WHERE LOWER(e.full_name) LIKE ? " +
            "OR LOWER(a.email) LIKE ? " +
            "OR LOWER(e.dob) LIKE ? " +
            "LIMIT ?, ?";

    private static final String SAVE_EMPLOYEE = "INSERT INTO employees" +
            "(id, full_name, dob, gender, phone, address, salary, status, created_at, updated_at) " +
            "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
    private static final String COUNT_EMPLOYEE = "SELECT COUNT(*) FROM employees e " +
            "INNER JOIN accounts a ON e.id = a.id " +
            "WHERE LOWER(e.full_name) LIKE ? " +
            "OR LOWER(a.email) LIKE ? " +
            "OR LOWER(e.dob) LIKE ? ";
    private static final String UPDATE_EMPLOYEE = "UPDATE employees " +
            "SET full_name=?, dob=?, gender=?, phone=?, address=?, salary=?, status=?, created_at=?, updated_at=? " +
            "WHERE id=?";

    private static final String GET_EMPLOYEE_BY_ID = "SELECT employees.*, accounts.image FROM employees inner join accounts on employees.id = accounts.id where employees.id = ?";

    private static final String GET_EMPLOYEE_BY_NAME = "SELECT * FROM hnt_dental.employees where full_name like ?";

    private static final String DELETE_EMPLOYEE = "DELETE FROM employees WHERE id=?";

    private static final String SQL_GET_EMPLOYEE_AVALABLE = "SELECT DISTINCT e.full_name , e.id from employees e " +
            "LEFT join booking b on e.id = b.staff_id " +
            "where e.id NOT IN " +
            " (" +
            "SELECT DISTINCT e.id from employees e " +
            "LEFT join booking b on e.id = b.staff_id " +
            " WHERE (b.date = ? " +
            " AND b.time = ?)" +
            " AND b.id <> ?" +
            ")";

    private static final String SQL_GET_PROFILE_EMPLOYEE = "select e.full_name, e.dob, e.gender, e.address, e.description, e.phone , a.email, a.image from employees e " +
            "inner join accounts a on a.id = e.id " +
            "where e.id = ?";

    @Override
    public List<Employee> getEmployeeAvailable(LocalDate date, LocalTime time, Long bookingId) throws Exception {
        List<Employee> employees = new ArrayList<>();
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_EMPLOYEE_AVALABLE, date, time, bookingId);
        while (rs.next()) {
            employees.add(
                    Employee.builder()
                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            .build()
                            )
                            .fullName(rs.getString("full_name"))
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return employees;
    }

    @Override
    public ProfileDto getProfileEmployee(Long id) throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_PROFILE_EMPLOYEE, id);
        if(rs.next()){
            return ProfileDto.builder()
                    .fullName(rs.getString("full_name"))
                    .dob(rs.getDate("dob").toLocalDate())
                    .gender(rs.getBoolean("gender"))
                    .address(rs.getString("address"))
                    .description(rs.getString("description"))
                    .phone("0" + rs.getString("phone"))
                    .email(rs.getString("email"))
                    .image(rs.getString("image"))
                    .build();
        }
        return new ProfileDto();
    }


    @Override
    public List<Employee> getAll(Integer offset, Integer limit, String search) throws SQLException {
        List<Employee> employees = new ArrayList<>();
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_EMPLOYEE, search, search, search, offset, limit);
        while (rs.next()) {
            employees.add(
                    Employee.builder()
                            .account(
                                    Account.builder()
                                            .id(rs.getLong("id"))
                                            .email(rs.getString("email"))
                                            .build()
                            )
                            .fullName(rs.getString("full_name"))
                            .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                            .gender(rs.getBoolean("gender"))
                            .status(rs.getBoolean("status"))
                            .build()
            );
        }
        ConnectionUtils.closeConnection();
        return employees;
    }

    @Override
    public Optional<Employee> get(int id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(GET_EMPLOYEE_BY_ID, id);
        assert rs != null;
        if (rs.next()) {
            return Optional.ofNullable(Employee.builder()
                    .fullName(rs.getString("full_name"))
                    .account(
                            Account.builder()
                                    .email("email")
                                    .image(rs.getString("image"))
                                    .build())
                    .phone(rs.getString("phone"))
                    .address(rs.getString("address"))
                    .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                    .gender(rs.getBoolean("gender"))
                    .salary(rs.getDouble("salary"))
                    .description(rs.getString("description"))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return Optional.empty();
    }

    @Override
    public Long save(Employee employee) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SAVE_EMPLOYEE, employee.getAccount().getId(), employee.getFullName(),
                employee.getDob(), employee.getGender(), employee.getPhone(), employee.getAddress(),
                employee.getSalary(), employee.isStatus(), employee.getCreatedAt(), employee.getUpdatedAt());
        return null;

    }


    @Override
    public void update(Employee employee) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_EMPLOYEE, employee.getFullName(),
                employee.getDob(), employee.getGender(), employee.getPhone(), employee.getAddress(),
                employee.getSalary(), employee.isStatus(), employee.getCreatedAt(), employee.getUpdatedAt(), employee.getAccount().getId());
    }


    @Override
    public void delete(Employee employee) throws SQLException {
        accountDao.delete(Account.builder().id(employee.getId()).build());
        ConnectionUtils.executeUpdate(DELETE_EMPLOYEE, employee.getId());
    }

    @Override
    public Integer count(String search) throws Exception {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_EMPLOYEE, search, search, search);
        assert rs != null;
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    @Override
    public Optional<Employee> findByName(String name) throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(GET_EMPLOYEE_BY_NAME, name);
        assert rs != null;
        if (rs.next()) {
            return Optional.ofNullable(Employee.builder().id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .account(
                            Account.builder()
                                    .email("email")
                                    .build())
                    .phone(rs.getString("phone"))
                    .address(rs.getString("address"))
                    .dob(DateUtils.convertDateToLocalDate(rs.getDate("dob")))
                    .gender(rs.getBoolean("gender"))
                    .salary(rs.getDouble("salary"))
                    .description(rs.getString("description"))
                    .build());
        }
        ConnectionUtils.closeConnection();
        return Optional.empty();
    }


}
