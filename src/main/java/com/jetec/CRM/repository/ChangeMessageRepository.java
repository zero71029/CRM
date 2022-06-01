package com.jetec.CRM.repository;

import com.jetec.CRM.model.ChangeMessageBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ChangeMessageRepository extends JpaRepository<ChangeMessageBean,String> {
    List<ChangeMessageBean> findByChangeid(String id, Sort sort);



    @Query(value = "select createtime from ( SELECT  changeid,max(createtime) createtime from changemessage where changeid = ?1  group by changeid)as a ", nativeQuery = true)
    String getMaxCreateByMarketid(String id);
}
