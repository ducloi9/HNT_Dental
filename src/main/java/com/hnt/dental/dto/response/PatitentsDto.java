package com.hnt.dental.dto.response;
import com.hnt.dental.entities.Account;
import com.hnt.dental.entities.Booking;
import lombok.*;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class PatitentsDto {
    private Booking booking;
    private Account account;
    private String fullName;
    private LocalDate dob;
    private Boolean gender;
    private String phone;
    private String address;
    private String description;
    private Long id;
}
