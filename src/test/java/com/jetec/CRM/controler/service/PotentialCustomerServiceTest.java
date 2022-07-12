package com.jetec.CRM.controler.service;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class PotentialCustomerServiceTest {
    @Autowired
    PotentialCustomerService pcs;

    @Test
    @Transactional
    @Rollback
    void savePotentialCustomer() {
        PotentialCustomerBean pcBean = new PotentialCustomerBean();
        String uuid = ZeroTools.getUUID();
        pcBean.setCustomerid(uuid);
        pcBean.setName("網管測試");
        pcs.SavePotentialCustomer(pcBean);
        PotentialCustomerBean save = pcs.getById(uuid);
        Assertions.assertEquals("網管測試",save.getName());
        List<String> id = new ArrayList<>();
        id.add(uuid);
        pcs.delPotentialCustomer(id);
        Assertions.assertEquals(null,pcs.getById(uuid));

        pcBean = new PotentialCustomerBean();
        pcBean.setName("網管測試");
        save = pcs.SavePotentialCustomer(pcBean);
        Assertions.assertEquals("網管測試",save.getName());


    }

    @Test
    void getList() {
        List<PotentialCustomerBean> lsst = pcs.getList(0);
        Assertions.assertTrue(lsst.size() > 0);
    }


    @Test
    void closed() {
    }

    @Test
    void delPotentialCustomer() {
    }

    @Test
    void selectPotentialCustomer() {
    }

    @Test
    void selectDate() {
    }

    @Test
    void selectStatus() {
    }

    @Test
    void selectSource() {
    }

    @Test
    void selectIndustry() {
    }

    @Test
    void addHelper() {
    }

    @Test
    void delHelper() {
    }

    @Test
    void selectPotentialCustomerTrack() {
    }

    @Test
    void saveTrackRemark() {
    }

    @Test
    void removeTrack() {
    }

    @Test
    void removeTrackremark() {
    }

    @Test
    void getTrackByCustomerid() {
    }

    @Test
    void selectcontent() {
    }

    @Test
    void gettodayTotal() {
    }

    @Test
    void existsById() {
    }

    @Test
    void selectPotential() {
    }

    @Test
    void getPotentialSubmitBos() {
    }

    @Test
    void expired() {
    }
}