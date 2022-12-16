package com.jetec.CRM.controler.service;

import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.repository.AdminRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class StatisticService {
    @Autowired
    MarketRepository mr;
    @Autowired
    AdminRepository ar;
    @Autowired
    PotentialCustomerRepository pcr;

    /////////////////////////////////////////////////////////////////////////////////////////
    //搜索公司數量
    public List<String> selectCompany(String startDay, String endDay) {
        return mr.selectCompany(startDay, endDay);
    }

    /////////////////////////////////////////////////////////////////////////////////////////
//取得個業務案件數量
    public Integer getAminCastNum(String startDay, String endDay, String name) {

        return mr.getAminCastNum(startDay, endDay, name);
    }

    /////////////////////////////////////////////////////////////////////////////////////////
//商品種類
    public Integer selectProductType(String name, String startDay, String endDay) {

        return mr.getProductTypeNum(name, startDay, endDay);


    }

    /////////////////////////////////////////////////////////////////////////////////////////
//業務階段搜索
    public Integer getAminStateNum(String admin,String state, String startDay, String endDay) {

        return mr.getAminStateNum(admin,state, startDay, endDay);
    }

    /////////////////////////////////////////////////////////////////////////////////////////
//找出案件多的公司
    public  List< Map<String, String>> getMaxNumCompany(String startDay, String endDay){
       List< Map<String, String>> result =new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/crm", "root", "root");
            stmt = conn.createStatement();
            String sql = "select client ,clientid, count(*) count from market m where  aaa BETWEEN '"+startDay+"' AND '"+endDay+"' group by client,clientid order  by count desc  limit 5";
            rs = stmt.executeQuery(sql);

            while (rs.next()){
                Map<String, String>  map= new HashMap<>();
                map.put("company",rs.getString(1));
                map.put("num",rs.getString(3));
                map.put("clientid",rs.getString(2));
                result.add(map);
            }

        } catch ( Exception e) {
            e.printStackTrace();
        }
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////
//找出成功案件多的公司
    public  List< Map<String, String>> getSuccessMaxNumCompany(String startDay, String endDay){
        List< Map<String, String>> result =new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/crm", "root", "root");
            stmt = conn.createStatement();
            String sql = "select client ,clientid, count(*) count from market m where  stage = '成功結案'   AND  bbb BETWEEN '"+startDay+"' AND '"+endDay+"' group by client,clientid order  by count desc  limit 5";
            rs = stmt.executeQuery(sql);

            while (rs.next()){
                Map<String, String>  map= new HashMap<>();
                
                map.put("company",rs.getString(1));
                map.put("clientid",rs.getString(2));
                map.put("num",rs.getString(3));
                result.add(map);
            }

        } catch ( Exception e) {
            e.printStackTrace();
        }
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
    /////////////////////////////////////////////////////////////////////////////////////////
//找出失敗案件多的公司
    public  List< Map<String, String>> getFailMaxNumCompany(String startDay, String endDay){
        List< Map<String, String>> result =new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/crm", "root", "root");
            stmt = conn.createStatement();
            String sql = "select client ,clientid, count(*) count from market m where  stage = '失敗結案'  AND  bbb BETWEEN '"+startDay+"' AND '"+endDay+"' group by client,clientid order  by count desc  limit 5";
            rs = stmt.executeQuery(sql);

            while (rs.next()){
                Map<String, String>  map= new HashMap<>();
                map.put("company",rs.getString(1));
                map.put("clientid",rs.getString(2));
                map.put("num",rs.getString(3));
                result.add(map);
            }

        } catch ( Exception e) {
            e.printStackTrace();
        }
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    public List<MarketBean> getMarketByState(String state, String startDay, String endDay) {
        return mr.findByStageAndAaaBetween(state,startDay,endDay, Sort.by(Sort.Direction.DESC,"aaa"));
    }

    public List<MarketBean> getMarketByCloseNot(String startDay, String endDay) {
        return mr.findCreatetime();
    }

    public List<MarketBean> getMarketByAaa(String startDay, String endDay) {
        return mr.findAaaXXXXXXX(startDay,endDay);
    }


    public List<MarketBean> getMarketByEndtime(String startDay, String endDay) {
        return mr.findByEndtimeBetween(startDay,endDay);
    }

    public List<AdminBean> getBusiness() {
        List<AdminBean> result = ar.getByDepartmentAndState("業務","在職");
        result.addAll(ar.getByDepartmentAndState("業務","新"));
        return result;
    }


    public List<MarketBean> getMarketBYAaaAndUser(String startDay, String endDay, String name) {
        return mr.findByUserAndAaaBetween(name,startDay,endDay,Sort.by(Sort.Direction.DESC,"bbb"));
    }

    public List<PotentialCustomerBean> getPotentialCustomerbyBYAaaAndUserNotinMarket(String startDay, String endDay, String name) {
        return pcr.getPotentialCustomerbyBYAaaAndUserNotinMarket( startDay, endDay,  name);
    }

    public List<MarketBean> getMarketByAaaAndUserAndStateAndReceives(String user, String state, Integer receives, String startDay, String endDay) {

        return mr.findByUserAndStageAndReceivestateAndAaaBetween(user,state,receives,startDay,endDay);
    }

    public List<PotentialCustomerBean> getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(String user, String state, Integer receives, String startDay, String endDay) {
        return pcr.getPotentialCustomerByUserAndStateAndReceivesAndAaaAndNotinMarket(user,state,receives,startDay,endDay);
    }

    public List<MarketBean> getMarketByAaaAndUserAndState(String user, String stage, String startDay, String endDay) {
        return mr.findByUserAndStageAndAaaBetween(user,stage,startDay,endDay);
    }

    public List<PotentialCustomerBean> getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(String user, String state, String startDay, String endDay) {
        return pcr.getPotentialCustomerByUserAndStateAndAaaAndNotinMarket(user,state ,startDay,endDay);
    }

    public List<MarketBean> getMarketAndUserAndReceivesByAaa(String user, Integer receives, String startDay, String endDay) {
        return mr.findByUserAndReceivestateAndAaaBetween(user,receives,startDay,endDay);
    }

    public List<PotentialCustomerBean> getPotentialCustomerAndUserAndReceivesByAaaAndNotinMarket(String user, Integer receives, String startDay, String endDay) {
        return pcr.getPotentialCustomerAndUserAndReceivesByAaaAndNotinMarket(user,receives,startDay,endDay);
    }


    public int countCustometNumBYAaaAndUser(String startDay, String endDay, String name) {
        return pcr.countByUserAndAaaBetween(name,startDay,endDay);
    }

    public List<MarketBean> getMarketByAaaBetween(String startDay, String endDay) {
        return mr.findByAaaBetween(startDay,endDay);
    }
}
