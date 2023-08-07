package com.hnt.dental.constant;

public enum RoleEnum {
    ROLE_PATIENT,
    ROLE_ADMIN,
    ROLE_DOCTOR,
    ROLE_MARKETING,
    ROLE_STAFF;

    public static RoleEnum getRole(int role){
        for(RoleEnum roleEnum : RoleEnum.values()){
            if(roleEnum.ordinal() == role){
                return roleEnum;
            }
        }
        return null;
    }
}
