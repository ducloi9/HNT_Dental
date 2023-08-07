package com.hnt.dental.constant;

import com.hnt.dental.entities.BookingStatus;

import java.util.ArrayList;
import java.util.List;

public enum BookingStatusEnum {
    PENDING, CANCEL, CONFIRM, ASSIGNED, DONE, REJECT;

    public static BookingStatusEnum getBookingStatusEnum(String status) {
        switch (status.toUpperCase()) {
            case "PENDING":
                return BookingStatusEnum.PENDING;
            case "CANCEL":
                return BookingStatusEnum.CANCEL;
            case "CONFIRM":
                return BookingStatusEnum.CONFIRM;
            case "ASSIGNED":
                return BookingStatusEnum.ASSIGNED;
            case "DONE":
                return BookingStatusEnum.DONE;
            case "REJECT":
                return BookingStatusEnum.REJECT;
            default:
                return null;
        }
    }

    public static String getBookingStatusString(int status) {
        switch (status) {
            case 0:
                return "PENDING";
            case 1:
                return "CANCEL";
            case 2:
                return "CONFIRM";
            case 3:
                return "ASSIGNED";
            case 4:
                return "DONE";
            case 5:
                return "REJECT";
            default:
                return null;
        }
    }

    public static List<BookingStatus> getAllBookingStatus() {
        List<BookingStatus> bookingStatusList = new ArrayList<>();
        for (BookingStatusEnum bookingStatusEnum : BookingStatusEnum.values()) {
            BookingStatus bookingStatus = new BookingStatus();
            bookingStatus.setId((bookingStatusEnum.ordinal()) + "");
            bookingStatus.setName(bookingStatusEnum.name());
            bookingStatusList.add(bookingStatus);
        }
        return bookingStatusList;
    }
}
