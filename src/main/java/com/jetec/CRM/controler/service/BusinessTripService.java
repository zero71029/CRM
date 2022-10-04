package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.BusinessTripBean;
import com.jetec.CRM.repository.BusinessTripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

@Service
@Transactional
public class BusinessTripService {

    @Autowired
    BusinessTripRepository btr;
    //出差申請
    public BusinessTripBean save(BusinessTripBean btBean) {
     return   btr.save(btBean);
    }

    public List<BusinessTripBean> getBusinessTripList(String mon) {
        LocalDate d = LocalDate.parse(mon+"-01");
        //本月的第一天
        LocalDate firstday = LocalDate.of(d.getYear(),d.getMonth(),1);
        //本月的最后一天
        LocalDate lastDay =d.with(TemporalAdjusters.lastDayOfMonth());
        return btr.findByTripdayBetween(firstday.toString() ,lastDay.toString(), Sort.by(Sort.Direction.DESC,"tripday"));
    }
    //讀取出差資料
    public BusinessTripBean getBusinessTrip(Integer tripid) {
        return btr.findById(tripid).orElse(new BusinessTripBean());
    }

    public boolean existsById(Integer id) {
        return btr.existsById(id);
    }

    public void delByUuid(Integer id) {
        btr.deleteById(id);
    }

    public void delNull() {
        btr.delNull();
        btr.zero();
    }
}
