package com.hnt.dental.dto.response;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DoctorDetailDto {
    private Long id;
    private String fullName;
    private String position;
    private String image;
    private String description;
    private Date dob;
    private String rankName;
}
