package com.jetec.CRM.repository;

import com.jetec.CRM.model.MarketFileBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MarketFileRepository extends JpaRepository<MarketFileBean,String> {


    List<MarketFileBean> findByFileforeignid(String fileforeignid);

    boolean existsByFileforeignid(String fileforeignid);

    List<MarketFileBean> findByName(String name);

    void deleteAllByName(String name);
}
