package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.BosMessageBean;
import com.jetec.CRM.repository.BosMessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DirectorService {

    @Autowired
    BosMessageRepository bmr;
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存主管留言
    public void save(BosMessageBean bmBean) {
        bmr.save(bmBean);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //讀取主管留言
    public List<BosMessageBean> getBosMessageList(String bosid) {
        Sort sort = Sort.by(Sort.Direction.DESC,"createtime");
        return bmr.findByBosid(bosid,sort);
    }

    public List<BosMessageBean> delBosMessageList(String bosmessageid) {
        String bosid = bmr.getById(bosmessageid).getBosid();
        bmr.deleteByBosmessageid(bosmessageid);
        Sort sort = Sort.by(Sort.Direction.DESC,"createtime");
        return bmr.findByBosid(bosid,sort);
    }
}
