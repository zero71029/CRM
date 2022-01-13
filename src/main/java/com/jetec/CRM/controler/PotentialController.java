package com.jetec.CRM.controler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.PotentialCustomerHelperBean;

@Controller
@ResponseBody
@RequestMapping("/Potential")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')")
public class PotentialController {

	@Autowired
	PotentialCustomerService PCS;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
	@RequestMapping("/CustomerList")
	@ResponseBody
	public List<PotentialCustomerBean> clientList() {
		System.out.println("*****讀取潛在客戶列表*****");
		return PCS.getList();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表(結案)
	@RequestMapping("/closed")
	@ResponseBody
	public List<PotentialCustomerBean> closed() {
		System.out.println("*****讀取潛在客戶列表*****");
		return PCS.closed();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索潛在客戶by負責人
	@RequestMapping("/admin/{name}")
	@ResponseBody
	public List<PotentialCustomerBean> selectAdmin(@PathVariable("name") String name) {
		System.out.println("搜索潛在客戶");
		name.trim();
		return PCS.selectPotentialCustomer(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索日期
	@RequestMapping("/selectDate")
	public List<PotentialCustomerBean> selectDate(@RequestParam("from") String from, @RequestParam("to") String to) {
		System.out.println("搜索銷售機會 日期");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
// 設定日期格式
		if (from.equals("")) {
			from = "2020-11-30";
		}
		if (to.equals("")) {
			to = sdf.format(new Date());
		} else {
			to = to + " 23:59:59";
		}
		from = from + " 00:00:00";
// 進行轉換
		Date formDate;
		Date toDate;
		try {
			formDate = sdf.parse(from);
			toDate = sdf.parse(to);
			return PCS.selectDate(formDate, toDate);
		} catch (ParseException e) {

		}
		return null;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by狀態
	@RequestMapping("/status/{status}")
	public List<PotentialCustomerBean> selectStatus(@PathVariable("status") String status) {
		System.out.println("搜索潛在客戶");
		return PCS.selectStatus(status);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 搜索潛在客戶by來源
	@SuppressWarnings("unchecked")
	@RequestMapping("/selectSource")
	public List<PotentialCustomerBean> selectSource(@RequestBody Map<String, Object> data) {
		System.out.println("搜索潛在客戶by來源");
		List<PotentialCustomerBean> result = new ArrayList<PotentialCustomerBean>();
		for (String source : (List<String>) data.get("source")) {

			result.addAll(PCS.selectSource(source));
			result.addAll(PCS.selectIndustry(source));
		}
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//添加協助者
	@RequestMapping("/addHelper/{customerid}/{helper}")
	public List<PotentialCustomerHelperBean> addHelper(@PathVariable("customerid") Integer customerid,
			@PathVariable("helper") String helper) {
		System.out.println("添加協助者");
		return PCS.addHelper(customerid, helper);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
	@RequestMapping("/delHelper/{customerid}/{helper}")
	public List<PotentialCustomerHelperBean> delHelper(@PathVariable("customerid") Integer customerid,
			@PathVariable("helper") String helperid) {
		System.out.println("刪除協助者");
		return PCS.delHelper(customerid, helperid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by追蹤時間
	@RequestMapping("/selectTrackDate")
	@ResponseBody
	public List<PotentialCustomerBean> selectTrackDate(@RequestParam("from") String from,
			@RequestParam("to") String to) {
		System.out.println("搜索潛在客戶by追蹤時間");
		List<PotentialCustomerBean> list = PCS.selectPotentialCustomerTrack(from, to);
		LinkedHashSet<PotentialCustomerBean> hashSet = new LinkedHashSet<PotentialCustomerBean>(list);
		List<PotentialCustomerBean> result = new ArrayList<PotentialCustomerBean>(hashSet);
		return result;
	}
}
