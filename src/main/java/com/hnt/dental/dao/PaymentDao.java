package com.hnt.dental.dao;

import com.hnt.dental.dto.response.DoctorDetailDto;
import com.hnt.dental.entities.Payment;

import java.sql.SQLException;
import java.util.Optional;

public interface PaymentDao  extends GenericDao<Payment>{
    Optional<Payment> getPaymentByAppointmentId(Long id) throws SQLException;

    void updatePaymentForMarketing(Payment payment) throws SQLException;
    Double countRevenue() throws SQLException;
}
