package com.jetec.CRM;

import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.TimeUnit;

@SpringBootTest
class CrmAllTests {

	@Test
	void contextLoads() {
///////////////////////////////////////////////////////////////////////////////////////////////////
		//配置
		System.setProperty("webdriver.chrome.driver","src\\main\\resources\\chromedriver.exe");
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
//銷售機會 搜索測試
		//點銷售機會
		driver.findElement(By.xpath("/html/body/div[1]/div/div[1]/ul/button[1]")).click();
		driver.findElementByClassName("marketbar").click();
//		driver.findElement(By.xpath("/html/body/div[1]/div/div[1]/ul/button[3]")).click();
		//點搜索
		driver.findElement(By.xpath("/html/body/div[1]/div/div[2]/div[1]/div/label[4]")).click();
		//點日期框
		driver.findElement(By.xpath("//*[@id=\"accordionFlushExample\"]/div[1]/div/input[1]")).click();
		//點一星期
		driver.findElement(By.xpath("/html/body/div[3]/div[1]/div[1]/button[2]")).click();
		//點送出
		driver.findElement(By.xpath("//*[@id=\"accordionFlushExample\"]/div[1]/input")).click();
///////////////////////////////////////////////////////////////////////////////////////////////////
//淺在客戶 搜索測試
		//點擊淺在客戶

		driver.findElement(By.xpath("//*[@id=\"flush-headingOne\"]/button")).click();//點重置
		driver.findElementByClassName("customerbar").click();//點淺在客戶
//		driver.findElementById("sec").click();//點搜索
		driver.findElementById("i").click();//點日期
		//點一星期
		driver.findElement(By.xpath("/html/body/div[3]/div[1]/div[1]/button[2]")).click();
		driver.findElementById("sendDay").click();




	}

}
