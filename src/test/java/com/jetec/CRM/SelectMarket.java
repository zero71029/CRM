package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
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
        driver.get("http://localhost:8081/CRM/");
//        driver.get("http://192.168.11.100:8080/CRM");
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
        WebElement sendDay =  driver.findElementById("sendDay");
        sendDay.click();
        List clients = driver.findElementsByName("mak");
        System.out.println("搜索 一星期  :" + clients.size() + "筆");

        //負責人
        driver.findElementById("principal").click();
        driver.executeScript("vm.inUserList=['玟嫣']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 玟嫣  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.executeScript("vm.inUserList=['玟嫣','謝姍妤']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 玟嫣,謝姍妤  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.executeScript("vm.inUserList=['玟嫣','謝姍妤','江緯哲']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 玟嫣,謝姍妤,江緯哲  :" + clients.size() + "筆");
        driver.executeScript("vm.inUserList=[]");

        //名稱
        driver.findElementById("search3").click();
        driver.findElementByName("name").sendKeys("流量計");
        driver.findElementById("clickname").click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 機會名稱:流量計  :" + clients.size() + "筆");
        driver.executeScript("vm.name=''");

        //公司
        driver.findElementById("search4").click();
        driver.findElementByName("name").sendKeys("有限公司");
        driver.findElementById("clickname").click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 客戶:有限公司  :" + clients.size() + "筆");
        driver.executeScript("vm.name=''");

        //狀態
        driver.findElementById("search5").click();
        driver.executeScript("vm.inStateList=['尚未處理']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 尚未處理  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.executeScript("vm.inStateList=['尚未處理','已報價']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 尚未處理,已報價  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.executeScript("vm.inStateList=[]");

        //聯絡人
        driver.findElementById("search6").click();
        driver.findElementById("Contact").sendKeys("先生");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 聯絡人,先生  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.findElementById("Contact").sendKeys("");




    }

}
