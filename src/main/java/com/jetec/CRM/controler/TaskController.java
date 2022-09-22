package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.BusinessTripService;
import com.jetec.CRM.controler.service.LeaveService;
import com.jetec.CRM.controler.service.TaskService;
import com.jetec.CRM.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
    LeaveService ls;
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
        logger.info("進入每⽇任務 {}", id);
        EvaluateBean bean = TS.getById(id);
        if (bean == null) {
            model.addAttribute("message", "此id找不到資料");
            return "/error/500";
        }
        model.addAttribute("bean", bean);
        return "/Task/Task";
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //儲存每⽇任務
    @RequestMapping("/save")
    public String SavePotentialCustomer(EvaluateBean bean, HttpSession session) {
        logger.info("儲存每⽇任務");
        logger.info(bean.toString());
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

        logger.info("主管任務列表");
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
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 刪除每日任務 {}", adminBean.getName(), id);
        TS.delMarket(id);
        return "刪除成功";
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//資料庫備份
    @RequestMapping("/sql")
    @ResponseBody
    public String sql() {
        logger.info("資料庫備份");
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
        logger.info("搜索每日任務 {}", name);
        pag--;
        return TS.selecttask(name, pag);
    }

    //儲存請假單
    @RequestMapping("/saveLeave")
    @ResponseBody
    public ResultBean saveLeave(LeaveBean leaveBean) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AdminBean adminBean = (AdminBean) authentication.getPrincipal();
        logger.info("{} 儲存請假單", adminBean.getName());
        System.out.println(leaveBean);
        LocalDate start = LocalDateTime.parse(leaveBean.getStartday()).toLocalDate();
        LocalDate end = LocalDateTime.parse(leaveBean.getEndday()).toLocalDate();
        leaveBean.setUuid(ZeroTools.getUUID());
        LeaveBean newBean = new LeaveBean(leaveBean);
        newBean.setLeaveday(start.toString());
        newBean.setRemark(leaveBean.getStartday() + " ~ " + leaveBean.getEndday());
        ls.saveLeave(newBean);


        start = start.minusDays(-1);
        while (start.isBefore(end)) {
            newBean = new LeaveBean(leaveBean);
            newBean.setLeaveday(start.toString());
            ls.saveLeave(newBean);
            start = start.minusDays(-1);
        }
        start = LocalDateTime.parse(leaveBean.getStartday()).toLocalDate();
        //start  end 一樣表示只有一天
        if (!start.equals(end)) {
            newBean = new LeaveBean(leaveBean);
            newBean.setLeaveday(end.toString());
            ls.saveLeave(newBean);
        }
        logger.info("{} 請假成功", leaveBean.getUser());
        return ZeroFactory.buildResultBean(200, "假單成功", "");
    }

    //請假單列表
    @RequestMapping("/getLeave/{mon}")
    @ResponseBody
    public ResultBean getLeave(@PathVariable("mon") String mon) {
        logger.info("請假單列表");
        return ZeroFactory.buildResultBean(200, "請假單列表", ls.getLeaveList(mon));
    }

    //讀取請假單
    @RequestMapping("/leave/{uuid}")
    @ResponseBody
    public ResultBean leave(@PathVariable("uuid") Integer uuid) {
        logger.info("讀取請假單 {}", uuid);
        return ZeroFactory.buildResultBean(200, "讀取請假單", ls.getById(uuid));
    }

    //出差申請
    @RequestMapping("/saveBusinessTrip")
    @ResponseBody
    public ResultBean saveBusinessTrip(BusinessTripBean btBean) {
        logger.info("{} 出差申請", btBean.getSchedule());
        System.out.println(btBean);
        bts.save(btBean);
        return ZeroFactory.buildResultBean(200, "出差申請成功");
    }

    //出差列表
    @RequestMapping("/BusinessTripList/{mon}")
    @ResponseBody
    public ResultBean BusinessTripList(@PathVariable("mon") String mon) {
        logger.info("讀取出差申請列表");
        return ZeroFactory.buildResultBean(200, "讀取出差申請列表", bts.getBusinessTripList(mon));
    }

    //讀取出差資料
    @RequestMapping("/BusinessTrip/{tripid}")
    @ResponseBody
    public ResultBean BusinessTrip(@PathVariable("tripid") Integer tripid) {
        System.out.println("讀取出差資料");
        logger.info("讀取出差資料{}", tripid);
        return ZeroFactory.buildResultBean(200, "讀取出差申請", bts.getBusinessTrip(tripid));
    }


    /**
     * 日歷初始化
     *
     * @return {@link ResultBean}
     */
    @RequestMapping("/calendarInit/{mon}")
    @ResponseBody
    public ResultBean calendarInit(@PathVariable("mon") String mon) {
        logger.info("日歷初始化");
        LocalDate localDate = LocalDate.parse(mon, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        Map<String ,List> result =new HashMap<>(2);
        List<LeaveBean> leave = ls.getLeaveList(localDate.minusMonths(-1).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        leave.addAll(ls.getLeaveList(localDate.format(DateTimeFormatter.ofPattern("yyyy-MM"))));
        leave.addAll(ls.getLeaveList(localDate.minusMonths(+1).format(DateTimeFormatter.ofPattern("yyyy-MM"))));

        List<BusinessTripBean> businessTrip =bts.getBusinessTripList(localDate.minusMonths(-1).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        businessTrip.addAll(bts.getBusinessTripList(localDate.format(DateTimeFormatter.ofPattern("yyyy-MM"))));
        businessTrip.addAll(bts.getBusinessTripList(localDate.minusMonths(+1).format(DateTimeFormatter.ofPattern("yyyy-MM"))));

        result.put("leave",leave);
        result.put("businessTrip",businessTrip);

        return ZeroFactory.buildResultBean(200, "日歷初始化", result);
    }

    /**
     * 添加日历
     *
     * @param theme 主题
     * @param day   一天
     * @param desc  desc
     * @return {@link ResultBean}
     */
    @RequestMapping("/addCalender")
    @ResponseBody
    public ResultBean addCalender(@RequestParam("theme") String theme,@RequestParam("day") String day,@RequestParam("desc") String desc) {
        logger.info("添加日历");
        System.out.println(theme);
        System.out.println(day);
        System.out.println(desc);
        return ZeroFactory.success( "添加成功");
    }

}
