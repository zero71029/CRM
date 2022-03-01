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
public class potentialcustomerList {

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


        //點擊淺在客戶
        driver.findElementByClassName("customerbar").click();
		driver.findElementById("sec").click();
        driver.findElementById("i").click();
        //點一星期
        driver.findElement(By.xpath("/html/body/div[3]/div[1]/div[1]/button[2]")).click();
        Thread.sleep(500);
        WebElement sendDay = driver.findElementById("sendDay");
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

        //詢問內容
        driver.findElementById("Inquiry").click();
        driver.findElementByName("content").sendKeys("流量計");
        driver.findElementById("selectInquiry").click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 詢問內容:流量計  :" + clients.size() + "筆");
        driver.executeScript("vm.content=''");

        //聯絡人
        driver.findElementById("contact").click();
        driver.findElementByName("name").sendKeys("小姐");
        driver.findElementById("selectContact").click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 聯絡人:小姐  :" + clients.size() + "筆");
        driver.executeScript("vm.name=''");

        //公司名稱
        driver.findElementById("company").click();
        driver.findElementByName("name").sendKeys("有限公司");
        driver.findElementById("selectCompany").click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 公司名稱:有限公司  :" + clients.size() + "筆");
        driver.executeScript("vm.name=''");

        //狀態
        driver.findElementById("Status").click();
        driver.executeScript("vm.inStateList=['未處理']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 未處理  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.executeScript("vm.inStateList=['未處理','合格']");
        sendDay.click();
        clients = driver.findElementsByName("mak");
        System.out.println("搜索 未處理,合格  :" + clients.size() + "筆");
        Thread.sleep(500);
        driver.executeScript("vm.inStateList=[]");


        //產業
        driver.findElementById("industry").click();
        driver.executeScript("vm.industry=['尚未分類']");
        driver.findElementById("selectIndustry").click();

        clients = driver.findElementsByName("mak");
        System.out.println("搜索 尚未分類 :" + clients.size() + "筆");
        Thread.sleep(200);
        driver.executeScript("vm.industry=[]");

    }
}
