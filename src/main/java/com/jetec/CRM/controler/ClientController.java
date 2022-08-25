package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.controler.service.ClientService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@ResponseBody
@RequestMapping("/client")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')OR hasAuthority('國貿')")
public class ClientController {

    @Autowired
    ClientService CS;

    Logger logger = LoggerFactory.getLogger("ClientController");

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取標籤列表
    @RequestMapping("/getTag/{clientid}")
    public ResultBean getTagList(@PathVariable("clientid") Integer clientid) {
        logger.info("讀取客戶標籤列表");
        return ZeroFactory.success("客戶標籤列表", CS.getTagList(clientid));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除標籤
    @RequestMapping("/removeTag/{clientid}/{clienttagid}")
    public ResultBean removeTag(@PathVariable("clienttagid") String clienttagid,
                                         @PathVariable("clientid") Integer clientid) {
        logger.info("刪除標籤 {}",clienttagid);
        CS.removeTag(clienttagid);
        return ZeroFactory.success("客戶標籤列表", CS.getTagList(clientid));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增標籤
    @RequestMapping("/addTag/{clientid}/{tagName}")
    public ResultBean tag(@PathVariable("tagName") String tagName,
                                   @PathVariable("clientid") Integer clientid) {
        logger.info("新增標籤 {}  {} ",tagName, clientid);
        CS.saveTag(tagName, clientid);
        return ZeroFactory.success("客戶標籤列表", CS.getTagList(clientid));
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//各戶負責人改變
    @RequestMapping("/changeUser/{clientid}/{user}")
    public ResultBean changeUser(@PathVariable("clientid") Integer clientid,
                             @PathVariable("user") String user) {
        logger.info("各戶負責人改變 {}",user);
        CS.changeUser(clientid, user);
        return ZeroFactory.success("修改成功");
    }
}
