package com.jetec.CRM.repository;

import com.jetec.CRM.model.BosMessageBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BosMessageRepository extends JpaRepository<BosMessageBean,String> {


    void deleteByBosmessageid(String bosmessageid);

    List<BosMessageBean> findByBosid(String bosid, Sort sort);
}
