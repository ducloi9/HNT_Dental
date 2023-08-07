package com.hnt.dental.dao;

import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.Service;
import com.hnt.dental.entities.ServiceType;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public interface ServiceDao extends GenericDao<Service>{
    List<ServiceResDto> getAllServiceDao(Integer offset, Integer limit, String search, String typeId) throws Exception;
    Integer countListService(String search) throws SQLException;

    ServiceDetailDto getServiceDetailByServiceId(Long id, Long typeId) throws SQLException;

    List<ServiceTypeDto> getTypeByServiceId(Long id) throws SQLException;

    List<DoctorByServiceIdDto> getDoctorByServiceIdAndServiceType(Long id, Long idType) throws SQLException;

    List<ServiceSearchHomeDto> getAllServiceHome() throws SQLException;

    List<ServiceDetailDto> getTopService() throws SQLException;

    List<ServiceTypeDto> getALlType() throws SQLException;

    List<ServiceManagementDto> getAllServiceManagement(Integer offset, Integer limit, String search) throws SQLException;

    ServiceDetailDto getServiceDetailManagementById(Long id) throws SQLException;

    void updateServiceDetailManagementById(ServiceDetailDto serviceDetailDto) throws SQLException;

    List<ServiceManagementDto> getServiceTypeDetailManagementById(Long id) throws SQLException;

    List<ServiceDoctorManagementDto> getDoctorOfServiceManagementById(Long id) throws SQLException;

    List<ServiceTypeOfDoctor> getTypeOfDoctorByDoctorId(Long idService, Long idDoctor) throws SQLException;

    List<ServiceTypeDto> getTypeOfServiceAvailable(Long idService) throws SQLException;


    void updateServiceFeeByServiceTypeId(Long idService,Long idServiceType, Double fee) throws SQLException;
    void updateServiceFee(Long idService,Long idServiceType, Double fee) throws SQLException;

    void deleteDoctor(Long id, Long doctorId) throws SQLException;
}
