package com.jetec.CRM;

import com.github.benmanes.caffeine.cache.Cache;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import com.jetec.CRM.repository.TrackRepository;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultHandler;
import org.springframework.util.StreamUtils;

import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
    @Autowired
    TrackRepository tr;



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

        List<MarketBean> marketlist = mr.findByNameLikeIgnoreCaseOrMessageLikeIgnoreCaseOrProductLikeIgnoreCaseOrQuoteLikeIgnoreCase("%00J%","%00J%","%00J%","%00J%");
        Set<String> result = new HashSet<>();
        if (marketlist != null) {
            for (MarketBean marketBean : marketlist) {
                result.add(marketBean.getCustomerid());
            }
        }

        List<PotentialCustomerBean> CustomerList = PCR.findByRemarkLikeIgnoreCase("%00J%");
        for (PotentialCustomerBean bean : CustomerList) {
            result.add(bean.getCustomerid());
        }



        List<TrackBean> trackList = tr.findByTrackdescribeLikeIgnoreCaseOrResultLikeIgnoreCase("%00J%","%00J%");
        for (TrackBean trackBean : trackList) {
            result.add(trackBean.getCustomerid());
//            System.out.println(trackBean.getResult());
//            System.out.println(trackBean.getTrackdescribe());
//            System.out.println("======================");
        }


        for (String s : result) {
            System.out.println(s);
        }
        System.out.println("追蹤 :"+ trackList.size());
        System.out.println("顧客 : " +CustomerList.size());
        System.out.println("銷售機會  :"+  marketlist.size());
        System.out.println(result.size());
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
