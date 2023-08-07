package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Service;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.time.LocalTime;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@SuperBuilder
public class BookingManagementDto {
    private Long id;
    private String name;
    private Service service;
    private LocalDate date;
    private LocalTime time;
    private String status;

}
