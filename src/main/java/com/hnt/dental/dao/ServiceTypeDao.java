package com.hnt.dental.dao;

import com.hnt.dental.dto.response.ServiceTypeListDto;
import com.hnt.dental.dto.response.TypeServiceDto;
import com.hnt.dental.entities.DoctorRank;
import com.hnt.dental.entities.ServiceType;

import java.sql.SQLException;
import java.util.List;

public interface ServiceTypeDao extends GenericDao<ServiceType>{

    List<ServiceTypeListDto> getAll(Integer offset, Integer limit) throws SQLException;
    Integer countListService() throws SQLException;
    List<TypeServiceDto> getAllRankOfType(Long idType) throws SQLException;
    ServiceType getServiceTypeDetail(Long id) throws SQLException;

    List<DoctorRank> addRankToType(Long idType) throws SQLException;

    List<DoctorRank> listRankOfTypeAvailable(Long idType) throws SQLException;
    Long saveRankToType(Long idType, Long idRank) throws SQLException;

    void deleteRankFromType(Long idType, Long idRank) throws SQLException;
}
