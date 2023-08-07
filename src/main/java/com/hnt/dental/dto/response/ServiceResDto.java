package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Employee;
import com.hnt.dental.entities.Service;
import com.hnt.dental.util.DateUtils;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class ServiceResDto {
    private Long id;
    private String name;
    private String fee;
    private String type;
    private String image;

}
