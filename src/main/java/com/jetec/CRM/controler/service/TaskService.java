package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.EvaluateBean;
import com.jetec.CRM.model.EvaluateTaskBean;
import com.jetec.CRM.model.WorkBean;
import com.jetec.CRM.repository.EvaluateRepository;
import com.jetec.CRM.repository.EvaluateTaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class TaskService {
    @Autowired
    EvaluateRepository er;
    @Autowired
    EvaluateTaskRepository etr;

    //讀取每⽇任務
    public EvaluateBean getById(String id) {
//        System.out.println(er.getById(id));
        return  er.getById(id);
    }

    //儲存每⽇任務
    public EvaluateBean SaveEvaluateBean(EvaluateBean bean) {
        return er.save(bean);
    }
    //刪除沒有的
    public void delnull() {
        er.delnull();
        er.delempty();
    }
    //讀取任務列表
    public List<EvaluateTaskBean> getTaskList(String id) {
        return  etr.findByEvaluateid(id);
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//任務列表
    public Map<String, Object> getList(Integer pag) {
        Pageable p =   PageRequest.of(pag, 20, Sort.Direction.DESC,"createtime");
        Page<EvaluateBean> page =  er.findAll(p);
        Map<String, Object> map = new HashMap<>();
        map.put("list", page.getContent());
        map.put("total", page.getTotalElements());

        return map;
    }

    public Map<String, Object> getList(Integer pag, String name) {
        Pageable p =   PageRequest.of(pag, 20,Sort.Direction.DESC,"createtime");
        Page<EvaluateBean> page = er.findByName(name,p);
        Map<String, Object> map = new HashMap<>();
        map.put("list", page.getContent());
        map.put("total", page.getTotalElements());

        return map;
    }
}
