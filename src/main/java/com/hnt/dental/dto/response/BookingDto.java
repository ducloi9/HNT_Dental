package com.hnt.dental.dto.response;

import com.hnt.dental.entities.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
public class BookingDto {
    private ServiceFeeDto serviceFeeDto;
    private BookingResultDto bookingResultDto;
    private ServiceTypeDto serviceTypeDto;
    private ServiceResDto serviceResDto;
    private Long id;
    private String name;
    private int phone;
    private int age;
    private boolean gender;
    private Service service;
    private Account account;
    private Doctors doctors;
    private Employee employee;
    private Feedback feedback;
    private Booking booking;
    private LocalDate date;
    private LocalTime time;
    private String description;
    private Patient patient;
    private int doctor_id;
    private int service_id;
    private String payment;
    private String status;
    private double fee;
    private int account_id;
}
