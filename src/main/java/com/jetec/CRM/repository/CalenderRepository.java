package com.jetec.CRM.repository;

import com.jetec.CRM.model.CalenderBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CalenderRepository extends JpaRepository<CalenderBean ,Integer> {
    List<CalenderBean> findByDayBetween(String toString, String toString1, Sort day);
}
