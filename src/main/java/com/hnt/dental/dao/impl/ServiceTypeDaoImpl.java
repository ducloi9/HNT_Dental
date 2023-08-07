package com.hnt.dental.dao.impl;

import com.hnt.dental.dao.ServiceTypeDao;
import com.hnt.dental.dto.response.DoctorSummaryRes;
import com.hnt.dental.dto.response.ServiceTypeListDto;
import com.hnt.dental.dto.response.TypeServiceDto;
import com.hnt.dental.entities.DoctorRank;
import com.hnt.dental.entities.ServiceType;
import com.hnt.dental.util.ConnectionUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ServiceTypeDaoImpl implements ServiceTypeDao {
    private final static String SQL_SAVE_SERVICE_TYPE = "INSERT INTO service_type " +
            "(name, description, created_at, updated_at) " +
            "VALUES(?, ?, ?, ?)";
    private final static String SQL_GET_ALL_SERVICE_TYPE = "select st.id, st.name, st.description, group_concat(dr.name) " +
            "from service_type st " +
            "LEFT join doctor_of_rank dor on dor.type_id = st.id " +
            "left join doctor_rank dr on dr.id = dor.rank_id " +
            "group by  st.id, st.name, st.description " +
            "LIMIT ? OFFSET ? ";
    private static final String SQL_COUNT_SERVICE = "select count(*) from service_type st " +
            "LEFT join doctor_of_rank dor on dor.type_id = st.id " +
            "left join doctor_rank dr on dr.id = dor.rank_id";
    private static final String SQL_GET_ALL_RANK_OF_TYPE = "select  dr.id, dr.name, dor.type_id from doctor_rank dr " +
            "inner join doctor_of_rank dor on dr.id =  dor.rank_id " +
            "where dor.type_id= ?";
    private static final String GET_DETAIL_TYPE = "select * from service_type st " +
            "where st.id = ? ";
    private static final String SQL_GET_RANK_OF_TYPE_AVAILABLE = "select dr1.id, dr1.name from doctor_rank dr1 " +
            "where dr1.id not in ( " +
            "select  dr.id from doctor_rank dr " +
            "            inner join doctor_of_rank dor on dr.id =  dor.rank_id " +
            " where dor.type_id= ?)";

    private static final String SQL_INSERT_RANK_TO_TYPE = "INSERT INTO hnt_dental.doctor_of_rank " +
            "(rank_id,type_id) " +
            "VALUES(?,?) ";
    private static final String SQL_DELETE_RANK_FROM_TYPE = "DELETE FROM hnt_dental.doctor_of_rank\n" +
            "WHERE rank_id= ? AND type_id= ? ";
    private static final String SQL_UPDATE_SERVICE_TYPE = "UPDATE hnt_dental.service_type " +
            "SET name= ? , description= ? , updated_at= ? " +
            "WHERE id= ? ";
    private static final String SQL_DELETE_SERVICE_TYPE = "DELETE FROM hnt_dental.service_type " +
            "WHERE id= ?";

    @Override
    public List<ServiceType> getAll(Integer offset, Integer limit, String search) throws SQLException {
        return null;
    }

    @Override
    public Optional<ServiceType> get(int id) throws SQLException {
        return Optional.empty();
    }

    @Override
    public Long save(ServiceType serviceType) throws SQLException, ClassNotFoundException {
        ConnectionUtils.executeUpdate(SQL_SAVE_SERVICE_TYPE, serviceType.getName(), serviceType.getDescription(),
                serviceType.getCreatedAt(), serviceType.getUpdatedAt());
        return null;
    }

    @Override
    public void update(ServiceType serviceType) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_UPDATE_SERVICE_TYPE, serviceType.getName(), serviceType.getDescription(),
                serviceType.getUpdatedAt(), serviceType.getId());
    }

    @Override
    public void delete(ServiceType serviceType) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_DELETE_SERVICE_TYPE, serviceType.getId());
    }

    @Override
    public List<ServiceTypeListDto> getAll(Integer offset, Integer limit) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_SERVICE_TYPE, limit, offset);
        List<ServiceTypeListDto> serviceTypes = new ArrayList<>();
        while (rs.next()) {
            serviceTypes.add(ServiceTypeListDto.builder()
                    .id(rs.getLong(1))
                    .name(rs.getString(2))
                    .description(rs.getString(3))
                    .rankName(rs.getString(4))
                    .build());
        }
        return serviceTypes;
    }


    @Override
    public Integer countListService() throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_COUNT_SERVICE);
        if (rs.next()) {
            return rs.getInt(1);
        }
        ConnectionUtils.closeConnection();
        return null;
    }

    @Override
    public List<TypeServiceDto> getAllRankOfType(Long idType) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_ALL_RANK_OF_TYPE, idType);
        List<TypeServiceDto> doctorSummaryRes = new ArrayList<>();
        while (rs.next()) {
            doctorSummaryRes.add(TypeServiceDto.builder()
                    .id(rs.getLong("type_id"))
                    .doctorRank(DoctorRank.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .build())
                    .build());
        }
        return doctorSummaryRes;
    }

    @Override

    public ServiceType getServiceTypeDetail(Long id) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(GET_DETAIL_TYPE, id);
        if (rs.next()) {
            return ServiceType.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .description(rs.getString("description"))
                    .build();
        }
        return null;
    }

    @Override
    public List<DoctorRank> addRankToType(Long idType) throws SQLException {
        return null;
    }

    @Override
    public List<DoctorRank> listRankOfTypeAvailable(Long idType) throws SQLException {
        ResultSet rs = ConnectionUtils.executeQuery(SQL_GET_RANK_OF_TYPE_AVAILABLE, idType);
        List<DoctorRank> doctorRanks = new ArrayList<>();
        while (rs.next()) {
            doctorRanks.add(DoctorRank.builder()
                    .id(rs.getLong("id"))
                    .name(rs.getString("name"))
                    .build());
        }
        return doctorRanks;
    }

    @Override
    public Long saveRankToType(Long idType, Long idRank) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_INSERT_RANK_TO_TYPE, idRank, idType);
        return null;
    }

    @Override
    public void deleteRankFromType(Long idType, Long idRank) throws SQLException {
        ConnectionUtils.executeUpdate(SQL_DELETE_RANK_FROM_TYPE, idRank, idType);
    }


}
