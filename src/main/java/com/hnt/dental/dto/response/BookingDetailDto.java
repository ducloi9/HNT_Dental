package com.hnt.dental.dto.response;

import com.hnt.dental.constant.PaymentEnum;
import com.hnt.dental.entities.Doctors;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.entities.Payment;
import com.hnt.dental.entities.Service;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.time.LocalTime;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@SuperBuilder
public class BookingDetailDto {
    private Long id;
    private LocalDate date;
    private LocalTime time;
    private String status;
    private Doctors doctors;
    private Employee employee;
    private Payment payment;
    private String paymentType;
    private String decription;
}
