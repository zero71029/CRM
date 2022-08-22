package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.JobDescriptionService;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.JobDescriptionBean;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/JobDescription")
public class JobDescriptionController {
    @Autowired
    JobDescriptionService jds;
    Logger logger = LoggerFactory.getLogger("JobDescriptionController");

    //初始化
    @RequestMapping("/init/{jobdescriptionid}")
    @ResponseBody
    public Map<String, Object> init(@PathVariable("jobdescriptionid") String jobdescriptionid) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            AdminBean adminBean = (AdminBean) authentication.getPrincipal();
            logger.info("{} 讀取⼯作說明細節", adminBean.getName());
        } catch (Exception e) {
            logger.info("未登入 讀取⼯作說明細節");
        }
        Map<String, Object> result = new HashMap<>();
        result.put("jobdescription", jds.findById(jobdescriptionid));
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//列表初始化
    @RequestMapping("/ListInit")
    @ResponseBody
    public List<JobDescriptionBean> ListInit(@RequestParam("pag") Integer pag) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            AdminBean adminBean = (AdminBean) authentication.getPrincipal();
            logger.info("{} 讀取⼯作說明列表", adminBean.getName());
        } catch (Exception e) {
            logger.info("未登入 讀取⼯作說明列表");
        }
        pag--;
        if (pag < 0) pag = 0;
        return jds.findAll();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存⼯作說明
    @RequestMapping("/saveJobDescription")
    @ResponseBody
    public String saveJobDescription(JobDescriptionBean jdBean) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            AdminBean adminBean = (AdminBean) authentication.getPrincipal();
            logger.info("{} 儲存⼯作說明 ", adminBean.getName());
        } catch (Exception e) {
            logger.info("未登入 儲存⼯作說明");
        }
        System.out.println("*****儲存⼯作說明*****");
        if (jdBean.getJobdescriptionid().equals(""))
            jdBean.setJobdescriptionid(ZeroTools.getUUID());
        logger.info("{}", jdBean.getWorkcontent());
        jds.save(jdBean);
        return jdBean.getJobdescriptionid();
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//列印任務
    @RequestMapping("/print/{id}")
    public String print(Model model, @PathVariable("id") String id) {
        System.out.println("列印任務");
        JobDescriptionBean jdBean = jds.findById(id);
        jdBean.setWorkcontent(jdBean.getWorkcontent().replaceAll("[\\t\\r]", "<br>"));
        jdBean.setAssessmentindicators(jdBean.getAssessmentindicators().replaceAll("[\\t\\r]", "<br>"));
        model.addAttribute("bean", jdBean);
        return "/JobDescription/print";
    }
}
