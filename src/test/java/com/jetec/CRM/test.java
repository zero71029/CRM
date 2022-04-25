package com.jetec.CRM;

import com.jetec.CRM.repository.MarketRepository;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.TimeUnit;

@SpringBootTest
public class test {
@Autowired
    MarketRepository mr;
    @Test
    public  void  vi(){
        mr.layout();
    }
}

