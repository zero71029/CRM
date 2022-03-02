package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.MarketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StatisticService {
    @Autowired
    MarketRepository mr ;

    //搜索公司數量
    public List<String> selectCompany(String startDay, String endDay) {


        return mr.selectCompany(startDay,endDay);
    }
}
