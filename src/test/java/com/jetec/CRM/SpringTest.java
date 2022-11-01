package com.jetec.CRM;

import com.github.benmanes.caffeine.cache.Cache;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultHandler;
import org.springframework.util.StreamUtils;

import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class SpringTest {

    @Autowired
    PotentialCustomerRepository PCR;
    @Autowired
    Cache<String, Object> caffeineCache;
    @Autowired
    ContactRepository contactRepository;

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    MarketRepository mr;
    @Autowired
    ContactRepository cr;

    Logger logger = LoggerFactory.getLogger("SpringTest");
    @Autowired
    MarketService ms;


    @Test
    public void zeroMail() {

        ZeroTools zTools = new ZeroTools();
        zTools.mail("sales@jetec.com.tw", "網管測試.....", "網管測試", "");

    }


    @Test
    public void XXX() throws Exception {
        List<ContactBean> contactList = cr.findAll();
        contactList.forEach(contactBean -> {
            List<MarketBean> marketlist = mr.findByContactnameAndClientidIsNull(contactBean.getName());
            if (marketlist != null) {
                for (MarketBean marketBean : marketlist) {
                    System.out.println(marketBean.getName());
                    marketBean.setContactid(contactBean.getContactid());
                    mr.save(marketBean);
                }
            }
        });
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

    @Test
    public void jsonromUrl() throws Exception {
        mockMvc.perform(get("https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=json&date=20220809&stockNo=5871")
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
