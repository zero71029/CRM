package com.jetec.CRM.controler.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.PotentialCustomerHelperBean;
import com.jetec.CRM.repository.AdminRepository;
import com.jetec.CRM.repository.PotentialCustomerHelperRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
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
	ZeroTools zTools;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存潛在客戶列表
	public void SavePotentialCustomer(PotentialCustomerBean pcb) {
		PCR.save(pcb);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
	public List<PotentialCustomerBean> getList() {
		List<PotentialCustomerBean> result = PCR.findByStatus("未處理");
		result.addAll(PCR.findByStatus("已聯繫"));
		return result;
	}

	public PotentialCustomerBean getById(Integer id) {
		return PCR.getById(id);
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
	public void delPotentialCustomer(List<Integer> id) {
		for (Integer i : id) {
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
			if (boo)result.add(p);
			boo = true;
		}
// 用公司搜索
		for (PotentialCustomerBean p : PCR.findByCompanyLikeIgnoreCase("%" + name + "%")) {
			for (PotentialCustomerBean bean : result) {
				if (bean.getCustomerid() == p.getCustomerid()) {
					boo = false;
				}
			}
			if (boo)result.add(p);
			boo = true;
		}

		return result;

	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索創造日期
	public List<PotentialCustomerBean> selectDate(Date formDate, Date toDate) {
		return PCR.findCreatetime(formDate,toDate);
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
	public List<PotentialCustomerHelperBean> addHelper(Integer customerid, String helper) {		
		PotentialCustomerBean pcBean = PCR.getById(customerid);
		for(PotentialCustomerHelperBean helperBean : pcBean.getHelper()) {
			if(helperBean.getName().equals(helper)) {
				return pcBean.getHelper();
			}
		}
		if(pcBean.getUser().equals(helper)) {
			return pcBean.getHelper();
		}
		PotentialCustomerHelperBean newBean = new PotentialCustomerHelperBean();
		newBean.setHelperid(zTools.getUUID());
		newBean.setCustomerid(customerid);
		newBean.setName(helper);
		newBean.setAdminid(ar.findByName(helper).getAdminid());	
		pchr.save(newBean);
		
		
		return PCR.getById(customerid).getHelper();
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除協助者
	public List<PotentialCustomerHelperBean> delHelper(Integer customerid, String helperid) {
		pchr.deleteById(helperid);
		return PCR.getById(customerid).getHelper();
	}

}