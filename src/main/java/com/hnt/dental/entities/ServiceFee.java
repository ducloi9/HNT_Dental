package com.hnt.dental.entities;
import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ServiceFee {
    private Service service;
    private Double fee;
}
