package com.hnt.dental.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@SuperBuilder
public class ProfileDto {
    private String fullName;
    private  String email;
    private String phone;
    private LocalDate dob;
    private String address;
    private String description;
    private Boolean gender;
    private String image;

}
