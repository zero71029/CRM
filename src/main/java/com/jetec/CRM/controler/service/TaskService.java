package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.EvaluateBean;
import com.jetec.CRM.model.EvaluateTaskBean;
import com.jetec.CRM.model.LeaveBean;
import com.jetec.CRM.repository.EvaluateRepository;
import com.jetec.CRM.repository.EvaluateTaskRepository;
import com.jetec.CRM.repository.LeaveRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
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
    @Autowired
    LeaveRepository lr;

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
        Pageable p =   PageRequest.of(pag, 40, Sort.Direction.DESC,"evaluatedate");
        Page<EvaluateBean> page =  er.findAll(p);
        Map<String, Object> map = new HashMap<>();
        map.put("list", page.getContent());
        map.put("total", page.getTotalElements());
        map.put("userList", er.getName());

        return map;
    }

    public Map<String, Object> getList(Integer pag, String name) {
        Pageable p =   PageRequest.of(pag, 40,Sort.Direction.DESC,"evaluatedate");
        Page<EvaluateBean> page = er.findByName(name,p);
        Map<String, Object> map = new HashMap<>();
        map.put("list", page.getContent());
        map.put("total", page.getTotalElements());

        return map;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除每日任務
    public void delMarket(List<String> id) {
        for (String i : id) {
           er.deleteById(i);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索每日任務
    public List<EvaluateBean> selecttask(String name, Integer pag) {
        Pageable p =   PageRequest.of(pag, 40,Sort.Direction.DESC,"evaluatedate");
        Page<EvaluateBean> page = er.findByName(name,p);
        return page.getContent();
    }
    //儲存請假單
    public void saveLeave(LeaveBean leaveBean) {
        lr.save(leaveBean);
    }
    //請假單列表
    public List<LeaveBean> getLeaveList(String mon) {
        LocalDate d = LocalDate.parse(mon+"-01");
        //本月的第一天
        LocalDate firstday = LocalDate.of(d.getYear(),d.getMonth(),1);
        //本月的最后一天
        LocalDate lastDay =d.with(TemporalAdjusters.lastDayOfMonth());
        List<LeaveBean> list = lr.findByLeavedayBetween(firstday.toString() ,lastDay.toString(),Sort.by(Sort.Direction.DESC,"leaveday"));
        return list;
    }
}
