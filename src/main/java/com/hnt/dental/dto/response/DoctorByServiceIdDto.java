package com.hnt.dental.dto.response;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DoctorByServiceIdDto {
    private Long id;
    private String fullName;
    private String rankName;
    private String image;
    private String type;
}
