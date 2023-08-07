package com.hnt.dental.dto.response;

import com.hnt.dental.entities.DoctorRank;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class TypeServiceDto {
    private Long id;
    private String name;
    private DoctorRank doctorRank;
}
