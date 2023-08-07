package com.hnt.dental.dto.response;

import com.hnt.dental.entities.DoctorRank;
import com.hnt.dental.entities.Doctors;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class BookingDetailDoctorDto {
    private Long id;
    private Doctors doctors;
    private DoctorRank doctorRank;
}
