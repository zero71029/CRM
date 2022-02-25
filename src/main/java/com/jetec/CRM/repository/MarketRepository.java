package com.jetec.CRM.repository;

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

    @Query(value = "SELECT  *  from market where stage != '失敗結案' AND stage != '成功結案' AND(aaa BETWEEN ?1 AND ?2 )", nativeQuery = true)
    List<MarketBean> findAaa(String startTime, String endTime);

    @Query(value = "SELECT  COUNT(*)  from market where aaa BETWEEN ?1 AND ?2  ", nativeQuery = true)
    Integer gettodayTotal(String s, String s1);
}
