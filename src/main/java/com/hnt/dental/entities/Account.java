package com.hnt.dental.entities;

import lombok.*;
import lombok.experimental.SuperBuilder;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Account extends BaseEntity{
    private String email;
    private String password;
    private int role;
    private Boolean isVerified;
    private String image;
    private Doctors doctors;
}
