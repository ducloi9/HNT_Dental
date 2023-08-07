package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.PaymentDao;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Booking;
import com.hnt.dental.entities.Payment;
import com.hnt.dental.entities.ServiceFee;
import com.hnt.dental.util.ConnectionUtils;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class PaymentDaoImpl implements PaymentDao {

    private static final String GET_PAYMENT_BY_BOOKING_ID = "SELECT * FROM payment p " +
            "inner join booking b on p.booking_id = b.id " +
            "where b.id = ?";

    private static final String SAVE_PAYMENT = "INSERT INTO payment " +
            "(account_id, booking_id, fee, status, `type`, created_at, updated_at) " +
            "VALUES(?, ?, ?, ?, ?, ?, ?)";

    private static final String UPDATE_PAYMENT = "UPDATE payment " +
            "SET account_id=?, booking_id=?, fee=?, status=?, `type`=?, created_at=?, updated_at=? " +
            "WHERE id=? ";
    private static final String UPDATE_PAYMENT_FOR_MARKETING = "UPDATE payment SET status = ?, type = ?, fee = ?  WHERE (booking_id = ?)";

    private static final String COUNT_REVENUE = "select sum(fee) as revenue from payment p " +
            "where p.status =1";

    @Override
    public void updatePaymentForMarketing(Payment payment) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_PAYMENT_FOR_MARKETING,
                payment.getStatus(),
                payment.getType(),
                payment.getServiceFee().getFee(),
                payment.getBooking().getId());
    }

    @Override
    public Double countRevenue() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(COUNT_REVENUE);
        if (rs.next()) {
            return rs.getDouble("revenue");
        }
        return null;
    }

    public static void main(String[] args) throws SQLException {
        PaymentDaoImpl paymentDao = new PaymentDaoImpl();
        System.out.println(paymentDao.countRevenue());
    }

    @Override
    public List<Payment> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }

    @Override
    public Optional<Payment> get(int id) throws SQLException {
        return Optional.empty();
    }

    @Override
    public Long save(Payment payment) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SAVE_PAYMENT,
                payment.getAccount().getId(),
                payment.getBooking().getId(),
                payment.getServiceFee().getFee(),
                payment.getStatus(),
                payment.getType(),
                payment.getCreated_at(),
                payment.getUpdated_at());
        return null;
    }

    @Override
    public void update(Payment payment) throws SQLException {
        ConnectionUtils.executeUpdate(UPDATE_PAYMENT,
                payment.getAccount().getId(),
                payment.getBooking().getId(),
                payment.getServiceFee().getFee(),
                payment.getStatus(),
                payment.getType(),
                payment.getCreated_at(),
                payment.getUpdated_at(),
                payment.getId());
    }

    @Override
    public void delete(Payment payment) throws SQLException {

    }

    @Override
    public Optional<Payment> getPaymentByAppointmentId(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(GET_PAYMENT_BY_BOOKING_ID, id);
        if (rs.next()) {
            return Optional.of(Payment.builder()
                    .id(rs.getLong("id"))
                    .account(Account.builder().id(rs.getLong("account_id")).build())
                    .booking(Booking.builder().id(rs.getLong("booking_id")).build())
                    .serviceFee(ServiceFee.builder().fee(rs.getDouble("fee")).build())
                    .type(rs.getInt("type"))
                    .status(rs.getBoolean("status"))
                    .created_at(rs.getTimestamp("created_at").toLocalDateTime())
                    .updated_at(rs.getTimestamp("updated_at").toLocalDateTime())
                    .build());
        }
        return Optional.empty();
    }

}
