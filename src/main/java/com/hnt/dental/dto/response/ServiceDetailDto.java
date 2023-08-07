package com.hnt.dental.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ServiceDetailDto {
    private Long id;
    private String name;
    private String fee;
    private String type;
    private String image;
    private String description;
    private LocalDateTime updateAt;
    private Boolean status;

}
