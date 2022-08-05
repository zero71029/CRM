package com.jetec.CRM;

import com.github.f4b6a3.uuid.UuidCreator;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;

@SpringBootTest
public class SpringTest {

    @Autowired
    PotentialCustomerRepository PCR;

    @Test
    public void XXXX()  {
        String phone = "833" ;
        String startDay = "2022-01-04";
        String  endDay = "2022-08-04";
        Sort sort = Sort.by(Sort.Direction.DESC, "aaa");
        System.out.println(PCR.findByPhoneLikeAndAaaBetween("%" +phone+ "%", startDay, endDay, sort));
        System.out.println(PCR.findByMoblieLikeAndAaaBetween("%" +phone+ "%", startDay, endDay, sort));
        System.out.println(PCR.findByFaxLikeAndAaaBetween("%" +phone+ "%", startDay, endDay, sort));
    }
}
