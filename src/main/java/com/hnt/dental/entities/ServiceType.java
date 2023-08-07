package com.hnt.dental.entities;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ServiceType extends BaseEntity{
    private Service service;
    private String name;
    private String description;
}
