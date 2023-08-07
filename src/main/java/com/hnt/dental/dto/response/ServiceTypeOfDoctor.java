package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Doctors;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@SuperBuilder
public class ServiceTypeOfDoctor {
    private Long idType;
    private String nameType;
    private Doctors doctors;
}
