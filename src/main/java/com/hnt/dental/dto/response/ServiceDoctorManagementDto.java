package com.hnt.dental.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class ServiceDoctorManagementDto {
    private Long id;
    private String name;
    private String email;
   private String type;
   private List<ServiceTypeOfDoctor> types;
}
