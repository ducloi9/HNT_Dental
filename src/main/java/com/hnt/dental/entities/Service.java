package com.hnt.dental.entities;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Service extends BaseEntity{
    private String name;
    private String description;
    private String image;
    private Boolean status;
}
