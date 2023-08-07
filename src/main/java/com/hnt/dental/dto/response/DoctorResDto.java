package com.hnt.dental.dto.response;
import com.hnt.dental.entities.DoctorRank;
import com.hnt.dental.entities.Doctors;
import com.hnt.dental.util.DateUtils;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class DoctorResDto {

    private Long id;
    private String fullName;
    private String dob;
    private String gender;
    private String phone;
    private String position;
    private long rankId;
    private String status;
    private DoctorRank doctorRank;
    private String name;
    public static List<DoctorResDto> convert(List<Doctors> doctors) {
        List<DoctorResDto> doctorResDtos = new ArrayList<>();
        for (Doctors doctor : doctors) {
            doctorResDtos.add(
                    DoctorResDto.builder()
                            .id(doctor.getAccount().getId())
                            .fullName(doctor.getFullName())
                            .dob(DateUtils.convertLocalDateToString(doctor.getDob()))
                            .gender(doctor.getGender() ? "nam" : "nữ")
                            .phone(doctor.getPhone())
                            .position(doctor.getPosition())
                            .rankId(doctor.getRankId())
                            .status(doctor.getStatus() ? "Đang làm việc" : "Đã nghỉ việc")
                            .name(doctor.getDoctorRank().getName())
                            .build()
            );
        }
        return doctorResDtos;
    }
}
