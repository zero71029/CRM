package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class AddMarket {
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
        //淺在客戶 搜索測試
        //點擊營銷模塊

        driver.findElement(By.xpath("/html/body/div[1]/div/div[1]/ul/button[1]")).click();
        driver.findElementByClassName("marketbar").click();
        driver.findElementByXPath("/html/body/div[1]/div/div[2]/div[1]/div/label[1]").click();
        //彈窗
        Set wh = driver.getWindowHandles();
        Iterator<Object> it = wh.iterator();
        String p1 = (String) it.next();
        String p2 = (String) it.next();
        driver.switchTo().window(p2);
        driver.findElementByName("serialnumber").sendKeys("serialnumber");
        driver.findElementByName("name").sendKeys("name");
        driver.findElementByName("jobtitle").sendKeys("jobtitle");
        driver.findElementByName("contactphone").sendKeys("contactphone");
        driver.findElementByName("phone").sendKeys("phone");
        driver.findElementByName("contactextension").sendKeys("contactextension");
        driver.findElementByName("extension").sendKeys("extension");
        driver.findElementByName("contactmoblie").sendKeys("contactmoblie");
        driver.findElementByName("contactemail").sendKeys("contactemail");
        driver.findElementByName("line").sendKeys("Line");
        driver.findElementByName("fax").sendKeys("fax");
        driver.findElementByName("quote").sendKeys("quote");
        driver.findElementByName("product").sendKeys("product");
        driver.findElementByName("cost").sendKeys("3333");
        driver.findElementByName("message").sendKeys("messagemessagemessage");





        driver.findElementById("saveMarket").click();


    }
}
