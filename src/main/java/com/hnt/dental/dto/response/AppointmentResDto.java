package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Booking;
import com.hnt.dental.entities.Doctors;
import com.hnt.dental.entities.Patient;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class AppointmentResDto {

    private Long id;
    private Booking booking;
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
    public static List<AppointmentResDto> convert(List<BookingDto>bookings) {
        List<AppointmentResDto> appointmentResDto = new ArrayList<>();
            for (BookingDto booking : bookings) {
            appointmentResDto.add(
                    AppointmentResDto.builder()
                            .id(booking.getId())
                            .patientid(booking.getPatient().getId())
                            .patientFullName(booking.getPatient().getFullName())
                            .name(booking.getService().getName())
                            .gender(booking.getPatient().getGender() ? "Nam" : "Nữ")
                            .date(String.valueOf(booking.getDate()))
                            .time(String.valueOf(booking.getTime()))
                            .status(Integer.parseInt(booking.getStatus()) == 1 ? "Complete" : "Assigned")
                            .build()
            );
        }
        return  appointmentResDto;
    }
}