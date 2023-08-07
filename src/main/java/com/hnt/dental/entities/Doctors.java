package com.hnt.dental.entities;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.util.Date;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Doctors extends BaseEntity{

    private String fullName;
    private Account account;
    private LocalDate dob;
    private Boolean gender;
    private Booking booking;
    private Patient patient;
    private String phone;
    private String address;
    private String position;
    private String description;
    private DoctorRank doctorRank;
    private String image;
    private Boolean status;
    private long rankId;
}
