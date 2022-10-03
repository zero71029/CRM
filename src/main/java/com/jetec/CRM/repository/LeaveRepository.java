package com.jetec.CRM.repository;

import com.jetec.CRM.model.LeaveBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LeaveRepository extends JpaRepository<LeaveBean,Integer> {
    List<LeaveBean> findByLeavedayBetween(String start, String end, Sort leaveday);

    void deleteByUuid(String uuid);

    boolean existsByUuid(String uuid);


}
