package com.hnt.dental.dao;

import com.hnt.dental.entities.Verification;

import java.sql.SQLException;

public interface VerificationDao extends GenericDao<Verification>{
    Verification findByEmail(String email) throws SQLException;
}
