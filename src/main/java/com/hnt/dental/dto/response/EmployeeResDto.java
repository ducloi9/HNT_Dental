package com.hnt.dental.dto.response;

import com.hnt.dental.entities.Employee;
import com.hnt.dental.util.DateUtils;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class EmployeeResDto {
    private Long id;
    private String name;
    private String dob;
    private String gender;
    private String email;
    private String status;

    public static List<EmployeeResDto> convert(List<Employee> employees) {
        List<EmployeeResDto> employeeResDtos = new ArrayList<>();
        for (Employee employee: employees){
            employeeResDtos.add(
                    EmployeeResDto.builder()
                            .id(employee.getAccount().getId())
                            .name(employee.getFullName())
                            .dob(DateUtils.convertLocalDateToString(employee.getDob()))
                            .gender(employee.getGender() ? "Nam" : "Nữ")
                            .email(employee.getAccount().getEmail())
                            .status(employee.isStatus() ? "Đang làm việc" : "Đã nghỉ việc")
                            .build()
            );
        }
        return employeeResDtos;
    }
}
