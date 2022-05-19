package com.jetec.CRM.repository;

import com.jetec.CRM.model.ApplicationBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ApplicationRepository extends JpaRepository<ApplicationBean, Integer> {
}
