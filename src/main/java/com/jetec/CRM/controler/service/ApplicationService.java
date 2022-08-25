package com.jetec.CRM.controler.service;


import com.jetec.CRM.model.ApplicationBean;
import com.jetec.CRM.repository.ApplicationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ApplicationService {

    @Autowired
    ApplicationRepository ar;


    public ApplicationBean save(ApplicationBean aBean) {
        return ar.save(aBean);
    }

    public List<ApplicationBean> findAll() {
        return ar.findAll(Sort.by(Sort.Direction.DESC, "createtime"));
    }

    public ApplicationBean getById(Integer applicationid) {
        return ar.findById(applicationid).orElse(null);
    }

    public void del(List<Integer> id) { id.forEach(ar::deleteById); }
}
