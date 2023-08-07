package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Booking;
import com.hnt.dental.entities.Doctors;
import com.hnt.dental.entities.Employee;
import com.hnt.dental.entities.Payment;

public class BookingUpdateDto{
    private Doctors doctor;
    private Employee employee;
    private Booking booking;
    private Payment payment;
}
