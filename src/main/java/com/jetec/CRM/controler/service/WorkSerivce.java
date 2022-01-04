package com.jetec.CRM.controler.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.WorkBean;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import com.jetec.CRM.repository.WorKRepository;

@Service
@Transactional
public class WorkSerivce {
	@Autowired
	MarketRepository mr;
	@Autowired
	WorKRepository wr;
	@Autowired
	PotentialCustomerRepository pcr;
	@Autowired
	ContactRepository cr;
	@Autowired
	ClientRepository clientRepository;
	@Autowired
	ContactRepository contactRepository;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存工作項目
	public WorkBean SaveWork(WorkBean worKBean) {
		return wr.save(worKBean);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表
	public List<WorkBean> getList() {
		Sort sort = Sort.by(Direction.DESC, "workid");
		List<WorkBean> result =	 wr.findByState("尚未處理",sort);
		result.addAll(wr.findByState("需求確認",sort));
		result.addAll(wr.findByState("聯繫中",sort));
		result.addAll(wr.findByState("處理中",sort));
		result.addAll(wr.findByState("已報價",sort));
		return result;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表
	public List<WorkBean> closed() {
		Sort sort = Sort.by(Direction.DESC, "workid");
		List<WorkBean> result =	 wr.findByState("成功結案",sort);
		result.addAll(wr.findByState("失敗結案",sort));
		return result;
	}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取工作項目細節
	public WorkBean getById(Integer id) {
		// TODO Auto-generated method stub
		return wr.getById(id);
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除工作項目
	public void delWorkt(List<Integer> id) {
		for (Integer i : id) {
			wr.deleteById(i);
		}
		
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表by   clientid
	public List<ContactBean> getContactList(Integer clientid) {		
		return cr.findByClientid(clientid);
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索工作項目
	public List<WorkBean> sekectWork(String name) {
		List<WorkBean> result = new ArrayList<WorkBean>();
		boolean boo = true;
		//搜索主題
		for (WorkBean p : wr.findByNameLikeIgnoreCase("%" + name + "%")) {
			result.add(p);
		}
		//搜索負責人
		for (WorkBean p : wr.findByUserLikeIgnoreCase("%" + name + "%")) {
			for (WorkBean bean : result) {
				if (bean.getWorkid() == p.getWorkid()) {
					boo = false;
				}
			}
			if (boo)result.add(p);
		}
		//搜索客戶
		Integer clientid =	clientRepository.selectIdByname(name);
		for (WorkBean p : wr.findByClientid(clientid)) {
			for (WorkBean bean : result) {
				if (bean.getWorkid() == p.getWorkid()) {
					boo = false;
				}
			}
			if (boo)result.add(p);
		}
		//搜索聯絡人
		clientid = contactRepository.selectIdByname(name);
		for (WorkBean p : wr.findByContactid(clientid)) {
			for (WorkBean bean : result) {
				if (bean.getWorkid() == p.getWorkid()) {
					boo = false;
				}
			}
			if (boo)result.add(p);
		}
		
		
		return result;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得工作項目
	public List<WorkBean> workitem(String adminname) {
		List<WorkBean> result = wr.findByUserAndState(adminname,"尚未處理");
		result.addAll(wr.findByUserAndState(adminname,"需求確認"));
		result.addAll(wr.findByUserAndState(adminname,"聯繫中"));
		result.addAll(wr.findByUserAndState(adminname,"處理中"));
		result.addAll(wr.findByUserAndState(adminname,"已報價"));
		return result;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得工作項目
	public List<MarketBean> marketitem(String adminname) {
		List<MarketBean> result =mr.findByUserAndStage(adminname,"需求確認");
		result.addAll(mr.findByUserAndStage(adminname,"尚未處理"));
		result.addAll(mr.findByUserAndStage(adminname,"聯繫中"));
		result.addAll(mr.findByUserAndStage(adminname,"處理中"));
		result.addAll(mr.findByUserAndStage(adminname,"已報價"));
		return result;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得銷售機會
	public List<PotentialCustomerBean> PotentialItem(String adminname) {
		List<PotentialCustomerBean> result = pcr.findByUserAndStatus(adminname,"未處理");		
		result.addAll(pcr.findByUserAndStatus(adminname,"已聯繫"));
		return result;
	}


}
