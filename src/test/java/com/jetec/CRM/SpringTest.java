package com.jetec.CRM;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultHandler;
import org.springframework.util.StreamUtils;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class SpringTest {

    @Autowired
    PotentialCustomerRepository PCR;
    @Autowired
    // 注入StringRedisTemplate類別，用來操作Redis
    StringRedisTemplate stringRedisTemplate;

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void XXX() throws Exception {
        PotentialCustomerBean pcBean = PCR.findById("1ed17789e2736f339b549d2d94501f6d").orElse(null);
        ObjectMapper objectMapper = new ObjectMapper();
        String  j = objectMapper.writeValueAsString(pcBean);
        System.out.println(j);
        System.out.println("============");
        stringRedisTemplate.opsForValue().set("customer:id:"+pcBean.getCustomerid(),j,4, TimeUnit.HOURS);
        String jsonString = stringRedisTemplate.opsForValue().get("customer:id:"+pcBean.getCustomerid());
        System.out.println(jsonString);
        System.out.println("============");
        PotentialCustomerBean bean = objectMapper.readValue(jsonString,PotentialCustomerBean.class);
        System.out.println(bean);

        //清空redis
        //获取所有key
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


    }

    @Test
    public void downLoadFromUrl() throws Exception {

        // https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=csv&date=20220809&stockNo=5871


        mockMvc.perform(get("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=csv&date=20220809&stockNo=5871")
                        .contentType(MediaType.APPLICATION_FORM_URLENCODED))
                .andExpect(status().isOk())
                .andDo(new ResultHandler() {
                    @Override
                    public void handle(MvcResult mvcResult) throws Exception {
                        //保存为文件
                        File file = new File("c:/e2.csv");
                        file.delete();
                        FileOutputStream fout = new FileOutputStream(file);
                        ByteArrayInputStream bin = new ByteArrayInputStream(mvcResult.getResponse().getContentAsByteArray());
                        StreamUtils.copy(bin, fout);
                        fout.close();
                        System.out.println("is exist:" + file.exists());
                        //assert
                        System.out.println("file length:" + file.length());

                    }
                });
    }
}
