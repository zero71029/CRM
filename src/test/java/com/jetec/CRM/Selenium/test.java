package com.jetec.CRM.Selenium;



import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class test {


    @Test
    void contextLoads() throws InterruptedException {

        //配置
//        System.setProperty("webdriver.chrome.driver", "src\\main\\resources\\chromedriver.exe");
//        ChromeDriver driver = new ChromeDriver();
//        driver.manage().timeouts().implicitlyWait(3, TimeUnit.SECONDS);
//        driver.get("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=json&date=20220801&stockNo=5871");




//        System.out.println(driver.findElementByTagName("pre").getText());
        JSONObject object =  JSONObject.parseObject("{\"stat\":\"OK\",\"date\":\"20220801\",\"title\":\"111年08月 5871 中租-KY          各日成交資訊\",\"fields\":[\"日期\",\"成交股數\",\"成交金額\",\"開盤價\",\"最高價\",\"最低價\",\"收盤價\",\"漲跌價差\",\"成交筆數\"],\"data\":[[\"111/08/01\",\"2,997,244\",\"634,964,302\",\"212.50\",\"213.00\",\"208.00\",\"213.00\",\"+1.50\",\"2,498\"],[\"111/08/02\",\"4,940,870\",\"1,049,755,129\",\"210.50\",\"214.00\",\"210.00\",\"213.00\",\" 0.00\",\"3,234\"],[\"111/08/03\",\"6,042,491\",\"1,236,935,502\",\"211.00\",\"211.00\",\"203.00\",\"203.50\",\"-9.50\",\"5,881\"],[\"111/08/04\",\"3,840,382\",\"787,096,613\",\"204.50\",\"207.00\",\"203.00\",\"204.50\",\"+1.00\",\"2,752\"],[\"111/08/05\",\"3,898,728\",\"832,445,925\",\"208.00\",\"216.00\",\"207.50\",\"216.00\",\"+11.50\",\"3,643\"],[\"111/08/08\",\"2,994,010\",\"651,241,099\",\"215.00\",\"219.00\",\"214.00\",\"219.00\",\"+3.00\",\"3,106\"],[\"111/08/09\",\"2,967,230\",\"652,913,992\",\"219.50\",\"222.00\",\"217.50\",\"220.00\",\"+1.00\",\"3,301\"],[\"111/08/10\",\"2,628,290\",\"578,812,922\",\"219.50\",\"221.50\",\"218.00\",\"221.00\",\"+1.00\",\"9,082\"],[\"111/08/11\",\"5,932,671\",\"1,302,989,073\",\"224.50\",\"225.50\",\"217.50\",\"218.50\",\"-2.50\",\"12,551\"],[\"111/08/12\",\"2,620,000\",\"582,839,000\",\"220.50\",\"224.50\",\"218.50\",\"223.50\",\"+5.00\",\"1,660\"]],\"notes\":[\"符號說明:+/-/X表示漲/跌/不比價\",\"當日統計資訊僅含一般交易，不含零股、盤後定價、鉅額、拍賣、標購。\",\"ETF證券代號第六碼為K、M、S、C者，表示該ETF以外幣交易。\"]}");

        List integers = JSON.parseArray(object.getJSONArray("data").toString());
        integers.forEach(System.out::println);





    }
}
