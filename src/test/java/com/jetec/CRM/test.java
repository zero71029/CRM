package com.jetec.CRM;

import com.jetec.CRM.model.ChangeMessageBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ChangeMessageRepository;
import com.jetec.CRM.repository.MarketRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;

import java.time.LocalDateTime;
import java.util.List;

@SpringBootTest
public class test {
    @Autowired
    ChangeMessageRepository cmr;

    @Test
    public void sendSimpleMail() throws Exception {
        Sort sort = Sort.by(Sort.Direction.DESC, "createtime");
        LocalDateTime str = LocalDateTime.now();
        LocalDateTime end = str.minusDays(7);
        for (int x = 0; x < 10; x++) {
            Long start = System.currentTimeMillis();

//            System.out.println("起始 : " + str);
//            System.out.println("結束 : " + end);
            List<ChangeMessageBean> list = null;
            for (int i = 0; i < 100; i++) {

              list =   cmr.findAll(sort);
            }
            System.out.println("=======================================");
            System.out.println(x);
            System.out.println("總共幾筆 : " + list.size() + " 筆");
            System.out.println("花費時間 : " + (System.currentTimeMillis() - start));
        }
    }
}

