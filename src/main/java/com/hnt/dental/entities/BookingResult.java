package com.hnt.dental.entities;

import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@SuperBuilder
public class BookingResult extends BaseEntity{
    private Long id;
    private Long bookingId;
    private String result;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;


}
