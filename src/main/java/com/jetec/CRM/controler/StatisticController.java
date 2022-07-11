package com.jetec.CRM.controler;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.controler.service.StatisticService;
import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.LibraryBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import static java.util.stream.Collectors.toList;

@Controller
@RequestMapping("/statistic")
//@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class StatisticController {
    @Autowired
    ZeroTools zTools;
    @Autowired
    StatisticService ss;
    @Autowired
    SystemService systemService;
    @Autowired
    MarketService ms;
    @Autowired
    PotentialCustomerService pcs;

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//數據管理初始化
    @RequestMapping("/init")
    @ResponseBody
    public Map<String, Object> init() {
        System.out.println("數據管理初始化");
        Map<String, Object> result = new HashMap<>();
        result.put("SubmitBos", ms.getSubmitBos());//提交主管
        result.put("CallBos", ms.CallBos());//延長請求
        result.put("potential", pcs.getPotentialSubmitBos());//提交主管

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String endDay = sdf.format(new Date());
        //取90天
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -90);
        Date todate1 = cal.getTime();
        String startDay = sdf.format(todate1);
        System.out.println("startDay :" + startDay);
        System.out.println("endDay :" + endDay);


        Map<String, Object> CompanyNumList = getListByDate(startDay, endDay);

        result.put("CompanyNumList", CompanyNumList);//每天公司數量
        //result.put("companyNum", ss.selectCompany(startDay, endDay));//公司名稱列表
//        result.put("AdminCastNum", AdminCastNum(startDay, endDay));//取得個業務案件數量
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索
    @RequestMapping("/selectCompany")
    @ResponseBody
    public Map<String, Object> selectCompany(@RequestParam("from") String startDay, @RequestParam("to") String endDay, HttpServletRequest sce) {
        System.out.println("搜索公司數量");
        Map<String, Object> result = new HashMap<>();

        if (startDay == null || startDay.equals("")) {
            startDay = zTools.getTime(new Date());
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        if (Objects.equals(endDay, "")) {
            endDay = zTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        Map<String, Object> CompanyNumList = getListByDate(startDay.substring(0, 10), endDay.substring(0, 10));
        ServletContext app = sce.getServletContext();
        List<LibraryBean> libraryList = (List<LibraryBean>) app.getAttribute("library");


        result.put("CompanyNumList", CompanyNumList);//每天案件數量
        result.put("companyNum", ss.selectCompany(startDay, endDay));//公司名稱列表
        result.put("AdminCastNum", AdminCastNum(startDay, endDay));//取得個業務案件數量
        result.put("producttype", producttype(startDay, endDay, libraryList));//商品類別
        result.put("BusinessState", BusinessState(startDay, endDay));//業務成功失敗
        result.put("MaxNumCompany", ss.getMaxNumCompany(startDay, endDay));//案件最多的5間公司
        result.put("SuccessMaxNumCompany", ss.getSuccessMaxNumCompany(startDay, endDay));//成功案件最多的5間公司
        result.put("FailMaxNumCompany", ss.getFailMaxNumCompany(startDay, endDay));//失敗案件最多的5間公司

        return result;

    }

    /////////////////////////////////////////////////////////////////////////////////////////
//取得個業務案件數量
    private Map<String, Object> AdminCastNum(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("取得個業務案件數量");
        Map<String, Object> result = new HashMap<>();
        List<AdminBean> adminList = systemService.getAdminByDepartment("業務");
        for (AdminBean abean : adminList) {
            result.put(abean.getName(), ss.getAminCastNum(startDay, endDay, abean.getName()));
        }

        return result;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    public Map<String, Object> getListByDate(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        Map<String, Object> result = new HashMap<>();
        while (addDay(endDay).compareTo(startDay) > 0) {
            String s = startDay + " 00:00";
            String e = startDay + " 23:00";
            result.put(startDay, ss.selectCompany(s, e));
            startDay = addDay(startDay);
        }
        return result;
    }

    /////////////////////////////////////////////////////////////////////////////////////////
//商品種類
    private Map<String, Integer> producttype(@RequestParam("from") String startDay, @RequestParam("to") String endDay, List<LibraryBean> libraryBeanList) {
        System.out.println("商品種類");
        Map<String, Integer> result = new HashMap<>();
        String s = startDay + " 00:00";
        String e = endDay + " 23:00";

        //取得資料
        for (LibraryBean bean : libraryBeanList) {
            if ("producttype".equals(bean.getLibrarygroup())) {
                Integer i = ss.selectProductType(bean.getLibraryoption(), s, e);
                if (i > 0)
                    result.put(bean.getLibraryoption(), i);
            }
        }


        //排序
//        List<Map.Entry<String, Integer>> l = new ArrayList<>(result.entrySet() );
//        Collections.sort(l, new Comparator<Map.Entry<String, Integer>>() {
//            @Override
//            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer>o2) {
//                return o1.getValue().compareTo(o2.getValue());
//            }
//        });
//        result.clear();
//        Iterator<Map.Entry<String, Integer>> iterator = l.iterator();
//        for (Map.Entry<String, Integer> m: l  ) {
//            System.out.println(m.getKey()+" = "+m.getValue());
//            result.put(m.getKey(),m.getValue());
//        }
//
//        
        return result;
    }

    //////////////////////////////////////////////////////////////////////////////
//    日期加1天
    public String addDay(String day) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(dateFormat.parse(day));
        } catch (ParseException e1) {

        }
        cal.add(Calendar.DATE, 1);
        return dateFormat.format(cal.getTime());
    }

    //////////////////////////////////////////////////////////////////////////////
    //  業務成功失敗
    private Map<String, Object> BusinessState(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("業務成功失敗");

        Map<String, Object> result = new HashMap<>();


        List<AdminBean> adminList = systemService.getAdminByDepartment("業務");
        for (AdminBean abean : adminList) {
            List<Integer> sta = new ArrayList<>();
            sta.add(ss.getAminStateNum(abean.getName(), "成功結案", startDay, endDay));
            sta.add(ss.getAminStateNum(abean.getName(), "失敗結案", startDay, endDay));
            result.put(abean.getName(), sta);
        }

        return result;
    }

    //////////////////////////////////////////////////////////////////////////////
    //結案狀態
    @ResponseBody
    @RequestMapping("/CloseState")
    private Map<String, Object> CloseState(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("結案狀態");
        Map<String, Object> result = new HashMap<>();


        if (Objects.equals(endDay, "")) {
            endDay = ZeroTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        if (startDay == null || startDay.equals("")) {
            startDay = zTools.addDay(endDay, -7);
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }

        result.put("success", ss.getMarketByState("成功結案", startDay, endDay));
        result.put("fail", ss.getMarketByState("失敗結案", startDay, endDay));
        result.put("other", ss.getMarketByCloseNot(startDay, endDay));


        return result;
    }

    //////////////////////////////////////////////////////////////////////////////
    //結案狀態
    @ResponseBody
    @RequestMapping("/CloseState2")
    private Map<String, Object> CloseState2(@RequestParam("from") String startDay, @RequestParam("to") String endDay) {
        System.out.println("結案狀態");
        Map<String, Object> result = new HashMap<>();


        if (Objects.equals(endDay, "")) {
            endDay = ZeroTools.getTime(new Date());
        } else {
            endDay = endDay + "T24:00";
        }
        if (startDay == null || "".equals(startDay)) {
            startDay = zTools.addDay(endDay, -7);
            startDay = startDay.substring(0, 10);
            startDay = startDay + "T00:00";
        } else {
            startDay = startDay + "T00:00";
        }


        List<MarketBean> l = ss.getMarketBYBbb(startDay, endDay);
        System.out.println("活耀案件:" + l.size() + "筆");
//        List<MarketBean> l = ss.getMarketByAaa( startDay,endDay);
        List<Map<String, String>> success = new ArrayList<>();
        l.stream().filter(e -> "成功結案".equals(e.getStage())).forEach(e -> {

            Map<String, String> x = new HashMap<>();
            x.put("client", e.getClient());
            x.put("aaa", e.getAaa());
            x.put("user", e.getUser());
            x.put("marketid", e.getMarketid());
            success.add(x);
        });
        List<Map<String, String>> fail = new ArrayList<>();
        l.stream().filter(e -> "失敗結案".equals(e.getStage())).forEach(e -> {
            Map<String, String> x = new HashMap<>();
            x.put("client", e.getClient());
            x.put("closereason", e.getClosereason());
            x.put("marketid", e.getMarketid());
            fail.add(x);
        });
        result.put("success", success);
        result.put("fail", fail);
        result.put("other", ss.getMarketByCloseNot(startDay, endDay));
        return result;
    }

    //////////////////////////////////////////////////////////////////////////////
    //業務接案
    @ResponseBody
    @RequestMapping("/BusinessCase")
    private Map<String, Object> BusinessCase(@RequestParam("startDay") String startDay, @RequestParam("endDay") String endDay) {
        System.out.println("***業務接案***");
        Map<String, Object> result = new HashMap<>();
        //日期整理
        if (Objects.equals(endDay, "")) {
            endDay = ZeroTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        if (startDay == null || "".equals(startDay)) {
            startDay = zTools.addDay(endDay, -7);
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }
        List<AdminBean> Business = ss.getBusiness();
        for (AdminBean a : Business) {
            List<MarketBean> marketBeanList = ss.getMarketBYAaaAndUser(startDay, endDay, a.getName());
            List<PotentialCustomerBean> pList = ss.getPotentialCustomerbyBYAaaAndUserNotinMarket(startDay, endDay, a.getName());
            int 接案數 = marketBeanList.size() + pList.size();
            if (接案數 > 0) {
                int 成功數 = 0;
                int 失敗數 = 0;
                int 未結案 = 0;
                int 領取數 = 0;
                int 分配數 = 0;
                int 領取成功 = 0;
                int 領取失敗 = 0;
                int 分配成功 = 0;
                int 分配失敗 = 0;
                int 領取未結案 = 0;
                int 分配未結案 = 0;
                Map<String, Object> o = new HashMap<>();
                for (MarketBean m : marketBeanList) {
                    if (Objects.equals("成功結案", m.getStage())) 成功數++;
                    if (Objects.equals("失敗結案", m.getStage())) 失敗數++;
                    if (!Objects.equals("失敗結案", m.getStage()) && !Objects.equals("成功結案", m.getStage())) 未結案++;
                    if (Objects.equals(1, m.getReceivestate())) 領取數++;
                    if (Objects.equals(2, m.getReceivestate())) 分配數++;
                    if (Objects.equals(1, m.getReceivestate()) && Objects.equals("成功結案", m.getStage())) 領取成功++;
                    if (Objects.equals(1, m.getReceivestate()) && Objects.equals("失敗結案", m.getStage())) 領取失敗++;
                    if (Objects.equals(2, m.getReceivestate()) && Objects.equals("成功結案", m.getStage())) 分配成功++;
                    if (Objects.equals(2, m.getReceivestate()) && Objects.equals("失敗結案", m.getStage())) 分配失敗++;
                    if (Objects.equals(1, m.getReceivestate()) && (Objects.equals("尚未處理", m.getStage()) || Objects.equals("潛在客戶轉", m.getStage()) || Objects.equals("內部詢價中", m.getStage()) || Objects.equals("已報價", m.getStage()) || Objects.equals("提交主管", m.getStage())))
                        領取未結案++;
                    if (Objects.equals(2, m.getReceivestate()) && (Objects.equals("尚未處理", m.getStage()) || Objects.equals("潛在客戶轉", m.getStage()) || Objects.equals("內部詢價中", m.getStage()) || Objects.equals("已報價", m.getStage()) || Objects.equals("提交主管", m.getStage())))
                        分配未結案++;
                }
                for (PotentialCustomerBean m : pList) {
                    if (Objects.equals("合格", m.getStatus())) 成功數++;
                    if (Objects.equals("不合格", m.getStatus())) 失敗數++;
                    if (!Objects.equals("合格", m.getStatus()) && !Objects.equals("不合格", m.getStatus())) 未結案++;
                    if (Objects.equals(1, m.getReceivestate())) 領取數++;
                    if (Objects.equals(2, m.getReceivestate())) 分配數++;
                    if (Objects.equals(1, m.getReceivestate()) && Objects.equals("合格", m.getStatus())) 領取成功++;
                    if (Objects.equals(1, m.getReceivestate()) && Objects.equals("不合格", m.getStatus())) 領取失敗++;
                    if (Objects.equals(2, m.getReceivestate()) && Objects.equals("合格", m.getStatus())) 分配成功++;
                    if (Objects.equals(2, m.getReceivestate()) && Objects.equals("不合格", m.getStatus())) 分配失敗++;
                    if (Objects.equals(1, m.getReceivestate()) && (!Objects.equals("合格", m.getStatus()) && !Objects.equals("不合格", m.getStatus())))
                        領取未結案++;
                    if (Objects.equals(2, m.getReceivestate()) && (!Objects.equals("合格", m.getStatus()) && !Objects.equals("不合格", m.getStatus())))
                        分配未結案++;
                }
                o.put("name", a.getName());
                o.put("接案數", 接案數);
                o.put("成功數", 成功數);
                o.put("失敗數", 失敗數);
                o.put("未結案", 未結案);
                o.put("領取數", 領取數);
                o.put("分配數", 分配數);
                o.put("領取成功", 領取成功);
                o.put("領取失敗", 領取失敗);
                o.put("分配成功", 分配成功);
                o.put("分配失敗", 分配失敗);
                o.put("領取未結案", 領取未結案);
                o.put("分配未結案", 分配未結案);
                result.put(a.getName(), o);
            }
        }
        
        return result;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    //業務接案 細節
    //state 1 成功  2 失敗  3未結案 4全
    //receives 1領取 2分配  3 全
    @ResponseBody
    @RequestMapping("/BusinessDetail")
    public Map<String, Object> BusinessDetail(@RequestParam("state") String state, @RequestParam("receives") Integer receives, @RequestParam("startDay") String startDay, @RequestParam("endDay") String endDay, @RequestParam("user") String user) {
        Map<String, Object> result = new HashMap<>();
        List<MarketBean> mList = new ArrayList<>();
        List<PotentialCustomerBean> pList = new ArrayList<>();
        System.out.println("state "+state);
        System.out.println("receives "+receives);
        System.out.println(startDay);
        System.out.println(endDay);
        System.out.println("user " +user);

        //日期整理
        if (Objects.equals(endDay, "")) {
            endDay = ZeroTools.getTime(new Date());
        } else {
            endDay = endDay + " 24:00";
        }
        if (startDay == null || "".equals(startDay)) {
            startDay = zTools.addDay(endDay, -7);
            startDay = startDay.substring(0, 10);
            startDay = startDay + " 00:00";
        } else {
            startDay = startDay + " 00:00";
        }


        //
        if (Objects.equals(3, receives)) {
            if (Objects.equals("1", state)) {
                mList = ss.getMarketByAaaAndUserAndState(user, "成功結案",  startDay, endDay);
                pList = ss.getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(user, "合格",  startDay, endDay);
                result.put("Market", mList);
                result.put("Customer", pList);
                System.out.println(result);
                return result;
            }
            if (Objects.equals("2", state)) {
                mList = ss.getMarketByAaaAndUserAndState(user, "失敗結案", startDay, endDay);
                pList = ss.getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(user, "不合格", startDay, endDay);
                result.put("Market", mList);
                result.put("Customer", pList);
                System.out.println("result");
                return result;
            }
            if (Objects.equals("3", state)) {
                mList = ss.getMarketByAaaAndUserAndState(user, "尚未處理", startDay, endDay);
                mList.addAll(ss.getMarketByAaaAndUserAndState(user, "內部詢價中", startDay, endDay));
                mList.addAll(ss.getMarketByAaaAndUserAndState(user, "已報價", startDay, endDay));
                mList.addAll(ss.getMarketByAaaAndUserAndState(user, "提交主管", startDay, endDay));
                mList.addAll(ss.getMarketByAaaAndUserAndState(user, "潛在客戶轉", startDay, endDay));
                pList = ss.getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(user, "未處理", startDay, endDay);
                pList.addAll(ss.getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(user, "已聯繫", startDay, endDay));
                pList.addAll(ss.getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(user, "提交主管", startDay, endDay));
                result.put("Market", mList);
                result.put("Customer", pList);
                return result;
            }
            if (Objects.equals("4", state)) {
                mList = ss.getMarketBYAaaAndUser(user, startDay, endDay);
                pList = ss.getPotentialCustomerbyBYAaaAndUserNotinMarket(  startDay, endDay,user);
                result.put("Market", mList);
                result.put("Customer", pList);
                return result;
            }
        }
        if (Objects.equals("1", state)) {
            mList = ss.getMarketByAaaAndUserAndStateAndReceives(user, "成功結案", receives, startDay, endDay);
            pList = ss.getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(user, "合格", receives, startDay, endDay);
            result.put("Market", mList);
            result.put("Customer", pList);
            return result;
        }
        if (Objects.equals("2", state)) {
            mList = ss.getMarketByAaaAndUserAndStateAndReceives(user, "失敗結案", receives, startDay, endDay);
            pList = ss.getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(user, "不合格", receives, startDay, endDay);
            result.put("Market", mList);
            result.put("Customer", pList);
            return result;
        }
        if (Objects.equals("3", state)) {
            mList = ss.getMarketByAaaAndUserAndStateAndReceives(user, "尚未處理", receives, startDay, endDay);
            mList.addAll(ss.getMarketByAaaAndUserAndStateAndReceives(user, "內部詢價中", receives, startDay, endDay));
            mList.addAll(ss.getMarketByAaaAndUserAndStateAndReceives(user, "已報價", receives, startDay, endDay));
            mList.addAll(ss.getMarketByAaaAndUserAndStateAndReceives(user, "提交主管", receives, startDay, endDay));
            mList.addAll(ss.getMarketByAaaAndUserAndStateAndReceives(user, "潛在客戶轉", receives, startDay, endDay));
            pList = ss.getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(user, "未處理", receives, startDay, endDay);
            pList.addAll(ss.getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(user, "已聯繫", receives, startDay, endDay));
            pList.addAll(ss.getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(user, "提交主管", receives, startDay, endDay));
            result.put("Market", mList);
            result.put("Customer", pList);
            return result;
        }
        if (Objects.equals("4", state)) {
            mList = ss.getMarketAndUserAndReceivesByAaa(user,  receives, startDay, endDay);
            pList = ss.getPotentialCustomerAndUserAndReceivesByAaaAndNotinMarket(user,  receives, startDay, endDay);
            result.put("Market", mList);
            result.put("Customer", pList);
            return result;
        }
        return result;
    }


}
