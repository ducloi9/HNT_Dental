package com.hnt.dental.dto.response;
import lombok.*;


@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Builder

public class ServiceFeeDto {
    private Long service_id;
    private Long service_type;
    private double fee;

}
