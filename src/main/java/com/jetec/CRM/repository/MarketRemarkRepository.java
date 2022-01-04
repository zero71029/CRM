package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.MarketRemarkBean;

public interface MarketRemarkRepository extends JpaRepository<MarketRemarkBean, Integer>{
List<MarketRemarkBean> findByMarketid(Integer marketid);


void deleteByMarketid(Integer i);
}
