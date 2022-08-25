package com.jetec.CRM;

import com.github.benmanes.caffeine.cache.Cache;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.repository.ContactRepository;
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

    Logger logger = LoggerFactory.getLogger("SpringTest");
    @Autowired
    MarketService ms;


    @Test
    public void XXX() throws Exception {
        logger.info("轉賣 自動結案");
        ms.AutoCloseCase("轉賣/自用");
        ms.AutoCloseCase("轉賣");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
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
