package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.LeaveBean;
import com.jetec.CRM.repository.LeaveRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@Service
@Transactional
public class LeaveService {
    @Autowired
    LeaveRepository lr;


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
        return lr.findByLeavedayBetween(firstday.toString() ,lastDay.toString(), Sort.by(Sort.Direction.DESC,"leaveday"));
    }


    public LeaveBean getById(Integer leaveid) {
        return lr.findById(leaveid).orElse(null);
    }
}
