package com.jetec.CRM;

import com.jetec.CRM.model.ChangeMessageBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ChangeMessageRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;

import java.time.LocalDateTime;
import java.util.List;

@SpringBootTest
public class test {
    @Autowired
    PotentialCustomerRepository PCR;

    @Test
    public void XXX() throws Exception {
        System.out.println(PCR.findByUserAndAaaBetween("謝姍妤", "2022-07-04 00:00", "2022-07-08 24:00", Sort.by(Sort.Direction.DESC, "aaa")));
    }
}

