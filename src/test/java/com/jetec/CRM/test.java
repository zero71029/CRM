package com.jetec.CRM;

import com.jetec.CRM.repository.ChangeMessageRepository;
import com.jetec.CRM.repository.MarketRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class test {
    @Autowired
    MarketRepository mr;
    @Autowired
    ChangeMessageRepository cmr;

    @Test
    public void vi()  {

    }
}

