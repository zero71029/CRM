package com.jetec.CRM.controler;

import com.github.benmanes.caffeine.cache.Cache;
import com.jetec.CRM.Tool.ZeroCode;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Set;


@Controller
@RequestMapping("/zero")
@PreAuthorize("hasAuthority('系統')  ")
public class ZeroController {
    @Autowired
    MarketRepository mr;
    @Autowired
    ContactRepository cr;

    Logger logger = LoggerFactory.getLogger("ZeroController");
    @Autowired
    Cache<String, Object> caffeineCache;

    //刪除緩存Market
    @RequestMapping("/delMarketCache/{id}")
    @ResponseBody
    public String delCache(@PathVariable("id") String id) {
        logger.info("刪除緩存 {}", id);
        caffeineCache.asMap().remove(ZeroCode.Redis_Market_Id + id);
        return "刪除緩存 " + id;
    }

    //刪除緩存Customer
    @RequestMapping("/delCustomerCache/{id}")
    @ResponseBody
    public String delCustomerCache(@PathVariable("id") String id) {
        logger.info("刪除緩存 {}", id);
        caffeineCache.asMap().remove(ZeroCode.Redis_Customer_Id + id);
        return "刪除緩存 " + id;
    }

    //刪除緩存
    @RequestMapping("/ClearCache")
    @ResponseBody
    public String ClearCache() {
        logger.info("刪除緩存");
        caffeineCache.asMap().clear();
        return "緩存刪除 成功";
    }

    //輸出緩存
    @RequestMapping("/outCache")
    @ResponseBody
    public Set<String> outCache() {
        logger.info("輸出緩存");
        return caffeineCache.asMap().keySet();
    }

    //修改ContactId
    @RequestMapping("/changeContact")
    @ResponseBody
    public String changeContact() {
        logger.info("修改ContactId");
        List<ContactBean> contactList = cr.findAll();
        contactList.forEach(contactBean -> {
            List<MarketBean> marketlist = mr.findByContactnameAndClient(contactBean.getName(), contactBean.getCompany());
            if (marketlist != null) {
                for (MarketBean marketBean : marketlist) {
                    marketBean.setContactid(contactBean.getContactid());
                    mr.save(marketBean);
                }
            }
        });
        return "結束";
    }
}
