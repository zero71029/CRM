package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.AdminService;
import com.jetec.CRM.model.AdminPermitBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/admin")
@PreAuthorize("hasAuthority('系統') ")
public class AdminController {

    Logger logger = LoggerFactory.getLogger("AccountApplicationController.class");

    @Autowired
    AdminService as;
    /**
     * 改变许可
     *
     * @param adminid adminid
     * @param permit  權限
     * @return {@link ResultBean}
     */
    @RequestMapping("/changePermit")
    @ResponseBody
    public ResultBean changePermit(@RequestParam("adminid") Integer adminid, @RequestParam("permit") String permit) {
        logger.info("{} 修改權限  {}   {}", ZeroTools.getAdmin().getName(),adminid, permit);
        AdminPermitBean apBean = as.findAdminPermitBeanByAdminAndLevel(adminid,permit);
        if(apBean == null){
            apBean = new AdminPermitBean(ZeroTools.getUUID(),adminid,permit);
            as.savePermit(apBean);
            logger.info("{} 新增 {}", ZeroTools.getAdmin().getName(), permit);
            return ZeroFactory.success("添加成功",as.getPermit(adminid));
        }

        as.delPermit(apBean);
        logger.info("{} 刪除 {}", ZeroTools.getAdmin().getName(), permit);
        return ZeroFactory.success("刪除成功",as.getPermit(adminid));
    }


    @RequestMapping("/getPermit")
    @ResponseBody
    public ResultBean getPermit(@RequestParam("adminid") Integer adminid) {
        logger.info("{} 讀取權限 {}", ZeroTools.getAdmin().getName(), adminid);
        return ZeroFactory.success("讀取權限",as.getPermit(adminid));
    }
}
