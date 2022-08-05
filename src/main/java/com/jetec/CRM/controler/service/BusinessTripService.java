package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.BusinessTripBean;
import com.jetec.CRM.repository.BusinessTripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class BusinessTripService {

    @Autowired
    BusinessTripRepository btr;
    //出差申請
    public void save(BusinessTripBean btBean) {
        btr.save(btBean);
    }

    public BusinessTripBean getById(Integer i) {
        return btr.findById(i).orElse(null);
    }
}
