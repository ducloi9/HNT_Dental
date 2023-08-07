package com.hnt.dental.entities;

import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Patient extends BaseEntity{

    private Booking booking;
    private Account account;
    private String fullName;
    private LocalDate dob;
    private Boolean gender;
    private String phone;
    private String address;
    private String description;

    private Boolean status;
    private Long image;




}
