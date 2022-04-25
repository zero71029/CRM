package com.jetec.CRM.filter;

import com.jetec.CRM.repository.MarketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import java.text.SimpleDateFormat;
import java.util.Date;

@Configuration
public class config {
    @Autowired
    MarketRepository mr;

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    //    @Scheduled(fixedDelay = 60000) // fixedDelay = 60000 表示當前方法執行完畢 60000ms(1分鐘) 後，Spring scheduling會再次呼叫該方法
//    public void testFixDelay() {
//        System.out.println("間格時間 :" + dateFormat.format(new Date()));
//    }
    @Scheduled(cron = "0 * * * * *") // fixedDelay = 60000 表示當前方法執行完畢 60000ms(1分鐘) 後，Spring scheduling會再次呼叫該方法
    public void testCron() {
        System.out.println("現在時間 :" + dateFormat.format(new Date()));
//        mr.layout();
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
