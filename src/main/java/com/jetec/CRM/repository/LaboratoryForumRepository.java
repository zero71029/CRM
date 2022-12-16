package com.jetec.CRM.repository;

import com.jetec.CRM.model.LaboratoryForumBean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LaboratoryForumRepository extends JpaRepository<LaboratoryForumBean,String> {
    Page<LaboratoryForumBean> findByState(String state, Pageable pageable);
}
