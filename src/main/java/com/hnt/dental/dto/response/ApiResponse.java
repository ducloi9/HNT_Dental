package com.hnt.dental.dto.response;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class ApiResponse<T> {
    private boolean status;
    private String message;
    private T data;
}
