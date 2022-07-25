package com.jetec.CRM;

import com.jetec.CRM.controler.PotentialController;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.repository.TrackRepository;
import org.junit.jupiter.api.Test;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;

@SpringBootTest
public class test {
    @Autowired
    TrackRepository tr;

    @Test
    public void XXX() throws Exception {
        Pageable pageable = PageRequest.of(0, 40, Sort.Direction.DESC, "aaa");
        List<TrackBean> l = null;
        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();
            for (int i = 0; i < 1000; i++) {
                l = tr.findByCustomerid("00a24b508a454e1186abc80cb8f838e3", Sort.by(Sort.Direction.DESC, "tracktime"));
            }
            System.out.println(l.size());
            System.out.println("=======================================");
            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }

    @Test
    public void test2() throws Exception {
        Pageable pageable = PageRequest.of(0, 40, Sort.Direction.DESC, "aaa");
        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();
            for (int i = 0; i < 1000; i++) {

            }
            System.out.println("==================test2=====================");

            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }

    @Test
    public void logtest() {
        Logger logger = LoggerFactory.getLogger(test.class);
        logger.info("*****讀取潛在客戶列表*****");
        logger.error("logback 成功了");
        logger.debug("logback 成功了");
    }
}

