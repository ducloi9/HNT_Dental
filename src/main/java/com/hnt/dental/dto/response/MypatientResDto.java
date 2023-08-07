package com.hnt.dental.dto.response;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Booking;
import com.hnt.dental.entities.Patient;
import com.hnt.dental.util.DateUtils;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MypatientResDto {
    private Long id;
    private Booking booking;
    private Account account;
    private String fullName;
    private String Name;
    private String gender;
    private String phone;
    private String address;
    private String description;
    private String status;
    private String dob;
    private String email;
    private String date;
    private String time;
    public static List<MypatientResDto> convert(List<PatitentsDto> patients) {
        List<MypatientResDto> mypatientResDto = new ArrayList<>();
        for (PatitentsDto patient : patients) {
            mypatientResDto.add(
                    MypatientResDto.builder()
                            .id(patient.getAccount().getId())
                            .fullName(patient.getFullName())
                            .dob(DateUtils.convertLocalDateToString(patient.getDob()))
                            .gender(patient.getGender() ? "Nam" : "Nữ")
                            .email(patient.getAccount().getEmail())
                            .status(patient.getBooking().getStatus() == 1 ? "rejected" : "approved")
                            .date(DateUtils.convertLocalDateToString(patient.getBooking().getDate()))
                            .time(String.valueOf(patient.getBooking().getTime()))
                            .phone(patient.getPhone())
                            .Name(patient.getBooking().getName())
                            .build()
            );
        }
        return mypatientResDto;
    }
}

