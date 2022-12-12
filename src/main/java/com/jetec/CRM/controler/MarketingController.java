package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.MailTool;
import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.controler.service.UpfileService;
import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/Marketing")
public class MarketingController {

    Logger logger = LoggerFactory.getLogger(MarketingController.class);
    @Autowired
    ClientRepository cr;
    @Autowired
    MarketRepository mr;
    @Autowired
    ContactRepository contactRepository;
    @Autowired
    PotentialCustomerRepository pcr;
    @Autowired
    UpfileService US;
    @Autowired
    MailTool mailTool;
    @Autowired
    JdbcTemplate jdbcTemplate;


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    @RequestMapping("/search")
    @Deprecated
    @ResponseBody
    public String search(@RequestBody Map<String, Object> body) {
        System.out.println(body);
        logger.info("行銷 搜索1");
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
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), StandardCharsets.UTF_8);
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
        logger.info("行銷 搜索 改用jdbcTemplate");
        System.out.println(body);

        LocalDateTime old = LocalDateTime.now();
        List<ClientBean> clientList = new ArrayList<>();
        String start = (String) body.get("start");
        if (start.equals("")) start = "2022-02-02";
        String end = (String) body.get("end");
        if (end.equals("")) end = LocalDate.now().toString();

        StringBuffer sql = new StringBuffer("select distinct client from market where aaa between " + start + " and " + end);
        List<String> producttypeList = (List<String>) body.get("producttype");
        if (producttypeList != null && producttypeList.size() > 0) {
            sql.append("( ");
            for (int i = 0; i < producttypeList.size(); i++) {
                sql.append("producttype = '").append(producttypeList.get(i)).append("'");
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
                sql.append("source = '").append(SourceList.get(i)).append("'");
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
            ClientName.forEach(e -> clientList.add(cr.findByName((String) e.get("client"))));
        } else {
            if (producttypeList.size() == 0) {
                industryList.forEach(s -> clientList.addAll(cr.findByIndustry(s)));
            }
        }


        List<ClientBean> out = new ArrayList<>();
        //過濾產業
        if (industryList != null && industryList.size() > 0) {
            industryList.forEach(s -> {
                clientList.forEach(clientBean -> {
                    if (clientBean != null && clientBean.getIndustry() != null && clientBean.getIndustry().equals(s))
                        out.add(clientBean);
                });
            });
        }

        //刪除 沒有email
        List<ClientBean> result = new ArrayList<>();
        out.forEach(clientBean -> {
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
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), StandardCharsets.UTF_8);
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
        logger.info("行銷 搜索");
        System.out.println(body);
        System.out.println();
        String start = (String) body.get("start");
        if (start.equals("")) start = "2022-02-02";
        String end = (String) body.get("end");
        if (end.equals("")) end = LocalDate.now().toString();
        LocalDateTime old = LocalDateTime.now();

        List<String> industryList = (List<String>) body.get("industry");
        List<ClientBean> outClient = new ArrayList<>();
        if (industryList.size() > 0) {
            String finalStart = start;
            String finalEnd = end;
            industryList.forEach(e -> {
                if (Objects.equals("尚未分類", e)) {
                    outClient.addAll(cr.findByIndustryIsNull());
                }
                outClient.addAll(cr.findByIndustryAndAaaBetween(e.trim(), finalStart, finalEnd,Sort.by(Sort.Direction.DESC, "aaa")));
            });
        }

        //輸出
        try {
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), StandardCharsets.UTF_8);
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


    @RequestMapping("/SearchMarket")
    @ResponseBody
    public String SearchMarket(@RequestBody Map<String, Object> body) {
        logger.info("銷售機會輸出");
        logger.info(body.toString());
        String start = (String) body.get("start");
        if (start.equals("")) start = "2022-02-02";
        String end = (String) body.get("end");

        if (end.equals("")) end = LocalDate.now().toString();
        LocalDateTime old = LocalDateTime.now();

        List<String> industryList = (List<String>) body.get("industry");
        List<MarketBean> outClient = new ArrayList<>();
        start = start + " 00:00";
        end = end + " 24:00";
        if (industryList.size() > 0) {
            String finalStart = start;
            String finalEnd = end;
            industryList.forEach(e -> {
                if (Objects.equals("尚未分類", e)) {
                    outClient.addAll(mr.findByTypeIsNull());
                }
                outClient.addAll(mr.findByTypeAndAaaBetween(e.trim(), finalStart, finalEnd, Sort.by(Sort.Direction.DESC, "aaa")));
            });
        }

        //輸出
        try {
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), StandardCharsets.UTF_8);
//            osw.write(new String(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}));
            osw.write('\ufeff');
            BufferedWriter bw = new BufferedWriter(osw);//檔案輸出路徑
            outClient.forEach(clientBean -> {
                try {
                    bw.newLine();//新起一行
                    bw.write(clientBean.getContactemail() + "," + clientBean.getClient() + "," + clientBean.getContactname() + "," + clientBean.getType());//寫到新檔案中

                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


        Duration duration = Duration.between(old, LocalDateTime.now());
        logger.info("輸出 {} 筆資料", outClient.size());
        logger.info("耗時 : {}", duration.toMillis());
        return "file_output.csv";
    }

    /**
     * 寄預覽信
     *
     * @param testMail 郵寄地址
     * @param content  内容
     * @param subject  主题
     * @return boolean
     */
    @RequestMapping("/testMail")
    @ResponseBody
    public ResultBean testMail(@RequestParam("testMail") String testMail, @RequestParam("content") String content, @RequestParam("Subject") String subject) {
        logger.info("寄預覽信 {}", subject);
        if (testMail.isEmpty()) {
            return ZeroFactory.fail("郵寄地址為空");
        }
        if (content.isEmpty()) {
            return ZeroFactory.fail("内容為空");
        }
        if (subject.isEmpty()) {
            return ZeroFactory.fail("主题為空");
        }
        try {
            String result = content.replace("@company", "久德電子").replace("@contact", "行銷人員");
            String resultSubject = subject.replace("@company", "久德電子").replace("@contact", "行銷人員");
            mailTool.sendSimpleMail(testMail, resultSubject, result);
        } catch (Exception e) {
            return ZeroFactory.fail("寄信失敗");
        }
        return ZeroFactory.success("信件已寄出");
    }


    /**
     * 发送行銷邮件
     *
     * @param fileName 文件名称
     * @param content  内容
     * @param Subject  主题
     * @return {@link List}<{@link String}>
     */
    @RequestMapping("/sendMail")
    @ResponseBody
    public List<String> sendMail(@RequestParam("fileName") String fileName, @RequestParam("content") String content, @RequestParam("Subject") String Subject) {
        //讀取檔案
        logger.info("發送行銷邮件");
        Integer i = US.getZeroMailnum();
        List<String> suCompany = new ArrayList<>();
        BufferedReader reader;
        try {
            reader = new BufferedReader(new InputStreamReader(new FileInputStream("C:/CRMfile/" + fileName), "UTF-8"));
            String line;
            System.out.println("=================================================================");
            while ((line = reader.readLine()) != null) {
                String item[] = line.split(",");
                /** 讀取 **/
                String email = item[0].trim();
                String company;
                String contact;
                try {
                    company = item[1].trim();
                } catch (Exception e) {
                    company = "";
                }

                try {
                    contact = item[2].trim();
                } catch (Exception e) {
                    contact = "";
                }
                try {
                    System.out.print(email + "\t" + company + "\t" + contact + "\n");
                    String result = content.replace("@company", company).replace("@contact", contact);
                    String resultSubject = Subject.replace("@company", company).replace("@contact", contact);
//                    resultSubject = resultSubject.replace("@contact", contact);
                    i++;
                    if (email.indexOf("@") > 0) {
                        //寄信去
                        mailTool.sendSimpleMail(email, resultSubject, result);
                        Thread.sleep(100);
                        suCompany.add(company);//成功的公司
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        US.saveZeroMailnum(i);


        return suCompany;
    }


    @RequestMapping("/SearchCustomerOut")
    @ResponseBody
    public String SearchCustomerOut(@RequestBody Map<String, Object> body) {
        logger.info("淺在顧客輸出");
        logger.info(body.toString());
        String start = (String) body.get("start");
        if (start.equals("")){
            start = "2022-02-02";
        }
        String end = (String) body.get("end");

        if (end.equals("")){
            end = LocalDate.now().toString();
        }
        LocalDateTime old = LocalDateTime.now();

        List<String> industryList = (List<String>) body.get("industry");
        List<PotentialCustomerBean> outClient = new ArrayList<>();
        start = start + " 00:00";
        end = end + " 24:00";
        if (industryList.size() > 0) {
            String finalStart = start;
            String finalEnd = end;
            industryList.forEach(e -> {
                if (Objects.equals("尚未分類", e)) {
                    outClient.addAll(pcr.findByIndustryIsNullAndAaaBetween(finalStart, finalEnd, Sort.by(Sort.Direction.DESC, "aaa")));
                }
                outClient.addAll(pcr.findByIndustryAndAaaBetween(e.trim(), finalStart, finalEnd, Sort.by(Sort.Direction.DESC, "aaa")));
            });
        }

        //輸出
        try {
            OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("c://CRMfile//file_output.csv"), StandardCharsets.UTF_8);
//            osw.write(new String(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}));
            osw.write('\ufeff');
            BufferedWriter bw = new BufferedWriter(osw);//檔案輸出路徑
            outClient.forEach(clientBean -> {
                try {
                    bw.newLine();//新起一行
                    bw.write(clientBean.getEmail() + "," + clientBean.getCompany() + "," + clientBean.getName() + "," + clientBean.getIndustry());//寫到新檔案中

                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


        Duration duration = Duration.between(old, LocalDateTime.now());
        logger.info("輸出 {} 筆資料", outClient.size());
        logger.info("耗時 : {}", duration.toMillis());
        return "file_output.csv";
    }

}
