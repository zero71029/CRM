package com.jetec.CRM.filter;

import com.jetec.CRM.repository.MarketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

@Configuration
public class config {
    @Autowired
    MarketRepository mr;

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    @Scheduled(cron = "0 0,10,20,30,40,50 * * * *")
    public void testCron() {
        System.out.println("現在時間 :" + dateFormat.format(new Date()));
    }


    @Scheduled(cron = "0 0 22 * * *")
    public void layoutSQL() throws IOException {
        System.out.println("現在時間 :" + dateFormat.format(new Date()));
        System.out.println("自動備份,輸出SQL");
        //////
        SimpleDateFormat  sdf = new SimpleDateFormat("yyyyMMdd-HH-mm");
        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe", "/c", "cd  C:\\MAMP\\bin\\mysql\\bin && mysqldump -uroot -proot crm > C:\\Users\\jetec\\SynologyDrive\\crm" + sdf.format(new Date()) + "自動.sql");
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line;
        while (true) {
            line = r.readLine();
            if (line == null) { break; }
            System.out.println(line);
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
