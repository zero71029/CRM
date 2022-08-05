package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.BusinessTripService;
import com.jetec.CRM.controler.service.TaskService;
import com.jetec.CRM.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/task")
public class TaskController {
    @Autowired
    TaskService TS;
    @Autowired
    BusinessTripService bts;
    @Autowired
    ZeroTools zTools;

    Logger logger = LoggerFactory.getLogger("TaskController");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @RequestMapping("/init/{id}")
    @ResponseBody
    public Map<String, Object> task(@PathVariable("id") String id) {
        System.out.println("每⽇任務初始化");
        Map<String, Object> result = new HashMap<>();
        result.put("bean", TS.getById(id));
        result.put("taskList", TS.getTaskList(id));

        return result;
    }

    @RequestMapping("/detail/{id}")
    public String detail(Model model, @PathVariable("id") String id) {
        System.out.println("每⽇任務");
        model.addAttribute("bean", TS.getById(id));
        return "/Task/Task";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存每⽇任務
    @RequestMapping("/save")
    public String SavePotentialCustomer(EvaluateBean bean, HttpSession session) {
        System.out.println("*****儲存每⽇任務*****");
        System.out.println(bean);

        String ddd = ZeroTools.getTime(new Date());
        if (bean.getEvaluatedate() == null || bean.getEvaluatedate().isEmpty())
            bean.setEvaluatedate(ZeroTools.getTime(new Date()));
        if (bean.getEvaluateid() == null || bean.getEvaluateid().isEmpty()) bean.setEvaluateid(ZeroTools.getUUID());
        if (bean.getName() == null || bean.getName().isEmpty()) {
            AdminBean adminBean = (AdminBean) session.getAttribute("user");
            bean.setName(adminBean.getName());
        } else {
            bean.setName(bean.getName());
        }

        for (EvaluateTaskBean task : bean.getTask()) {
            task.setEvaluateid(bean.getEvaluateid());
            task.setTaskdate(ddd);
        }
        System.out.println("*****************************");
        System.out.println(bean);
        EvaluateBean save = TS.SaveEvaluateBean(bean);

//        EvaluateBean newbean = new EvaluateBean();
//        if (bean.getEvaluateid() == null || bean.getEvaluateid().isEmpty()){
//            newbean.setEvaluateid(zTools.getUUID());
//        }else {
//            bean.setEvaluateid(bean.getEvaluateid();
//        }
//
//        if (bean.getEvaluatedate() == null || bean.getEvaluatedate().isEmpty()){
//            newbean.setEvaluatedate(zTools.getTime(new Date()));
//        }else {
//            newbean.setEvaluatedate(bean.getEvaluatedate());
//        }
//        newbean.setDepartment(bean.getDepartment());
//        if (bean.getName() == null || bean.getName().isEmpty()){
//            AdminBean adminBean = (AdminBean) session.getAttribute("user");
//            newbean.setName(adminBean.getName());
//        }else {
//            newbean.setName(bean.getName());
//        }
//        newbean.setRemark(bean.getRemark());
//        newbean.setAssessment(bean.getAssessment());
//        newbean.setDirector(bean.getDirector());
//        newbean.setHr(bean.getHr());
//        newbean.setCosttime(bean.getCosttime());
//        if (!bean.getTask().isEmpty()){
//            for (EvaluateTaskBean task:bean.getTask()) {
//                if(task.getContent() == null ||task.getContent().isEmpty()){
//
//
//                }
//            }
//        }
//        EvaluateBean save = TS.SaveEvaluateBean(newbean);
        TS.delnull();
        return "redirect:/task/detail/" + save.getEvaluateid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//任務列表
    @ResponseBody
    @RequestMapping("/directorTaskList")
    public Map<String, Object> directorTaskList(@RequestParam("pag") Integer pag) {
        System.out.println("主管任務列表");
        pag--;
        return TS.getList(pag);
    }

    @ResponseBody
    @RequestMapping("/taskList")
    public Map<String, Object> workList(@RequestParam("pag") Integer pag, @RequestParam("name") String name) {
        System.out.println("個人任務列表");
        pag--;
        return TS.getList(pag, name);
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping("/print/{id}")
    public String print(Model model, @PathVariable("id") String id) {
        System.out.println("列印任務");
        model.addAttribute("bean", TS.getById(id));
        return "/Task/print";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除每日任務
    @RequestMapping("/delTask")
    @ResponseBody
    public String delTask(@RequestParam("id") List<String> id) {
        System.out.println("*****刪除每日任務*****");
        TS.delMarket(id);
        return "刪除成功";
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*******************
    @RequestMapping("/sql")
    @ResponseBody
    public String sql() {
        System.out.println("*****資料庫備份*****");
        //////
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        try {
            ProcessBuilder builder = new ProcessBuilder(
                    "cmd.exe", "/c", "cd  C:\\MAMP\\bin\\mysql\\bin && mysqldump -uroot -proot crm > C:\\Users\\jetec\\SynologyDrive\\crm" + sdf.format(new Date()) + ".sql");
            builder.redirectErrorStream(true);
            Process p = builder.start();
            BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line;
            while (true) {
                line = r.readLine();
                if (line == null) {
                    break;
                }
                System.out.println(line);
            }

            return "成功 已經輸出到NAS <br>";
        } catch (IOException e) {
            e.printStackTrace();
            return "輸出失敗,請聯絡管理員";
        }

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索每日任務
    @RequestMapping("/selecttask")
    @ResponseBody
    public List<EvaluateBean> selecttask(@RequestParam("pag") Integer pag, @RequestParam("name") String name) {
        System.out.println("*****搜索每日任務*****");
        pag--;
        return TS.selecttask(name, pag);
    }

    //儲存請假單
    @RequestMapping("/saveLeave")
    @ResponseBody
    public ResultBean saveLeave(LeaveBean leaveBean) {
        System.out.println(leaveBean);
        LocalDate start = LocalDateTime.parse(leaveBean.getStartday()).toLocalDate();
        LocalDate end = LocalDateTime.parse(leaveBean.getEndday()).toLocalDate();
        leaveBean.setUuid(ZeroTools.getUUID());
        LeaveBean newBean = new LeaveBean(leaveBean);
        newBean.setLeaveday(start.toString());
        newBean.setRemark(leaveBean.getStartday() + " ~ " + leaveBean.getEndday());
        TS.saveLeave(newBean);



        start = start.minusDays(-1);
        while (start.isBefore(end)) {
            newBean = new LeaveBean(leaveBean);
            newBean.setLeaveday(start.toString());
            TS.saveLeave(newBean);
            start = start.minusDays(-1);
        }
        start = LocalDateTime.parse(leaveBean.getStartday()).toLocalDate();
        //start  end 一樣表示只有一天
        if (!start.equals(end)) {
            newBean = new LeaveBean(leaveBean);
            newBean.setLeaveday(end.toString());
            TS.saveLeave(newBean);
        }


        logger.info("{} 請假成功", leaveBean.getUser());
        return ZeroFactory.buildResultBean(200, "假單成功", "");
    }

    //請假單列表
    @RequestMapping("/getLeave/{mon}")
    @ResponseBody
    public ResultBean getLeave(@PathVariable("mon") String mon) {
        logger.info("請假單列表");
        List<LeaveBean> list = TS.getLeaveList(mon);
        return ZeroFactory.buildResultBean(200, "請假單列表", list);
    }

    //出差申請
    @RequestMapping("/saveBusinessTrip")
    @ResponseBody
    public ResultBean saveBusinessTrip(BusinessTripBean btBean) {
        logger.info("{} 出差申請",btBean.getSchedule());
        System.out.println(btBean);
        bts.save(btBean);
        return ZeroFactory.buildResultBean(200, "出差申請成功");
    }

    @RequestMapping("/getBusinessTrip")
    @ResponseBody
    public ResultBean getBusinessTrip() {
        System.out.println("讀取出差申請");
        return ZeroFactory.buildResultBean(200, "讀取出差申請",bts.getById(28));
    }





}
