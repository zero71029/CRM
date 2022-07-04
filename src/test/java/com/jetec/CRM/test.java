package com.jetec.CRM;

import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.MarketRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;

import java.util.List;

@SpringBootTest
public class test {

    @Autowired
    MarketRepository mr;

    @Test
    public void sendSimpleMail() throws Exception {
        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();
//        System.out.println(mr.findAll());
            List<MarketBean> list = null;
            for (int i = 0; i < 100; i++) {
                list = mr.findAll(Sort.by(Sort.Direction.DESC,"aaa"));
            }

//        list.forEach(System.out::println);
            System.out.println("=======================================");
            System.out.println("總共幾筆 : " + list.size() + " 筆");
            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }
}

