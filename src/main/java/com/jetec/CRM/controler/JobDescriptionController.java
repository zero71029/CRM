package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.JobDescriptionService;
import com.jetec.CRM.model.JobDescriptionBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//初始化
    @RequestMapping("/init/{jobdescriptionid}")
    @ResponseBody
    public Map<String, Object> init(@PathVariable("jobdescriptionid ") String jobdescriptionid) {
        Map<String, Object> result = new HashMap<>();
        result.put("customer", "eeee");

        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//列表初始化
    @RequestMapping("/ListInit")
    @ResponseBody
    public List<JobDescriptionBean> ListInit(@RequestParam("pag") String pag) {
        System.out.println("*****⼯作說明列表初始化*****"+pag);
        System.out.println(jds.findAll());
        return jds.findAll();
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存⼯作說明
    @RequestMapping("/saveJobDescription")
    @ResponseBody
    public String saveJobDescription(JobDescriptionBean jdBean) {
        System.out.println("*****儲存⼯作說明*****");
        if(jdBean.getJobdescriptionid().equals(""))
        jdBean.setJobdescriptionid(ZeroTools.getUUID());
        jds.save(jdBean);
        return jdBean.getJobdescriptionid();
    }
}
