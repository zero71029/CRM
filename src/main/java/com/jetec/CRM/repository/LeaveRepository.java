package com.jetec.CRM.repository;

import com.jetec.CRM.model.LeaveBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LeaveRepository extends JpaRepository<LeaveBean,Integer> {

    void deleteByUuid(String uuid);

    boolean existsByUuid(String uuid);

    @Query(value = "ALTER TABLE askleave AUTO_INCREMENT = 1;",nativeQuery = true)
    @Modifying
    void delAutoIncrement();

    List<LeaveBean> findByLeavedayBetweenAndDel(String toString, String toString1, int i, Sort leaveday);

    List<LeaveBean> findByUuid(String uuid);

    List<LeaveBean> findByUserLikeAndDelAndLeavedayBetween(String person, int i, String start, String end, Sort leaveday);

    List<LeaveBean> findByUserLikeAndDel(String s, int i, Sort leaveday);
}
