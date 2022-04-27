package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.JobDescriptionBean;
import com.jetec.CRM.repository.JobDescriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class JobDescriptionService {
    @Autowired
    JobDescriptionRepository jdr;


    public void save(JobDescriptionBean jdBean) {
        jdr.save((jdBean));
    }

    public List<JobDescriptionBean> findAll() {

        return  jdr.findAll();
    }
}
