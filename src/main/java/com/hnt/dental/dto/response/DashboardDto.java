package com.hnt.dental.dto.response;

import com.hnt.dental.constant.BookingStatusEnum;
import com.hnt.dental.dao.PatientDao;
import com.hnt.dental.entities.Patient;
import com.hnt.dental.entities.Service;
import com.hnt.dental.entities.ServiceType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.time.LocalDateTime;
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class DashboardDto {
    private Long id;
    private String name;
    private Service service;
    private ServiceType serviceType;

    private LocalDate time;
    private String status;

}
