package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.BusinessTripService;
import com.jetec.CRM.controler.service.CalenderService;
import com.jetec.CRM.controler.service.LeaveService;
import com.jetec.CRM.controler.service.TaskService;
import com.jetec.CRM.model.*;
import com.jetec.CRM.repository.ChangeMessageRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
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
import java.time.temporal.TemporalAdjusters;
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
    @Autowired
    CalenderService cs;
    @Autowired
    ChangeMessageRepository cmr;

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
        Authentication authentication;
        AdminBean adminBean = null;
        try {
            authentication = SecurityContextHolder.getContext().getAuthentication();
            adminBean = (AdminBean) authentication.getPrincipal();
        } catch (Exception e) {
            return ZeroFactory.fail("錯誤! 未登入");
        }
        if (!leaveBean.getUuid().isEmpty()) {
            ls.delByUuid(leaveBean.getUuid());

        } else {
            leaveBean.setUuid(ZeroTools.getUUID());
        }
        logger.info("{} 儲存請假單", adminBean.getName());
        System.out.println(leaveBean);
        LocalDate start = LocalDateTime.parse(leaveBean.getStartday()).toLocalDate();
        LocalDate end = LocalDateTime.parse(leaveBean.getEndday()).toLocalDate();

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
    @RequestMapping("/leave/{id}")
    @ResponseBody
    public ResultBean leave(@PathVariable("id") Integer id) {
        logger.info("讀取請假單 {}", id);
        Map<String, Object> result = new HashMap<>();

        LeaveBean leaveBean = ls.getById(id);
        System.out.println(cmr.findByChangeid(leaveBean.getUuid(), Sort.by(Sort.Direction.DESC, "createtime")));
        result.put("bean", leaveBean);
        result.put("changeMessageList", cmr.findByChangeid(leaveBean.getUuid(), Sort.by(Sort.Direction.DESC, "createtime")));
        return ZeroFactory.buildResultBean(200, "讀取請假單", result);
    }

    //出差申請
    @RequestMapping("/saveBusinessTrip")
    @ResponseBody
    public ResultBean saveBusinessTrip(BusinessTripBean btBean) {
        logger.info("{} 存出差申請", btBean.getSchedule());
        System.out.println(btBean);
        bts.delNull();

        if (btBean.getUuid() == null || btBean.getUuid().isEmpty()) {
            btBean.setUuid(ZeroTools.getUUID());
        }

        List<CooperatorBean> cList = btBean.getCooperator();
        //刪除空白的協從人員
        if (cList != null) {
            Iterator<CooperatorBean> iterator = cList.iterator();
            while (iterator.hasNext()) {
                CooperatorBean e = iterator.next();
                if (e.getName().isEmpty()) {
                    iterator.remove();
                }
            }
            btBean.setCooperator(cList);
        }

        BusinessTripBean save = bts.save(btBean);
        bts.delNull();
        return ZeroFactory.buildResultBean(200, "出差申請成功", save.getTripid());
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
        Map<String , Object> result = new HashMap<>();

        BusinessTripBean bean = bts.getBusinessTrip(tripid);
        result.put("bean",bean);
        result.put("changeMessageList", cmr.findByChangeid(bean.getUuid(), Sort.by(Sort.Direction.DESC, "createtime")));
        return ZeroFactory.buildResultBean(200, "讀取出差申請", result);
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
        Map<String, List> result = new HashMap<>(2);
        List<LeaveBean> leave = ls.getLeaveList(localDate.minusMonths(-1).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        leave.addAll(ls.getLeaveList(localDate.format(DateTimeFormatter.ofPattern("yyyy-MM"))));
        leave.addAll(ls.getLeaveList(localDate.minusMonths(+1).format(DateTimeFormatter.ofPattern("yyyy-MM"))));

        List<BusinessTripBean> businessTrip = bts.getBusinessTripList(localDate.minusMonths(-1).format(DateTimeFormatter.ofPattern("yyyy-MM")));
        businessTrip.addAll(bts.getBusinessTripList(localDate.format(DateTimeFormatter.ofPattern("yyyy-MM"))));
        businessTrip.addAll(bts.getBusinessTripList(localDate.minusMonths(+1).format(DateTimeFormatter.ofPattern("yyyy-MM"))));

        List<CalenderBean> calender = cs.getCalendarInitByDay(localDate.minusMonths(-1));
        calender.addAll(cs.getCalendarInitByDay(localDate));
        calender.addAll(cs.getCalendarInitByDay(localDate.minusMonths(+1)));

        result.put("leave", leave);
        result.put("businessTrip", businessTrip);
       result.put("calender", calender);
        return ZeroFactory.buildResultBean(200, "日歷初始化", result);
    }


    @RequestMapping("/addCalender")
    @ResponseBody
    public ResultBean addCalender(CalenderBean cBean) {
        logger.info("添加日历");
        System.out.println(cBean);

        cs.save(cBean);
        return ZeroFactory.success("添加成功");
    }

    /**
     * 讀取日历
     *
     * @param id id
     * @return {@link ResultBean}
     */
    @RequestMapping("/getCalender")
    @ResponseBody
    public ResultBean getCalender(@RequestParam("id") Integer id) {
        logger.info("讀取日历 {}", id);
        return ZeroFactory.success("添加成功", cs.getById(id));
    }

    /**
     * 刪除請假紀錄
     *
     * @param uuid uuid
     * @return {@link ResultBean}
     */
    @RequestMapping("/delLeave")
    @ResponseBody
    public ResultBean delLeave(@RequestParam("uuid") String uuid) {
        Authentication authentication;
        AdminBean adminBean = null;
        try {
            authentication = SecurityContextHolder.getContext().getAuthentication();
            adminBean = (AdminBean) authentication.getPrincipal();
        } catch (Exception e) {
            logger.info("刪除請假紀錄 未登入");
            return ZeroFactory.fail("錯誤! 未登入");
        }
        if (!uuid.isEmpty() || ls.existsByUuid(uuid)) {
            logger.info("{} 刪除請假紀錄 {}", adminBean.getName(), uuid);
            List<LeaveBean> leaveList = ls.getByUuid(uuid);
            for (LeaveBean leaveBean : leaveList) {
                leaveBean.setDel(1);
                ls.saveLeave(leaveBean);
            }
            ChangeMessageBean changeMessageBean = new ChangeMessageBean(ZeroTools.getUUID(), uuid, adminBean.getName(), "刪除請假", "刪除請假", uuid, LocalDateTime.now().format(DateTimeFormatter.ISO_DATE));
            cmr.save(changeMessageBean);
            return ZeroFactory.success("刪除成功");
        }
        logger.info("刪除請假紀錄 資料錯誤");
        return ZeroFactory.fail("刪除錯誤! 資料錯誤");
    }

    /**
     * 核准請假單
     *
     * @param id id
     * @return {@link ResultBean}
     */
    @RequestMapping("/clickDirector")
    @ResponseBody
    public ResultBean clickDirector(@RequestParam("id") Integer id) {
        Authentication authentication;
        AdminBean adminBean = null;
        try {
            authentication = SecurityContextHolder.getContext().getAuthentication();
            adminBean = (AdminBean) authentication.getPrincipal();
        } catch (Exception e) {
            logger.info("主管核准 未登入");
            return ZeroFactory.fail("錯誤! 未登入");
        }
        logger.info("{} 核准請假單", adminBean.getName());
        LeaveBean lBean = ls.getById(id);
        if (lBean != null) {
            if (lBean.getDirector() != null && !lBean.getDirector().isEmpty()) {
                ChangeMessageBean changeMessageBean = new ChangeMessageBean(ZeroTools.getUUID(), lBean.getUuid(), adminBean.getName(), "取消核准", lBean.getDirector(), "", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                cmr.save(changeMessageBean);
                lBean.setDirector("");
                ls.saveLeave(lBean);
                logger.info("取消核准");
                return ZeroFactory.buildResultBean(200, "核准取消", "");
            }
            ChangeMessageBean changeMessageBean = new ChangeMessageBean(ZeroTools.getUUID(), lBean.getUuid(), adminBean.getName(), "核准成功", lBean.getDirector(), adminBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            cmr.save(changeMessageBean);
            lBean.setDirector(adminBean.getName());
            ls.saveLeave(lBean);
            logger.info("核准成功");
            return ZeroFactory.success("核准成功", adminBean.getName());
        }
        logger.info("核准請假紀錄 資料錯誤");
        return ZeroFactory.fail("核准錯誤! 資料錯誤");
    }

    /**
     * 核准出差申請
     *
     * @param id id
     * @return {@link ResultBean}
     */
    @RequestMapping("/clickTripDirector")
    @ResponseBody
    public ResultBean clickTripDirector(@RequestParam("id") Integer id) {
        AdminBean adminBean = ZeroTools.getAdmin();
        if (adminBean == null) {
            logger.info("核准出差申請 未登入");
            return ZeroFactory.fail("錯誤! 未登入");
        }
        logger.info("{} 核准出差申請", adminBean.getName());
        BusinessTripBean btBean = bts.getBusinessTrip(id);

        if (btBean.getDirector() != null && !btBean.getDirector().isEmpty()) {
            ChangeMessageBean changeMessageBean = new ChangeMessageBean(ZeroTools.getUUID(), btBean.getUuid(), adminBean.getName(), "取消核准", btBean.getDirector(), "", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            cmr.save(changeMessageBean);
            btBean.setDirector("");
            bts.save(btBean);
            logger.info("取消核准");
            return ZeroFactory.buildResultBean(200, "核准取消", "");
        }
        ChangeMessageBean changeMessageBean = new ChangeMessageBean(ZeroTools.getUUID(), btBean.getUuid(), adminBean.getName(), "核准成功", btBean.getDirector(), adminBean.getName(), LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        cmr.save(changeMessageBean);
        btBean.setDirector(adminBean.getName());
        bts.save(btBean);
        logger.info("核准成功");
        return ZeroFactory.success("核准成功", adminBean.getName());
    }

    /**
     * 刪除出差申請
     *
     * @param id id
     * @return {@link ResultBean}
     */
    @RequestMapping("/delTripLeave")
    @ResponseBody
    public ResultBean delTripLeave(@RequestParam("id") Integer id) {
        AdminBean adminBean = ZeroTools.getAdmin();
        if (adminBean == null) {
            logger.info("刪除出差申請 未登入");
            return ZeroFactory.fail("錯誤! 未登入");
        }
        if (bts.existsById(id)) {
            logger.info("{} 刪除請假紀錄 {}", adminBean.getName(), id);


            bts.delById(id);
            return ZeroFactory.success("刪除成功");
        }
        logger.info("刪除請假紀錄 資料錯誤");
        return ZeroFactory.fail("刪除錯誤! 資料錯誤");
    }

    /**
     * 搜索汽车
     *
     * @param car   车
     * @param start 开始
     * @param end   结束
     * @return {@link ResultBean}
     */
    @RequestMapping("/searchCar")
    @ResponseBody
    public ResultBean searchCar(@RequestParam("car") String car, @RequestParam("start") String start, @RequestParam("end") String end) {
        if (Objects.equals("undefined", start)) {
            start = "2022-10-01";
        }
        if (Objects.equals("undefined", end)) {
            logger.info("出差搜索 車號{} {} {}", car, start, end);
            return ZeroFactory.success("出差搜索", bts.searchCar(car));
        }
        end = LocalDate.parse(end).with(TemporalAdjusters.lastDayOfMonth()).format(DateTimeFormatter.ISO_DATE);

        logger.info("出差搜索 車號{} {} {}", car, start, end);

        return ZeroFactory.success("出差搜索", bts.searchCar(car, start, end));
    }

    /**
     * 假單搜索
     *
     * @param person 人
     * @param start  开始
     * @param end    结束
     * @return {@link ResultBean}
     */
    @RequestMapping("/searchLeaveByPerson")
    @ResponseBody
    public ResultBean searchLeaveByPerson(@RequestParam("person") String person, @RequestParam("start") String start, @RequestParam("end") String end) {
        if (Objects.equals("undefined", start)) {
            start = "2022-10-01";
        }
        if (Objects.equals("undefined", end)) {
            logger.info("假單搜索 人員 :{} {} {}", person, start, end);
            return ZeroFactory.success("假單搜索", ls.searchUser(person));
        }
        end = LocalDate.parse(end).with(TemporalAdjusters.lastDayOfMonth()).format(DateTimeFormatter.ISO_DATE);

        logger.info("假單搜索 人員 :{} {} {}", person, start, end);
        return ZeroFactory.success("假單搜索", ls.searchUser(person, start, end));
    }

}
