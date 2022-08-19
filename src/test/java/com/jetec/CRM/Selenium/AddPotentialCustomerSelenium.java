package com.jetec.CRM.Selenium;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class AddPotentialCustomerSelenium {
    @Test
//淺在客戶 新增測試
    void contextLoads() throws InterruptedException {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //配置
        System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
        ChromeDriver driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);
        driver.get("http://localhost:8081/CRM/");
        WebDriver.Options op = driver.manage();
        op.window().maximize();//全屏

        //登入
//        driver.findElementByLinkText("登入").click();
//        driver.findElementById("username").sendKeys("jeter.tony56@gmail.com");
//        driver.findElementById("password").sendKeys("tp6u04xup6");
//        driver.findElement(By.xpath("/html/body/div/form/button")).click();
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//        //點擊營銷模塊
//        driver.findElement(By.xpath("/html/body/div[1]/div/div[1]/ul/button[1]")).click();
//        //點擊淺在客戶
//        driver.findElementByClassName("customerbar").click();
//        //點新增
//        driver.findElementByXPath(" /html/body/div[1]/div/div[2]/div[2]/div/label[1]").click();
//        //彈窗
//        Set wh = driver.getWindowHandles();
//        Iterator<String> it = wh.iterator();
//        String p1 = it.next();
//        String p2 = it.next();
//        driver.switchTo().window(p2);
//        driver.findElementByName("company").sendKeys("玟嫣");
//        driver.findElementByName("name").sendKeys("玟嫣");
//        driver.findElementByName("phone").sendKeys("玟嫣");
//        driver.findElementByName("moblie").sendKeys("玟嫣");
//        driver.findElementByName("email").sendKeys("玟嫣");
//        driver.findElementByName("remark").sendKeys("玟嫣");
//        driver.findElementById("saveButton").click();
//        String customerid = driver.findElementByName("customerid").getAttribute("value");
//        System.out.println("customerid " + customerid);
//        driver.switchTo().window(p1);
//        //獲取navigation
//        WebDriver.Navigation navigation = driver.navigate();
//        //刷新頁面
//        navigation.refresh();
//        System.out.println(driver.findElementById(customerid).toString());
//        driver.switchTo().window(p2);
//        driver.findElementByName("line").sendKeys("玟嫣");
//        driver.findElementByName("fax").sendKeys("玟嫣");
//        driver.findElementByName("jobtitle").sendKeys("玟嫣");
//        driver.findElementByName("companynum").sendKeys("玟嫣");
//        driver.findElementByName("department").sendKeys("玟嫣");
//        driver.findElementByName("director").sendKeys("玟嫣");
//        driver.findElementByName("director").sendKeys("玟嫣");
//        driver.findElementByName("industry").sendKeys("玟嫣");
//        driver.findElementByName("extension").sendKeys("extension");
//        driver.findElementByName("address").sendKeys("玟嫣");
//        driver.findElementByName("serialnumber").sendKeys("3326");
//        new Select(driver.findElementByName("city")).selectByValue("桃園市");
//        new Select(driver.findElementByName("user")).selectByValue("玟嫣");
//        new Select(driver.findElementByName("status")).selectByValue("已聯繫");
//        new Select(driver.findElementByName("important")).selectByValue("高");
//        new Select(driver.findElementByName("industry")).selectByIndex(3);
//        new Select(driver.findElementByName("source")).selectByIndex(3);
//        new Select(driver.findElementByName("contacttitle")).selectByIndex(1);
//
//        driver.findElementById("saveButton").click();
//        Thread.sleep(500);
//        driver.findElementById("act").click();
//        Thread.sleep(500);
//        driver.findElementByXPath("//*[@id=\"draggable\"]/div[2]/a[1]").click();
//        Thread.sleep(500);
//        driver.findElementByXPath("//*[@id=\"draggable\"]/div[2]/a[2]").click();
//        Thread.sleep(500);
//        driver.findElementByXPath("//*[@id=\"draggable\"]/div[3]/div[4]").click();
//        Thread.sleep(5000);
//        //獲取navigation 刷新頁面
//        WebDriver.Navigation n2 = driver.navigate();
////        n2.refresh();
//        driver.switchTo().window(p1);
//        navigation.refresh();
//        Thread.sleep(500);
//        //點擊新增項目
//        driver.findElementByXPath("/html/body/div[1]/div/div[2]/span/table/tbody/tr[2]/td[6]").click();
//        //勾選
//        driver.findElementById(customerid).click();
//        //刪除
//        driver.findElementByXPath("/html/body/div[1]/div/div[2]/div[2]/div/label[2]").click();
//        Alert a = driver.switchTo().alert();
//        a.accept();


    }
}
