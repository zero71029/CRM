package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.MarketFileBean;
import com.jetec.CRM.repository.MarketFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UpfileService {

    @Autowired
    MarketFileRepository MFR;

    public MarketFileBean save(MarketFileBean fileBean) {
      return  MFR.save(fileBean);
    }
    public MarketFileBean getByid(String id) {
        return  MFR.getById(id);
    }
    public List<MarketFileBean> getByfileForeignid(String fileforeignid) {
        return  MFR.findByFileforeignid(fileforeignid);
    }

    public boolean existsByFileforeignid(String fileforeignid) {
        return MFR.existsByFileforeignid(fileforeignid);
    }
}
