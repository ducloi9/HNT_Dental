package com.hnt.dental.entities;

import lombok.*;
import lombok.experimental.SuperBuilder;


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@SuperBuilder
public class Verification extends BaseEntity {
    private Long id;
    private String email;
    private String code;
    private Long lifeTime;
}
