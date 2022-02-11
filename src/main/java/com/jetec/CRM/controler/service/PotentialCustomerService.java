package com.jetec.CRM.controler.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.PotentialCustomerHelperBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.model.TrackRemarkBean;
import com.jetec.CRM.repository.AdminRepository;
import com.jetec.CRM.repository.PotentialCustomerHelperRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import com.jetec.CRM.repository.TrackRemarkRepository;
import com.jetec.CRM.repository.TrackRepository;

@Service
@Transactional
public class PotentialCustomerService {

	@Autowired
	AdminRepository ar;
	@Autowired
	PotentialCustomerRepository PCR;
	@Autowired
	TrackRepository tr;
	@Autowired
	PotentialCustomerHelperRepository pchr;
	@Autowired
	TrackRemarkRepository trr;	
	@Autowired
	ZeroTools zTools;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存潛在客戶列表
	public PotentialCustomerBean SavePotentialCustomer(PotentialCustomerBean pcb) {
		return PCR.save(pcb);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
	public List<PotentialCustomerBean> getList(Integer pag) {

		Pageable p = (Pageable) PageRequest.of(pag, 20);
		Page<PotentialCustomerBean> page = (Page<PotentialCustomerBean>) PCR.findStatus(p);
//		全部有幾頁
//		page.getTotalPages();
		List<PotentialCustomerBean> result = page.getContent();
		return result;
	}

	public PotentialCustomerBean getById(String id) {
		return PCR.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//要求最大分頁數
	public long getMaxPag() {
		Pageable p = (Pageable) PageRequest.of(0, 20);
		Page<PotentialCustomerBean> page = (Page<PotentialCustomerBean>) PCR.findStatus(p);
//		全部有幾頁		
		return page.getTotalElements();//全部幾筆
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表(結案)
	public List<PotentialCustomerBean> closed() {
		List<PotentialCustomerBean> result = PCR.findByStatus("不合格");
		result.addAll(PCR.findByStatus("合格"));
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除潛在客戶
	public void delPotentialCustomer(List<String> id) {
		for (String i : id) {
			tr.deleteByCustomerid(i);
			PCR.deleteById(i);
		}

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶
	public List<PotentialCustomerBean> selectPotentialCustomer(String name) {
		List<PotentialCustomerBean> result = new ArrayList<PotentialCustomerBean>();
		boolean boo = true;
// 搜索名稱
		for (PotentialCustomerBean p : PCR.findByNameLikeIgnoreCase("%" + name + "%")) {
			result.add(p);
		}

// 用業務搜索
		for (PotentialCustomerBean p : PCR.findByUserLikeIgnoreCase("%" + name + "%")) {
			for (PotentialCustomerBean bean : result) {
				if (bean.getCustomerid() == p.getCustomerid()) {
					boo = false;
				}
			}
			if (boo)
				result.add(p);
			boo = true;
		}
// 用公司搜索
		for (PotentialCustomerBean p : PCR.findByCompanyLikeIgnoreCase("%" + name + "%")) {
			for (PotentialCustomerBean bean : result) {
				if (bean.getCustomerid() == p.getCustomerid()) {
					boo = false;
				}
			}
			if (boo)
				result.add(p);
			boo = true;
		}

		return result;

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索創造日期
	public List<PotentialCustomerBean> selectDate(Date formDate, Date toDate) {
		return PCR.findCreatetime(formDate, toDate);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by狀態
	public List<PotentialCustomerBean> selectStatus(String status) {
		// TODO Auto-generated method stub
		return PCR.findByStatus(status);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by來源
	public List<PotentialCustomerBean> selectSource(String source) {
		return PCR.findBySource(source);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by產業
	public List<PotentialCustomerBean> selectIndustry(String industry) {
		return PCR.findByIndustry(industry);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//添加協助者
	public List<PotentialCustomerHelperBean> addHelper(String customerid, String helper) {
		PotentialCustomerBean pcBean = PCR.getById(customerid);
		for (PotentialCustomerHelperBean helperBean : pcBean.getHelper()) {
			if (helperBean.getName().equals(helper)) {
				return pcBean.getHelper();
			}
		}
		if (pcBean.getUser().equals(helper)) { 
			return pcBean.getHelper();
		}
		PotentialCustomerHelperBean newBean = new PotentialCustomerHelperBean();
		newBean.setHelperid(zTools.getUUID());
		newBean.setCustomerid(customerid);
		newBean.setName(helper);
		newBean.setAdminid(ar.findByName(helper).getAdminid());
		pchr.save(newBean);
		System.out.println(pchr.findByCustomerid(customerid));
		return pchr.findByCustomerid(customerid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
	public List<PotentialCustomerHelperBean> delHelper(String customerid, String helperid) {
		System.out.println(helperid);
		pchr.deleteById(helperid);

		System.out.println(pchr.findByCustomerid(customerid));
		return pchr.findByCustomerid(customerid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在客戶by追蹤時間
	public List<PotentialCustomerBean> selectPotentialCustomerTrack(String from, String to) {

//		Sort sort = Sort.by(Direction.DESC,"trackbean.tracktime");

		return PCR.findByTrackbeanTracktimeBetween(from, to);
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//回覆追蹤資訊
	public List<TrackBean> saveTrackRemark(String trackid, String content,String name) {
		TrackRemarkBean trbean = new TrackRemarkBean();
		trbean.setName(name);
		trbean.setTrackid(trackid);
		trbean.setContent(content);
		trbean.setTrackremarkid(zTools.getUUID());
		Date date = new Date();
		trbean.setCreatetime(zTools.getTime(date));
		 trr.save(trbean);	
		 Sort sort = Sort.by(Direction.DESC,"tracktime");
		//trackid取得TrackBean , TrackBean取得Customerid ,Customerid取得 List<TrackBean>
		return tr.findByCustomerid(tr.getById(trackid).getCustomerid(),sort) ;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤資訊
	public String removeTrack(String trackid) {
		String Customerid = tr.getById(trackid).getCustomerid(); 
		tr.deleteById(trackid);
		return Customerid;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除追蹤回覆
	public void removeTrackremark(String trackremarkid) {
		trr.deleteById(trackremarkid);
		
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取追蹤資訊
	public List<TrackBean> getTrackByCustomerid(String customerid) {	
		Sort sort = Sort.by(Direction.DESC,"tracktime");
		return tr.findByCustomerid(customerid,sort);
	}


}
