package com.jetec.CRM.controler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.PotentialCustomerHelperBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.repository.TrackRepository;

@Controller
@ResponseBody
@RequestMapping("/Potential")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class PotentialController {

	@Autowired
	PotentialCustomerService PCS;
	@Autowired
	TrackRepository tr;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
	@RequestMapping("/CustomerList")
	public List<PotentialCustomerBean> clientList(@RequestParam("pag") Integer pag) {
		System.out.println("*****讀取潛在客戶列表*****");
		pag--;
		return PCS.getList(pag);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 所有筆數
	@RequestMapping("/MaxPag")
	public long MaxPag() {
		return PCS.getMaxPag();
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
	public List<PotentialCustomerHelperBean> addHelper(@PathVariable("customerid") String customerid,
			@PathVariable("helper") String helper) {
		System.out.println("添加協助者");
		return PCS.addHelper(customerid, helper);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
	@RequestMapping("/delHelper/{customerid}/{helper}")
	public List<PotentialCustomerHelperBean> delHelper(@PathVariable("customerid") String customerid,
			@PathVariable("helper") String helperid) {
		System.out.println("刪除協助者");
		return PCS.delHelper(customerid, helperid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by追蹤時間
	@RequestMapping("/selectTrackDate")
	public List<PotentialCustomerBean> selectTrackDate(@RequestParam("from") String from,
			@RequestParam("to") String to) {
		System.out.println("搜索潛在客戶by追蹤時間");
		List<PotentialCustomerBean> list = PCS.selectPotentialCustomerTrack(from, to);
		LinkedHashSet<PotentialCustomerBean> hashSet = new LinkedHashSet<PotentialCustomerBean>(list);
		List<PotentialCustomerBean> result = new ArrayList<PotentialCustomerBean>(hashSet);
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取追蹤資訊
	@RequestMapping("/client/{customerid}")
	public List<TrackBean> client(@PathVariable("customerid") String customerid) {
		return PCS.getTrackByCustomerid(customerid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存回覆追蹤資訊
	@RequestMapping("/saveTrackRemark/{trackid}/{content}")
	public List<TrackBean> saveTrackRemark(@PathVariable("trackid") String trackid, @PathVariable("content") String content,HttpSession session) {
		System.out.println("存回覆追蹤資訊");
		AdminBean aBean = (AdminBean) session.getAttribute("user");
		return PCS.saveTrackRemark(trackid, content,aBean.getName());
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤資訊
	@RequestMapping("/removeTrack/{trackid}")
	public List<TrackBean> removeTrack(@PathVariable("trackid") String trackid) {
		System.out.println("刪除追蹤資訊");
		String customerid = PCS.removeTrack(trackid);		
		return PCS.getTrackByCustomerid(customerid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤回覆
	@RequestMapping("/removeTrackremark/{trackremarkid}/{trackid}")
	public List<TrackBean> removeTrackremark(@PathVariable("trackremarkid") String trackremarkid,@PathVariable("trackid") String trackid) {
		System.out.println("刪除追蹤回覆");
		PCS.removeTrackremark(trackremarkid);
		Sort sort = Sort.by(Direction.DESC,"tracktime");
		return tr.findByCustomerid(tr.getById(trackid).getCustomerid(),sort) ;
	}
}
