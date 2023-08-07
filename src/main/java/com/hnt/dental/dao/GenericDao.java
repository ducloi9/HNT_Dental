package com.hnt.dental.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface GenericDao<T> {
    List<T> getAll(Integer offset, Integer limit, String search) throws SQLException;

    Optional<T> get(int id) throws SQLException;

    Long save(T t) throws SQLException, ClassNotFoundException;

    void update(T t) throws SQLException;

    void delete(T t) throws SQLException;
}
