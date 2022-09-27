package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.CalenderBean;
import com.jetec.CRM.repository.CalenderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@Service
@Transactional
public class CalenderService {

    @Autowired
    CalenderRepository cr;

    public void save(CalenderBean cBean) {
        cr.save(cBean);
    }

    public List<CalenderBean> getCalendarInitByDay(LocalDate d ){
        //本月的第一天
        LocalDate firstday = LocalDate.of(d.getYear(),d.getMonth(),1);
        //本月的最后一天
        LocalDate lastDay =d.with(TemporalAdjusters.lastDayOfMonth());
        return cr.findByDayBetween(firstday.toString(),lastDay.toString(), Sort.by(Sort.Direction.DESC,"day"));
    }

    public CalenderBean getById(Integer id) {
        return cr.findById(id).orElse(null);
    }
}
