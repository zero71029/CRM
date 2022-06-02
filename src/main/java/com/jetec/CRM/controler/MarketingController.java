package com.jetec.CRM.controler;

import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.MarketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/Marketing")
public class MarketingController {
    @Autowired
    ClientRepository cr;
    @Autowired
    MarketRepository mr;

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
    @RequestMapping("/search")
    @ResponseBody
    public String search(@RequestBody Map<String, Object> body) {
        System.out.println(body);
        LocalDateTime old = LocalDateTime.now();

        List<String> industryList = (List<String>) body.get("industry");
        List<ClientBean> clientList = new ArrayList<>();
        if (industryList != null) {
            System.out.println("industryList");
            industryList.forEach(industry ->
                clientList.addAll(cr.findByIndustry(industry))
            );

        }
        List<String> producttypeList = (List<String>) body.get("producttype");
        if (producttypeList != null) {
            System.out.println("producttypeList");
            List<MarketBean> list = new ArrayList<>();
            producttypeList.forEach(s ->
                list.addAll(mr.findByProducttype(s))
            );

            //去重複
            List<MarketBean> l = list.stream().collect(
                    Collectors.collectingAndThen(
                            Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(MarketBean::getClient))),
                            ArrayList::new));
            l.forEach(m -> {
                        if (cr.existsByName(m.getClient()))  clientList.add(cr.findByName(m.getClient()));
                    }
            );
        }


        //刪除 沒有email
        List<ClientBean> outClient = clientList.stream()
                .filter(clientBean -> clientBean.getEmail() != null)
                .filter(clientBean -> clientBean.getEmail().indexOf("@") > 0)
                .collect(Collectors.toList());



        //去重複
        outClient = outClient .stream().collect(Collectors
                .collectingAndThen(
                        Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(ClientBean::getEmail))),
                        ArrayList::new));






//        clientList.forEach(clientBean -> {
//            if (clientBean.getEmail() != null) {
//                if (clientBean.getEmail().indexOf("@") > 0) outClient.add(clientBean);
//            }
//        });






        //輸出
        try {
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), "UTF-8");
            osw.write(new String(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}));
            BufferedWriter bw = new BufferedWriter(osw);//檔案輸出路徑
            outClient.forEach(clientBean -> {
                try {
                    bw.newLine();//新起一行
                    if (clientBean.getContact().size() > 0) {
                        bw.write(clientBean.getEmail() + "," + clientBean.getName() + "," + clientBean.getContact().get(0).getName() + "," + clientBean.getIndustry());//寫到新檔案中
                    } else {
                        bw.write(clientBean.getEmail() + "," + clientBean.getName() + ",  ," + clientBean.getIndustry());//寫到新檔案中
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
//                System.out.printf("%s,%s,%s" + clientBean.getContact().size(), clientBean.getEmail(), clientBean.getName(), "");
//                System.out.println("");
            });
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Duration duration = Duration.between(old,LocalDateTime.now());
        System.out.println("耗時 : "+duration.toMillis());
        return "file_output.csv";
    }
}
