package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Booking;
import com.hnt.dental.entities.Doctors;
import com.hnt.dental.entities.Patient;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class AppointmentDetailDto {
    private Long id;
    private BookingDto booking;
    private Account account;
    private Patient patient;
    private Doctors doctors;
    private String patientFullName;
    private String gender;
    private String status;
    private String date;
    private String time;
    private String name;
    private Long patientid;
    public static Optional<AppointmentDetailDto> convert(Optional<BookingDto> bookingOptional) {
        if (bookingOptional.isPresent()) {
            BookingDto booking = bookingOptional.get();
            AppointmentDetailDto appointmentDetailDto = new AppointmentDetailDto();
            appointmentDetailDto.setId(booking.getId());
            appointmentDetailDto.setBooking(booking);
            appointmentDetailDto.setAccount(booking.getAccount());
            appointmentDetailDto.setPatient(booking.getPatient());
            appointmentDetailDto.setDoctors(booking.getDoctors());
            appointmentDetailDto.setPatientFullName(booking.getPatient().getFullName());
            appointmentDetailDto.setGender(booking.getPatient().getGender() ? "Nam" : "Nữ");
            appointmentDetailDto.setStatus(Integer.parseInt(booking.getStatus()) == 1 ? "Complete" : "Assigned");
            appointmentDetailDto.setDate(String.valueOf(booking.getDate()));
            appointmentDetailDto.setTime(String.valueOf(booking.getTime()));
            appointmentDetailDto.setName(booking.getService().getName());
            appointmentDetailDto.setPatientid(booking.getPatient().getId());

            return Optional.of(appointmentDetailDto);
        } else {
            return Optional.empty();
        }
    }
}

