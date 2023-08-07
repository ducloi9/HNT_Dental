package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.ServiceDao;
import com.hnt.dental.dto.response.*;
import com.hnt.dental.entities.Doctors;
import com.hnt.dental.entities.Service;
import com.hnt.dental.util.ConnectionUtils;
import org.apache.commons.lang3.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ServiceDaoImpl implements ServiceDao {
    private static final String GET_ALL_SERVICE = "SELECT " +
            "s.id, " +
            "s.name, " +
            "GROUP_CONCAT(st.name SEPARATOR ',') as type, " +
            "CONCAT(MIN(sf.fee), ' ~ ', MAX(sf.fee)) as fee, " +
            "s.image " +
            "FROM  service s  " +
            "INNER JOIN service_fee sf on s.id = sf.service_id  " +
            "INNER JOIN service_type st on sf.service_type = st.id  " +
            "where ( s.name like ? or st.name  like ? ) " +
            "AND st.id like ? " +
            "GROUP BY s.id " +
            "LIMIT ? OFFSET ? ";

    private static final String SQL_COUNT_SERVICE = "SELECT count(*) FROM service s " +
            "INNER JOIN service_fee sf on s.id = sf.service_id  " +
            "INNER JOIN service_type st on sf.service_type = st.id  " +
            "where ( s.name like ? or st.name  like ? ) order by s.id ";


    private static final String SQL_GET_SERVICE_DETAIL_BY_SERVICE_ID = "SELECT s.id, s.name, sf.fee, st.name as type, s.image, s.description  FROM service s " +
            "inner join service_fee sf on sf.service_id = s.id " +
            "inner join service_type st on sf.service_type = st.id " +
            "where  s.id = ? and st.id = ?";

    private static final String SQL_GET_TYPE_BY_SERVICE_ID = "SELECT st.id, st.name FROM service_type st " +
            "inner join service_fee sf on sf.service_type = st.id " +
            "inner join service s on s.id = sf.service_id " +
            "where s.id = ? ";

    private static final String SQL_GET_DOCTOR_BY_ID_SERVICE_AND_ID_TYPE = "SELECT d.id, d.full_name, d.image, st.name as type , dr.name as rankName from doctors d " +
            "            inner join service_doctor sd on sd.id_doctor = d.id " +
            "            inner join doctor_rank dr on d.rank_id = dr.id " +
            "            inner join service s on sd.id_service = s.id " +
            "            inner join service_fee sf on sf.service_id = s.id " +
            "            inner join service_type st on st.id = sf.service_type " +
            "            where s.id = ? and st.id = ?";

    private static final String SQL_GET_TOP_SERVICE = "SELECT s.id, " +
            "            s.name, " +
            "            GROUP_CONCAT(distinct st.name SEPARATOR ',') as type, " +
            "            CONCAT(MIN(sf.fee), ' ~ ', MAX(sf.fee)) as fee, " +
            "            s.image,s.description " +
            "            FROM  service s  " +
            "            INNER JOIN service_fee sf on s.id = sf.service_id  " +
            "            INNER JOIN service_type st on sf.service_type = st.id  " +
            "            LEFT JOIN booking k on k.service_id = s.id " +
            "            GROUP BY s.id " +
            "            ORDER BY RAND() LIMIT 6";

    private static final String SQL_GET_ALL_TYPE = "SELECT id, name FROM service_type";
    private static final String SQL_GET_ALL_SERVICE_SEARCH_HOME = "SELECT id, name FROM service;";

    private static final String SQL_GET_All_SERVICE_MANAGEMENT = "select s.id,  s.name, " +
            "            GROUP_CONCAT(st.name SEPARATOR ',') as type, " +
            "            CONCAT(MIN(sf.fee), ' ~ ', MAX(sf.fee)) as fee , " +
            "            s.image ,s.status " +
            "            FROM  service s " +
            "            LEFT JOIN service_fee sf on s.id = sf.service_id  " +
            "            LEFT JOIN service_type st on sf.service_type = st.id " +
            "            where ( s.name like ? ) " +
            "            OR s.status like ?" +
            "            GROUP BY s.id " +
            "            LIMIT ? OFFSET ? ";
    private static final String SQL_GET_SERVICE_DETAIL_MANAGEMENT_BY_ID = "SELECT s.id, s.name, s.description, s.image, s.status FROM service s " +
            "where s.id = ?";

    private static final String SQL_GET_SERVICE_TYPE_MANAGEMENT_BY_ID = "SELECT st.id, sf.fee, st.name as type  FROM service s " +
            "            inner join service_fee sf on sf.service_id = s.id  " +
            "            inner join service_type st on sf.service_type = st.id " +
            "            where  s.id = ? ";

    private static final String SQL_GET_DOCTOR_OF_SERVICE_MANAGEMENT_BY_ID = "SELECT d.id as doctorId, d.full_name, a.email, group_concat(st.name) as type " +
            "            FROM service s " +
            "            INNER JOIN service_doctor sd on s.id = sd.id_service " +
            "            INNER JOIN doctors d on d.id = sd.id_doctor " +
            "            INNER JOIN accounts a on d.id = a.id " +
            "            INNER JOIN doctor_rank dr on d.rank_id = dr.id " +
            "            INNER JOIN doctor_of_rank dor on dor.rank_id = dr.id " +
            "            INNER JOIN service_type st on dor.type_id = st.id " +
            "            WHERE s.id =  ? " +
            "            group by d.id, d.full_name, a.email";

    private static final String SQL_GET_TYPE_OF_DOCTOR_BY_ID = "SELECT d.id as doctorId, st.name, st.id as typeId " +
            "FROM service s " +
            "INNER JOIN service_doctor sd on s.id = sd.id_service " +
            "INNER JOIN doctors d on d.id = sd.id_doctor " +
            "INNER JOIN accounts a on d.id = a.id " +
            "INNER JOIN doctor_rank dr on d.rank_id = dr.id " +
            "INNER JOIN doctor_of_rank dor on dor.rank_id = dr.id " +
            "INNER JOIN service_type st on dor.type_id = st.id " +
            "WHERE s.id = ? and d.id = ? " +
            "group by  d.full_name, a.email, st.name,st.id ";

    private static final String SQL_UPDATE_SERVICE_DETAIL_MANAGEMENT_BY_ID = "UPDATE service " +
            "            SET name= ? , " +
            "            image= ?, description= ?, " +
            "            updated_at= ?, status= ? " +
            "            where id= ?";
    private static final String SQL_INSERT_SERVICE_MANAGEMENT = "INSERT INTO service " +
            "(name, description, image, created_at, status) " +
            "VALUES(?, ?, ?, ?, ?)";

    private static final String SQL_GET_SERVICE_TYPE_AVAILABLE = "select st1.id, st1.name from service_type st1 " +
            "where st1.id NOT IN " +
            "(select st.id from service_type st " +
            "inner join service_fee sf on sf.service_type = st.id " +
            "inner join service s on s.id = sf.service_id " +
            "where s.id =? )";
    private static final String SQL_UPDATE_SERVICE_FEES = "INSERT INTO `hnt_dental`.`service_fee` (`service_id`, `service_type`, `fee`) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE_SERVICE_FEE = "UPDATE hnt_dental.service_fee " +
            "SET fee= ?" +
            "WHERE service_id= ? AND service_type= ?";

    private static final String DELETE_DOCTOR = "DELETE FROM service_doctor WHERE (id_doctor = ?) and (id_service = ?)";

    @Override
    public List<Service> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }

    @Override
    public Optional<Service> get(int id) throws SQLException {
        return Optional.empty();
    }

    @Override
    public Long save(Service service) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SQL_INSERT_SERVICE_MANAGEMENT, service.getName(),
                service.getDescription(), service.getImage(), service.getCreatedAt(), service.getStatus());
        return null;
    }


    @Override
    public void update(Service service) throws SQLException {

    }

    @Override
    public void delete(Service service) throws SQLException {

    }

    @Override
    public List<ServiceResDto> getAllServiceDao(Integer offset, Integer limit, String search, String typeId) throws Exception {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        typeId = StringUtils.isNotEmpty(typeId) ? typeId : "%";
        ResultSet rs = ConnectionUtils.executeQuery(GET_ALL_SERVICE, search, search, typeId, limit, offset);
        List<ServiceResDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceResDto.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .image(rs.getString("image"))
                            .fee(rs.getString("fee"))
                            .type(rs.getString("type"))
                            .build());
        }
        ConnectionUtils.closeConnection();
        return result;
    }
    @Override
    public Integer countListService(String search) throws SQLException {
        search = "%" + search + "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_SERVICE, search, search);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }


    @Override
    public List<ServiceManagementDto> getAllServiceManagement(Integer offset, Integer limit, String search) throws SQLException {
        search = StringUtils.isNotEmpty(search) ? "%" + search.toLowerCase() + "%" : "%";
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_All_SERVICE_MANAGEMENT, search, search, limit, offset);
        List<ServiceManagementDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceManagementDto.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .image(rs.getString("image"))
                            .fee(rs.getString("fee"))
                            .type(rs.getString("type"))
                            .status(rs.getString("status"))
                            .build());
        }
        ConnectionUtils.closeConnection();
        return result;
    }

    @Override
    public ServiceDetailDto getServiceDetailManagementById(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SERVICE_DETAIL_MANAGEMENT_BY_ID, id);
        if (rs.next()) {
            return ServiceDetailDto.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .image(rs.getString("image"))
                    .description(rs.getString("description"))
                    .status(Boolean.valueOf(rs.getString("status")))
                    .build();
        }
        return null;
    }

    @Override
    public void updateServiceDetailManagementById(ServiceDetailDto serviceDetailDto) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_UPDATE_SERVICE_DETAIL_MANAGEMENT_BY_ID,
                serviceDetailDto.getName(),
                serviceDetailDto.getImage(),
                serviceDetailDto.getDescription(),
                serviceDetailDto.getUpdateAt(),
                serviceDetailDto.getStatus(),
                serviceDetailDto.getId());
    }

    @Override
    public List<ServiceManagementDto> getServiceTypeDetailManagementById(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SERVICE_TYPE_MANAGEMENT_BY_ID, id);
        List<ServiceManagementDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceManagementDto.builder()
                            .id(rs.getLong("id"))
                            .fee(rs.getString("fee"))
                            .type(rs.getString("type"))
                            .build());
        }
        return result;
    }

    @Override
    public List<ServiceDoctorManagementDto> getDoctorOfServiceManagementById(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_DOCTOR_OF_SERVICE_MANAGEMENT_BY_ID, id);
        List<ServiceDoctorManagementDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceDoctorManagementDto.builder()
                            .id(rs.getLong("doctorId"))
                            .name(rs.getString("full_name"))
                            .email(rs.getString("email"))
                            .type(rs.getString("type"))
                            .build());
        }
        return result;
    }

    @Override
    public List<ServiceTypeOfDoctor> getTypeOfDoctorByDoctorId(Long idService, Long idDoctor) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_TYPE_OF_DOCTOR_BY_ID, idService, idDoctor);
        List<ServiceTypeOfDoctor> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceTypeOfDoctor.builder()
                            .doctors(Doctors.builder().id(rs.getLong("doctorId")).build())
                            .idType(rs.getLong("typeId"))
                            .nameType(rs.getString("name"))
                            .build());
        }
        return result;
    }

    @Override
    public List<ServiceTypeDto> getTypeOfServiceAvailable(Long idService) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SERVICE_TYPE_AVAILABLE, idService);
        List<ServiceTypeDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceTypeDto.builder()
                            .idType(rs.getLong("id"))
                            .nameType(rs.getString("name"))
                            .build());
        }

        return result;
    }

    @Override
    public void updateServiceFeeByServiceTypeId(Long idService, Long idServiceType, Double fee) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_UPDATE_SERVICE_FEES, idService, idServiceType, fee);
    }

    @Override
    public void updateServiceFee(Long idService, Long idServiceType, Double fee) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_UPDATE_SERVICE_FEE, fee, idService, idServiceType);
    }

    @Override
    public void deleteDoctor(Long id, Long doctorId) throws SQLException {
        ConnectionUtils.executeUpdate(DELETE_DOCTOR, doctorId, id);
    }

    @Override
    public ServiceDetailDto getServiceDetailByServiceId(Long id, Long typeId) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_SERVICE_DETAIL_BY_SERVICE_ID, id, typeId);
        if (rs.next()) {
            return ServiceDetailDto.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .image(rs.getString("image"))
                    .fee(rs.getString("fee"))
                    .type(rs.getString("type"))
                    .description(rs.getString("description"))
                    .build();
        }
        return null;
    }

    @Override
    public List<ServiceTypeDto> getTypeByServiceId(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_TYPE_BY_SERVICE_ID, id);
        List<ServiceTypeDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceTypeDto.builder()
                            .idType(rs.getLong("id"))
                            .nameType(rs.getString("name"))
                            .build());
        }
        return result;
    }

    @Override
    public List<DoctorByServiceIdDto> getDoctorByServiceIdAndServiceType(Long id, Long idType) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_DOCTOR_BY_ID_SERVICE_AND_ID_TYPE, id, idType);
        List<DoctorByServiceIdDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    DoctorByServiceIdDto.builder()
                            .id(rs.getLong("id"))
                            .fullName(rs.getString("full_name"))
                            .image(rs.getString("image"))
                            .rankName(rs.getString("rankName"))
                            .type(rs.getString("type"))
                            .build());
        }
        return result;
    }

    @Override
    public List<ServiceSearchHomeDto> getAllServiceHome() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_SERVICE_SEARCH_HOME);
        List<ServiceSearchHomeDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceSearchHomeDto.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .build());
        }
        return result;
    }

    @Override
    public List<ServiceTypeDto> getALlType() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_TYPE);
        List<ServiceTypeDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceTypeDto.builder()
                            .idType(rs.getLong("id"))
                            .nameType(rs.getString("name"))
                            .build());
        }
        ConnectionUtils.closeConnection();
        return result;
    }
    @Override
    public List<ServiceDetailDto> getTopService() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_TOP_SERVICE);
        List<ServiceDetailDto> result = new ArrayList<>();
        while (rs.next()) {
            result.add(
                    ServiceDetailDto.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .image(rs.getString("image"))
                            .fee(rs.getString("fee"))
                            .type(rs.getString("type"))
                            .description(rs.getString("description"))
                            .build());
        }
        return result;
    }



}
