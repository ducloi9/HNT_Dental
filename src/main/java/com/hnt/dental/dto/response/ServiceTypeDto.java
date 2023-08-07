package com.hnt.dental.dto.response;

import lombok.*;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ServiceTypeDto {

    private Long idType;
    private String nameType;
}
