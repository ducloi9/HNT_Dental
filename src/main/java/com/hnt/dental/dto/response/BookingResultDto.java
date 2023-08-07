package com.hnt.dental.dto.response;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder
public class BookingResultDto {
    private Long booking_id;
    private String result;
}
