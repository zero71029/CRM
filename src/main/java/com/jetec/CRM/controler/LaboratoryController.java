package com.jetec.CRM.controler;


import com.jetec.CRM.Tool.ResultBean;
import com.jetec.CRM.Tool.ZeroFactory;
import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.LaboratoryForumContentService;
import com.jetec.CRM.controler.service.LaboratoryForumService;
import com.jetec.CRM.model.LaboratoryForumBean;
import com.jetec.CRM.model.LaboratoryForumContentBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/laboratory")
@PreAuthorize("hasAuthority('系統') or hasAuthority('實驗室')")
public class LaboratoryController {

    Logger logger = LoggerFactory.getLogger("LaboratoryController");
    @Autowired
    LaboratoryForumService lfs;
    @Autowired
    LaboratoryForumContentService lfcs;


    /**
     * 存實驗室公佈欄
     *
     * @param lfBean  如果bean
     * @param forumid forumid
     * @param content 内容
     * @return {@link String}
     */
    @RequestMapping("/saveForum/{forumid}")
    public String saveLaboratoryForum(LaboratoryForumBean lfBean, @PathVariable("forumid") String forumid, @RequestParam("content") String content) {
        logger.info("{} 存實驗室公佈欄 {}", ZeroTools.getAdmin().getName(), forumid);
        lfBean.setForumgroupid("sssssssssss");
        if (lfBean.getForumid().isEmpty()) {
            lfBean.setForumid(ZeroTools.getUUID());
            lfBean.setTime(ZeroTools.getTime(new Date()));
        }
        LaboratoryForumBean save = lfs.save(lfBean);
        LaboratoryForumContentBean lfContent = new LaboratoryForumContentBean(save.getForumid(), content);
        lfcs.save(lfContent);
        return "redirect:/laboratory/forumList.jsp?page=1&size=20";
    }

    /**
     * 讀取實驗室公佈欄列表
     *
     * @param page 页面
     * @param size 大小
     * @return {@link ResultBean}
     */
    @RequestMapping("/getList")
    @ResponseBody
    public ResultBean getList(@RequestParam("page") Integer page, @RequestParam("size") Integer size) {
        logger.info("{} 讀取實驗室公佈欄列表 ", ZeroTools.getAdmin().getName());
        page--;
        if (page < 1) {
            page = 0;
        }
        Pageable pageable = PageRequest.of(page, size, Sort.Direction.DESC, "time");
        Page<LaboratoryForumBean> p = lfs.findByState("公開", pageable);
        Map<String, Object> result = new HashMap<>(3);

        result.put("list", p.getContent());
        result.put("total", p.getTotalElements());
        result.put("totalPag", p.getTotalPages());
        return ZeroFactory.success("文章列表", result);
    }


    /**
     * 讀取實驗室公佈欄細節
     *
     * @param forumid forumid
     * @return {@link ResultBean}
     */
    @RequestMapping("/getDetail")
    @ResponseBody
    public ResultBean getDetail(@RequestParam("forumid") String forumid) {
        logger.info("{} 讀取實驗室公佈欄細節 ", ZeroTools.getAdmin().getName(), forumid);
        Map<String, Object> result = new HashMap<>(2);

        LaboratoryForumBean laboratoryForumBean = lfs.findById(forumid);
        if (laboratoryForumBean != null) {
            LaboratoryForumContentBean lfcBean = lfcs.findById(forumid);
            result.put("content", lfcs.findById(forumid).getContent());
        }
        result.put("bean", laboratoryForumBean);
        return ZeroFactory.success("文章細節", result);
    }

    /**
     * 刪除公佈欄
     *
     * @param list 列表
     * @return {@link ResultBean}
     */
    @RequestMapping("/delforum")
    @ResponseBody
    public ResultBean delForum(@RequestParam("forumid") List<String> list) {
        logger.info("{} 刪除公佈欄 {}", ZeroTools.getAdmin().getName(), list);
        System.out.println(list);
        list.forEach(e -> {
            LaboratoryForumBean lfBean = lfs.findById(e);
            if (lfBean != null) {
                lfBean.setState("刪除");
                lfs.save(lfBean);
            }
        });
        return ZeroFactory.success("刪除成功");
    }



}
