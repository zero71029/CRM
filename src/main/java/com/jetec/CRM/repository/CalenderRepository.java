package com.jetec.CRM.repository;

import com.jetec.CRM.model.CalenderBean;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CalenderRepository extends JpaRepository<CalenderBean ,Integer> {
}
