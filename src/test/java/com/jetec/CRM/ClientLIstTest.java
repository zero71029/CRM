package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class ClientLIstTest {

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

        //登入
        driver.findElementByLinkText("登入").click();
        driver.findElementById("username").sendKeys("jeter.tony56@gmail.com");
        driver.findElementById("password").sendKeys("tp6u04xup6");
        driver.findElement(By.xpath("/html/body/div/form/button")).click();

///////////////////////////////////////////////////////////////////////////////////////////////////
        //點擊客戶管理
        driver.findElement(By.xpath("/html/body/div[1]/div/div[1]/ul/button[5]")).click();
        //點擊客戶
        driver.findElementByClassName("clientbar").click();
        List clients = driver.findElementsByName("mak");
        System.out.println("第1頁  :" + clients.size() + "筆");
        driver.findElementById("activity").click();
        Thread.sleep(1000);

        //搜索 科技
        driver.findElementByName("name").sendKeys("科技");
        driver.findElementById("selectClient").click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 科技  :" + clients.size() + "筆");


    }
}
