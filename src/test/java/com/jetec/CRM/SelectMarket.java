package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class SelectMarket {



    @Test
    void contextLoads() throws InterruptedException {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //配置
        System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
        ChromeDriver driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);
        driver.get("http://localhost:8080/CRM/");
        WebDriver.Options op = driver.manage();
        op.window().maximize();//全屏
        Thread.sleep(500);
        //登入
        driver.findElementByLinkText("登入").click();
        driver.findElementById("username").sendKeys("jeter.tony56@gmail.com");
        driver.findElementById("password").sendKeys("tp6u04xup6");
        driver.findElement(By.xpath("/html/body/div/form/button")).click();

///////////////////////////////////////////////////////////////////////////////////////////////////
        //銷售機會 搜索測試
        //點擊營銷模塊
        driver.findElement(By.xpath("/html/body/div[1]/div/div[1]/ul/button[1]")).click();

        //點擊售機會
        driver.findElementByClassName("marketbar").click();
        //點搜索
        driver.findElementById("search").click();
        //點日期選擇器
        driver.findElementByClassName("el-date-editor--daterange").click();
        //點一星期
        driver.findElementByXPath("/html/body/div[3]/div[1]/div[1]/button[2]").click();
        //點送出
        driver.findElementById("sendDay").click();
        List clients = driver.findElementsByName("mak");
        System.out.println("搜索 一星期  :" + clients.size() + "筆");

//負責人




    }

}
