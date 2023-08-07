package com.hnt.dental.dto.response;
import com.hnt.dental.entities.Patient;
import com.hnt.dental.util.DateUtils;
import lombok.*;

import java.util.ArrayList;
import java.util.List;


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

public class PatientResDto {
    private Long id;
    private String name;
    private String dob;
    private String gender;
    private String email;
    private String status;

    public static List<PatientResDto> convert(List<Patient> patients) {
        List<PatientResDto> patientResDtos = new ArrayList<>();
        for (Patient patient: patients){
            patientResDtos.add(
                    PatientResDto.builder()
                            .id(patient.getAccount().getId())
                            .name(patient.getFullName())
                            .dob(DateUtils.convertLocalDateToString(patient.getDob()))
                            .gender(patient.getGender() ? "Nam" : "Nữ")
                            .status(patient.getStatus()? "active" : "deactive")
                            .build()
            );
        }
        return patientResDtos;
    }

}
