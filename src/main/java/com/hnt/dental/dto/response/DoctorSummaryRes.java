package com.hnt.dental.dto.response;

import lombok.*;
import lombok.experimental.SuperBuilder;

@Data
@SuperBuilder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DoctorSummaryRes {
    private Long id;
    private String fullName;
    private String rankName;
    private String image;
    private String description;
}
