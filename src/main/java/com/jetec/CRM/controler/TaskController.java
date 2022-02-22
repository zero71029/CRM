package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.TaskService;
import com.jetec.CRM.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/task")
public class TaskController {
    @Autowired
    TaskService TS;
    @Autowired
    ZeroTools zTools;

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

        String ddd = zTools.getTime(new Date());
        if (bean.getEvaluatedate() == null || bean.getEvaluatedate().isEmpty())
            bean.setEvaluatedate(zTools.getTime(new Date()));
        if (bean.getEvaluateid() == null || bean.getEvaluateid().isEmpty()) bean.setEvaluateid(zTools.getUUID());
        if (bean.getName() == null || bean.getName().isEmpty()) {
            AdminBean adminBean = (AdminBean) session.getAttribute("user");
            bean.setName(adminBean.getName());
        } else {
            bean.setName(bean.getName());
        }
        int i = 0;
        for (EvaluateTaskBean task : bean.getTask()) {
//            if (task.getTaskid() == null || task.getTaskid().isEmpty()) {
//                task.setTaskid(zTools.getUUID());
//                i++;
//            }
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
        System.out.println("任務列表");
        pag--;
        return TS.getList(pag);
    }

    @ResponseBody
    @RequestMapping("/taskList")
    public Map<String, Object> workList(@RequestParam("pag") Integer pag, @RequestParam("name") String name) {
        System.out.println("任務列表");
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

}
