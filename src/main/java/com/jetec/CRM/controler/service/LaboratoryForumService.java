package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.LaboratoryForumBean;
import com.jetec.CRM.repository.LaboratoryForumContentRepository;
import com.jetec.CRM.repository.LaboratoryForumRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LaboratoryForumService {
    @Autowired
    LaboratoryForumRepository lfr;
    @Autowired
    LaboratoryForumContentRepository lfcr;
    public LaboratoryForumBean save(LaboratoryForumBean lfBean) {
       return lfr.save(lfBean);
    }




    public Page<LaboratoryForumBean> findByState(String state, Pageable pageable) {
        return lfr.findByState(state,pageable);
    }

    public LaboratoryForumBean findById(String forumid) {
        return lfr.findById(forumid).orElse(null);
    }

    public boolean existsById(String forumid) {
        return lfr.existsById(forumid);
    }

    public void delById(String forumid) {


    }
}
