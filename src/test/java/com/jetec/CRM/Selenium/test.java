package com.jetec.CRM.Selenium;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.concurrent.TimeUnit;

public class test {


    @Test
    void contextLoads() throws InterruptedException {

        //配置
        System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
        ChromeDriver driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);

        for (int i = 0 ; i <=9 ; i++){
            driver.get("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=csv&date=20210"+i+"01&stockNo=5871");
            Thread.sleep(5000);
        }

        for (int i = 10 ; i <= 12 ; i++){
            driver.get("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=csv&date=2021"+i+"01&stockNo=5871");
            Thread.sleep(5000);

        }











    }
}
