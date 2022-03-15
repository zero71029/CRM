package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;


@SpringBootTest
public class SelectPotentialCustomer {

    @Test
    void contextLoads() throws InterruptedException {
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //配置
        System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
        ChromeDriver driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);
        driver.get("http://localhost:8080/CRM/");
//        driver.get("http://192.168.11.100:8080/CRM");
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

        driver.findElementByXPath("//*[@id=\"offcanvasRight\"]/div[1]/button").click();
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
//        System.out.println("customerid " +customerid);
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
//        driver.findElementByName("source").sendKeys("玟嫣");
//        driver.findElementByName("address").sendKeys("玟嫣");
//        driver.findElementByName("serialnumber").sendKeys("3326");
//        new Select(driver.findElementByName("city")).selectByValue("桃園市");
//        new Select(driver.findElementByName("user")).selectByValue("玟嫣");
//        new Select(driver.findElementByName("status")).selectByValue("已聯繫");
//        new Select(driver.findElementByName("important")).selectByValue("高");
//        new Select(driver.findElementByName("industry")).selectByIndex(3);
//        new Select(driver.findElementByName("source")).selectByIndex(3);
//
//        driver.findElementById("saveButton").click();
//        Thread.sleep(500);
//        //獲取navigation 刷新頁面
//        WebDriver.Navigation n2 = driver.navigate();
////        n2.refresh();
//        driver.switchTo().window(p1);
//        navigation.refresh();
//
//        driver.findElementById(customerid).click();
//
//        driver.findElementByXPath("/html/body/div[1]/div/div[2]/div[2]/div/label[2]").click();
//        Alert a = driver.switchTo().alert();
//        a.accept();

    }
}
