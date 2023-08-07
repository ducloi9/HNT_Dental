package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.VerificationDao;
import com.hnt.dental.entities.Verification;
import com.hnt.dental.util.ConnectionUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;


public class VerificationDaoImpl implements VerificationDao {
    private static final String SAVE_VERIFICATION = "INSERT INTO verification\n" +
            "(email, code, life_time, created_at, updated_at) " +
            "VALUES(?, ?, UNIX_TIMESTAMP(now() + INTERVAL 180 SECOND), ?, ?)";

    private static final String FIND_BY_EMAIL = "SELECT * FROM verification WHERE email = ?";

    private static final String DELETE_VERIFICATION = "DELETE FROM verification WHERE email = ?";

    @Override
    public List<Verification> getAll(Integer offset, Integer limit, String seach) throws SQLException {
        return null;
    }

    @Override
    public Optional<Verification> get(int id) throws SQLException {
        return Optional.empty();
    }

    @Override
    public Long save(Verification verification) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SAVE_VERIFICATION, verification.getEmail(), verification.getCode(),
                verification.getCreatedAt(), verification.getUpdatedAt());
        return null;
    }


    @Override
    public void update(Verification verification) {
        // TODO document why this method is empty
    }

    @Override
    public void delete(Verification verification) throws SQLException {
        ConnectionUtils.executeUpdate(DELETE_VERIFICATION, verification.getEmail());
    }

    @Override
    public Verification findByEmail(String email) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(FIND_BY_EMAIL, email);
        assert rs != null;
        if (rs.next()) {
            return Verification.builder()
                    .id(rs.getLong("id"))
                    .email(rs.getString("email"))
                    .code(rs.getString("code"))
                    .lifeTime(rs.getLong("life_time"))
                    .build();
        }
        ConnectionUtils.closeConnection();
        return null;
    }
}
