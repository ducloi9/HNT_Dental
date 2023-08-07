package com.hnt.dental.entities;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;
import java.util.Date;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Payment extends BaseEntity{
    private Account account;
    private ServiceFee serviceFee;
    private int type;
    private Booking booking;
    private Boolean status;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;

}
