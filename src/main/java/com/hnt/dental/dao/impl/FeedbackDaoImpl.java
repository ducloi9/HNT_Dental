package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.FeedbackDao;
import com.hnt.dental.dto.response.FeedbackDto;
import com.hnt.dental.entities.Feedback;
import com.hnt.dental.util.ConnectionUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class FeedbackDaoImpl implements FeedbackDao {
    private static final String SQL_GET_COMMENT_DOCTOR = "SELECT " +
            "f.id, p.full_name, f.created_at, p.image, f.description, star " +
            "from feedback f " +
            "inner join booking b on f.booking_id = b.id " +
            "inner join patients p on p.id = b.account_id " +
            "where f.doctor_id = ?";
    private static final String SQL_GET_COMMENT_SERVICE =
            "select f.id, p.full_name, f.created_at, p.image, f.description, star from feedback f " +
                    "            inner join service s on s.id = f.service_id " +
                    "            inner join booking b on f.booking_id = b.id " +
                    "            inner join patients p on p.id = b.account_id " +
                    "            inner join service_fee sf on sf.service_id = s.id " +
                    "            inner join service_type st on sf.service_type = st.id " +
                    "            where s.id = ? ";

    public List<FeedbackDto> getFeedbackDoctor(Long id) throws Exception {
        return getFeedback(SQL_GET_COMMENT_DOCTOR, id);
    }

    public List<FeedbackDto> getFeedbackService(Long id) throws Exception {
        return getFeedback(SQL_GET_COMMENT_SERVICE, id);
    }

    @Override
    public List<FeedbackDto> getFeedback(String sqlQuery, Long id) throws Exception {
        ResultSet rs = ConnectionUtils.executeQuery(sqlQuery, id);
        List<FeedbackDto> list = new ArrayList<>();
        while (rs.next()) {
            Timestamp createdAtTimestamp = rs.getTimestamp("created_at");
            LocalDateTime createdAt = createdAtTimestamp != null ? createdAtTimestamp.toLocalDateTime() : null;

            list.add(FeedbackDto.builder()
                    .id(rs.getLong("id"))
                    .fullName(rs.getString("full_name"))
                    .createdAt(createdAt) // Use the LocalDateTime after null check
                    .image(rs.getString("image"))
                    .description(rs.getString("description"))
                    .star(rs.getInt("star"))
                    .build());
        }
        return list;
    }


    public static void main(String[] args) throws Exception {
        FeedbackDaoImpl dao = new FeedbackDaoImpl();
        dao.getFeedbackService(1L).forEach(System.out::println);
    }

    @Override
    public List<Feedback> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }

    @Override
    public Optional<Feedback> get(int id) throws SQLException {
        return Optional.empty();
    }

    @Override
    public Long save(Feedback feedback) throws SQLException, ClassNotFoundException {
        return null;
    }

    @Override
    public void update(Feedback feedback) throws SQLException {

    }

    @Override
    public void delete(Feedback feedback) throws SQLException {

    }
}
