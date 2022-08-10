package com.jetec.CRM.filter;

import com.jetec.CRM.controler.service.MarketService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

@Configuration
public class config {
    @Autowired
    MarketService ms;
    @Autowired
    // 注入StringRedisTemplate類別，用來操作Redis
    StringRedisTemplate stringRedisTemplate;

    Logger logger = LoggerFactory.getLogger("時間");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    @Scheduled(cron = "0 0,10,20,30,40,50 * * * *")
    public void testCron() {
        System.out.println("現在時間 :" + dateFormat.format(new Date()));
    }


    @Scheduled(cron = "0 0 22 * * *")
    public void layoutSQL() throws IOException {
        //轉賣 自動結案
        logger.info("轉賣 自動結案");
        ms.AutoCloseCase("轉賣/自用");
        ms.AutoCloseCase("轉賣");

        System.out.println("現在時間 :" + dateFormat.format(new Date()));

        //////自動備份
        logger.info("自動備份,輸出SQL");
        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe", "/c", "cd  C:\\MAMP\\bin\\mysql\\bin && mysqldump -uroot -proot crm > C:\\Users\\jetec\\SynologyDrive\\crm" + LocalDate.now() + "自動.sql");
        //列印執行結果
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line;
        while (true) {
            line = r.readLine();
            if (line == null) { break; }
            logger.info(line);
        }


        //清空redis
        //获取所有key
        try {
            Set<String> keys = stringRedisTemplate.keys("*");
            assert keys != null;
            // 迭代
            Iterator<String> it1 = keys.iterator();
            while (it1.hasNext()) {
                String key =it1.next();
                System.out.println(key);
                // 循环删除
                stringRedisTemplate.delete(key);
            }

        }catch (Exception e){
            logger.error("redis 錯誤");
        }


    }



//    @Bean
//    public FilterRegistrationBean<UserFilter> filterRegistrationBean(){
//        FilterRegistrationBean<UserFilter> registrationBean = new FilterRegistrationBean<UserFilter>(new UserFilter());
//        //过滤路径
//        registrationBean.addUrlPatterns("/CRM/*");
//        //添加不过滤路径
//        registrationBean.addInitParameter("noFilter","/,/two");
//        registrationBean.setName("UserFilter");
//        registrationBean.setOrder(1);
//        return registrationBean;
//    }
//    @Bean
//    public FilterRegistrationBean<SystemFilter> filterSystemnBean(){
//        FilterRegistrationBean<SystemFilter> registrationBean = new FilterRegistrationBean<SystemFilter>(new SystemFilter());
//        //过滤路径
//        registrationBean.addUrlPatterns("/system/*");
//        //添加不过滤路径
//        registrationBean.addInitParameter("noFilter","/,/two");
//        registrationBean.setName("SystemFilter");
//        registrationBean.setOrder(1);
//        return registrationBean;
//    }


}
