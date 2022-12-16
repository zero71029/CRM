package com.jetec.CRM.controler.service;


import com.jetec.CRM.model.LaboratoryForumContentBean;
import com.jetec.CRM.repository.LaboratoryForumContentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LaboratoryForumContentService {
    @Autowired
    LaboratoryForumContentRepository lfcr;

    public void save(LaboratoryForumContentBean lfContent) {
        lfcr.save(lfContent);

    }


    public LaboratoryForumContentBean findById(String forumid) {
        return lfcr.findById(forumid).orElse(new LaboratoryForumContentBean());
    }
}
