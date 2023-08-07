package com.hnt.dental.dto.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FeedbackDto {
    private Long id;
    private String fullName;
    private String image;
    private String description;
    private Integer star;
    private LocalDateTime createdAt;
}
