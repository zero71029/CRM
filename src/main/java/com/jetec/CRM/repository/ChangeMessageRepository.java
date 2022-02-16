package com.jetec.CRM.repository;

import com.jetec.CRM.model.ChangeMessageBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ChangeMessageRepository extends JpaRepository<ChangeMessageBean,String> {
    List<ChangeMessageBean> findByChangeid(String id, Sort sort);
}
