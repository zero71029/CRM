package com.jetec.CRM.controler;

import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.time.Duration;
import java.time.LocalDate;
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
    @Autowired
    ContactRepository contactRepository;
    @Autowired
    JdbcTemplate jdbcTemplate;


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
                        if (cr.existsByName(m.getClient())) clientList.add(cr.findByName(m.getClient()));
                    }
            );
        }


        //刪除 沒有email
        List<ClientBean> outClient = clientList.stream()
                .filter(clientBean -> clientBean.getEmail() != null)
                .filter(clientBean -> clientBean.getEmail().indexOf("@") > 0)
                .collect(Collectors.toList());


        //去重複
        outClient = outClient.stream().collect(Collectors
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
//            osw.write(new String(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}));
            osw.write('\ufeff');
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
        Duration duration = Duration.between(old, LocalDateTime.now());
        System.out.println("耗時 : " + duration.toMillis());
        return "file_output.csv";
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //jdbcTemplate實驗
    @RequestMapping("/search2")
    @ResponseBody
    public String search2(@RequestBody Map<String, Object> body) {
        System.out.println(body);
        System.out.println();
        LocalDateTime old = LocalDateTime.now();
        List<ClientBean> clientList = new ArrayList<>();
        String start = (String) body.get("start");
        if(start.equals(""))start = "2022-02-02";
        String end = (String) body.get("end");
        if(end.equals(""))end= LocalDate.now().toString();

        StringBuffer sql = new StringBuffer("select distinct client from market where aaa between "+start+" and "+end);
        List<String> producttypeList = (List<String>) body.get("producttype");
        if (producttypeList != null && producttypeList.size() > 0) {
            sql.append("( ");
            for (int i = 0; i < producttypeList.size(); i++) {
                sql.append("producttype = '" + producttypeList.get(i) + "'");
                if (i < producttypeList.size() - 1) {
                    sql.append(" or ");
                }
            }
            sql.append(") ");
        }

        List<String> SourceList = (List<String>) body.get("Source");
        System.out.println(SourceList);
        if (SourceList.size() > 0) {
            if (producttypeList.size() > 0) sql.append("and");
            sql.append("( ");
            for (int i = 0; i < SourceList.size(); i++) {
                sql.append("source = '" + SourceList.get(i) + "'");
                if (i < SourceList.size() - 1) {
                    sql.append(" or ");
                }
            }
            sql.append(") ");
        }


        System.out.println("======================================================");
        System.out.println(sql);
        System.out.println("=====================================================");
        List<Map<String, Object>> ClientName = new ArrayList<>();
        if (producttypeList.size() == 0 && SourceList.size() == 0) {

        } else {
            ClientName = jdbcTemplate.queryForList(sql.toString());
        }
        System.out.println("抓到  " + ClientName.size() + "筆資料");

        List<String> industryList = (List<String>) body.get("industry");
        if (ClientName.size() > 0) {
            ClientName.forEach(e -> {
                clientList.add(cr.findByName((String) e.get("client")));
            });
        } else {
            if (producttypeList.size() == 0) {
                industryList.forEach(s -> {
                    clientList.addAll(cr.findByIndustry(s));
                });
            }
        }


        List<ClientBean> out = new ArrayList<>();
        //過濾產業
        if (industryList != null && industryList.size() > 0) {
            industryList.forEach(s -> {
                clientList.forEach(clientBean -> {
                    if (clientBean != null && clientBean.getIndustry() != null && clientBean.getIndustry().equals(s)) out.add(clientBean);
                });
            });
        }

        //刪除 沒有email
        List<ClientBean> result = new ArrayList<>();
        out.stream().forEach(clientBean -> {
            if (clientBean != null && clientBean.getEmail().indexOf("@") > 0) result.add(clientBean);
        });
        List<ClientBean> outClient;
        //去重複
        outClient = result.stream().collect(Collectors
                .collectingAndThen(
                        Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(ClientBean::getEmail))),
                        ArrayList::new));
        System.out.println("輸出  " + outClient.size() + "筆資料");

        //輸出
        try {
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), "UTF-8");
//            osw.write(new String(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}));
            osw.write('\ufeff');
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

            });
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Duration duration = Duration.between(old, LocalDateTime.now());
        System.out.println("耗時 : " + duration.toMillis());
        return "file_output.csv";
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    @RequestMapping("/search3")
    @ResponseBody
    public String search3(@RequestBody Map<String, Object> body) {
        System.out.println(body);
        System.out.println();
        String start = (String) body.get("start");
        if(start.equals(""))start = "2022-02-02";
        String end = (String) body.get("end");
        if(end.equals(""))end= LocalDate.now().toString();
        LocalDateTime old = LocalDateTime.now();

        List<String> industryList = (List<String>) body.get("industry");
        List<ClientBean> outClient = new ArrayList<>();
        if(industryList.size() > 0){
            String finalStart = start;
            String finalEnd = end;
            industryList.forEach(e -> {
                outClient.addAll(cr.findByIndustryAndAaaBetween(e , finalStart, finalEnd));
            });




        }
        //輸出
        try {
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), "UTF-8");
//            osw.write(new String(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}));
            osw.write('\ufeff');
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

            });
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("輸出  " + outClient.size() + "筆資料");
        Duration duration = Duration.between(old, LocalDateTime.now());
        System.out.println("耗時 : " + duration.toMillis());
        return "file_output.csv";
    }
















}
