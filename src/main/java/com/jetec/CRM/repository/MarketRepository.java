package com.jetec.CRM.repository;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jetec.CRM.model.MarketBean;

public interface MarketRepository extends JpaRepository<MarketBean, String> {

    List<MarketBean> findByNameLikeIgnoreCase(String string, Sort sort);

    List<MarketBean> findByUserLikeIgnoreCase(String string, Sort sort);

    List<MarketBean> findByClientLikeIgnoreCase(String string, Sort sort);

    List<MarketBean> findByContactnameLikeIgnoreCase(String string, Sort sort);

    List<MarketBean> findByClient(String name);

    List<MarketBean> findByStage(String string, Sort sort);

    List<MarketBean> findByUserAndStage(String adminname, String stage);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND(ccc BETWEEN ?1 AND ?2 )", nativeQuery = true)
    public List<MarketBean> findCreatetime(@Param("startTime") Date startTime, @Param("endTime") Date endTime);

    @Query(value = "SELECT  *  from market where (ccc BETWEEN :startTime AND :endTime )", nativeQuery = true)
    public List<MarketBean> findConflictMettinds(@Param("startTime") Date startTime, @Param("endTime") Date endTime);

    List<MarketBean> findByContactphone(String phone);

    List<MarketBean> findByContactmoblie(String moblie);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND producttype =?1", nativeQuery = true)
    List<MarketBean> findProducttype(String typeString);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND source =?1", nativeQuery = true)
    List<MarketBean> findSource(String typeString);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND clinch =?1", nativeQuery = true)
    List<MarketBean> selectClinch(String clinch);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND (cost BETWEEN ?1 AND ?2 )", nativeQuery = true)
    List<MarketBean> selectBudget(String start, String to);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND type =?1", nativeQuery = true)
    List<MarketBean> selectType(String typeString);

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案'  ", nativeQuery = true)
    Page<MarketBean> findStage(Pageable p);

    @Query(value = "SELECT  count(*)  from market where stage != '失敗結案' AND stage != '成功結案' order by marketid DESC ", nativeQuery = true)
    Integer getTotal();



    @Query(value = "SELECT  COUNT(*)  from market where aaa BETWEEN ?1 AND ?2  ", nativeQuery = true)
    Integer gettodayTotal(String s, String s1);

    @Query(value = "SELECT company as name FROM `potentialcustomer` WHERE `aaa` BETWEEN ?1 AND ?2\n" +
            "UNION\n" +
            "SELECT client as name FROM `market` WHERE `aaa` BETWEEN ?1 AND ?2", nativeQuery = true)
    List<String> selectCompany(String startDay, String endDay);

    @Query(value = "SELECT  *  from market WHERE user = ?1 AND ?2 >= endtime AND stage != '失敗結案' AND stage != '成功結案' AND stage != '提交主管'", nativeQuery = true)
    List<MarketBean> getEndCast(String name,String day);
    @Query(value = "SELECT  *  from market WHERE  stage = '提交主管'", nativeQuery = true)
    List<MarketBean> getSubmitBos();

    boolean existsByCustomerid(String customerid);

    @Query(value = "SELECT  *  from market WHERE user = ?1  AND stage != '失敗結案' AND stage != '成功結案' ORDER BY aaa DESC", nativeQuery = true)
    List<MarketBean> findUser(String name);

    @Query(value = "select count(name) from(        SELECT company as name FROM `potentialcustomer` WHERE `aaa` BETWEEN ?1 AND ?2 AND user =?3 \n" +
            "UNION\n" +
            "SELECT client as name FROM `market` WHERE `aaa` BETWEEN ?1 AND ?2 AND  user =?3) AS c", nativeQuery = true)
    Integer getAminCastNum(String startDay, String endDay, String name);

    @Query(value = "SELECT  *  from market WHERE aaa BETWEEN ?1 AND ?2 ORDER BY aaa DESC", nativeQuery = true)
    List<MarketBean> findAaa(String startTime, String endTime);

    List<MarketBean> findByCallbos(String s);
///////////////////selectMarketByAll
    List<MarketBean> findByUserAndAaaBetween(String user, String startDay, String endDay,Sort sort);

    List<MarketBean> findByNameLikeIgnoreCaseAndAaaBetween(String s, String startDay, String endDay,Sort sort);

    List<MarketBean> findByContactphoneLikeIgnoreCaseAndAaaBetween(String s, String startDay, String endDay,Sort sort);

    List<MarketBean> findByStageAndAaaBetween(String Stage, String startDay, String endDay,Sort sort);

    List<MarketBean> findByContactnameLikeIgnoreCaseAndAaaBetween(String s, String startDay, String endDay,Sort sort);

    List<MarketBean> findByTypeAndAaaBetween(String type, String startDay, String endDay, Sort sort);

    List<MarketBean> findBySourceAndAaaBetween(String source, String startDay, String endDay, Sort sort);

    List<MarketBean> findByClinchAndAaaBetween(Integer s, String startDay, String endDay, Sort sort);

    List<MarketBean> findByProducttypeAndAaaBetween(String producttype, String startDay, String endDay, Sort sort);

    List<MarketBean>findByProductLikeIgnoreCaseOrNameLikeIgnoreCaseOrMessageLikeIgnoreCaseAndAaaBetween(String s, String s1, String s2, String startDay, String endDay, Sort sort);

    List<MarketBean> findByNameLikeIgnoreCaseOrClientLikeIgnoreCaseAndAaaBetween(String s, String s1, String startDay, String endDay, Sort sort);

    List<MarketBean> findByCallhelpAndStageNotAndStageNot(String s, String 失敗結案, String 成功結案);

    MarketBean findByCustomerid(String customerid);



    List<MarketBean> findByQuoteLikeIgnoreCaseAndAaaBetween(String s, String startDay, String endDay, Sort sort);
    ///////////////////selectMarketByAll
    List<MarketBean> findByUser(String s);


    boolean existsByFileforeignid(String fileforeignid);

    @Query(value = "SELECT  COUNT(*)  from market WHERE  producttype = ?1 AND   aaa BETWEEN ?2 AND ?3 ", nativeQuery = true)
    Integer getProductTypeNum(String name, String startDay, String endDay);
    @Query(value = "SELECT  COUNT(*)  from market WHERE user = ?1 AND stage = ?2 AND   aaa BETWEEN ?3 AND ?4 ", nativeQuery = true)
    Integer getAminStateNum(String admin,String state, String startDay, String endDay);


}
