package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.TimeUnit;

@SpringBootTest
public class test {


    @Test
    public  void  vi(){
        for (int i = 0 ; i <1 ; i++) {
            //配置
            System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
            ChromeDriver driver = new ChromeDriver();
            driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);
            driver.get("http://jetec.com.tw/About");
            WebDriver.Options op = driver.manage();
            op.window().maximize();//全屏
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            driver.findElementById("edit-privacy--2").click();
            driver.findElementById("edit-email--2").sendKeys("dddddd@ffff.com");
            driver.findElementById("edit-name--2").sendKeys("ddddddddd");
            driver.findElementById("btn").click();
        }
    }
}

