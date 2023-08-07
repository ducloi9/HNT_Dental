package com.hnt.dental.dao;

import com.hnt.dental.dto.response.FeedbackDto;
import com.hnt.dental.entities.Feedback;

import java.util.List;

public interface FeedbackDao extends GenericDao<Feedback>{
    List<FeedbackDto> getFeedback(String sqlQuery, Long id) throws Exception;

    List<FeedbackDto> getFeedbackDoctor(Long id) throws Exception;
    List<FeedbackDto> getFeedbackService(Long id) throws Exception;
}
