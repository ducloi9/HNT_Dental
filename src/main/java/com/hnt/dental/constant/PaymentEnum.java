package com.hnt.dental.constant;

public enum PaymentEnum {
    VNPAY, CASH;

    public static PaymentEnum getPaymentEnum(String payment) {
        if (payment.equalsIgnoreCase("VNPAY")) {
            return VNPAY;
        } else if (payment.equalsIgnoreCase("CASH")) {
            return CASH;
        }
        return null;
    }

    public static String getPaymentString(int payment) {
        if (payment == 0) {
            return "VNPAY";
        } else if (payment == 1) {
            return "CASH";
        }
        return null;
    }
}
