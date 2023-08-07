package com.hnt.dental.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RankDto {
    private Long id;
    private String name;

}
