package com.jetec.CRM.repository;

import com.jetec.CRM.model.EvaluateTaskBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EvaluateTaskRepository extends JpaRepository<EvaluateTaskBean,String> {
    List<EvaluateTaskBean> findByEvaluateid(String id);
}
