package com.hnt.dental.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Employee extends BaseEntity{
    private Account account;
    private String fullName;
    private LocalDate dob;
    private Boolean gender;
    private String phone;
    private String address;
    private String description;
    private Double salary;
    private boolean status;
}
