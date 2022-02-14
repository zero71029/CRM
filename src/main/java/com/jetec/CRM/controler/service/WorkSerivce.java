package com.jetec.CRM.controler.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
	public Map<String, Object> getList(Integer pag) {
		Pageable p = (Pageable) PageRequest.of(pag, 20);
		Page<WorkBean> page = (Page<WorkBean>) wr.findStage(p);
//		List<WorkBean> result = page.getContent();		
		Map<String, Object> map = new HashMap<>();
		map.put("list", page.getContent());
		map.put("total", page.getTotalElements());

		return map;

//		ObjectMapper objectMapper = new ObjectMapper();	
//		try {
//			String json = objectMapper.writeValueAsString(page.getContent());
//			System.out.println(json);
//			JSONArray arr = new JSONArray(json);
//			System.out.println(arr);
//			JSONObject result= new JSONObject();
//			result.put("list", arr);
//			result.put("total", 5);
//			return result;
//			
//		} catch (JsonProcessingException e) {
//			 
//			e.printStackTrace();
//		}	
//		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表
	public List<WorkBean> closed() {
		Sort sort = Sort.by(Direction.DESC, "workid");
		List<WorkBean> result = wr.findByState("成功結案", sort);
		result.addAll(wr.findByState("失敗結案", sort));
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取工作項目細節
	public WorkBean getById(String id) {
		 
		return wr.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除工作項目
	public void delWorkt(List<String> id) {
		for (String i : id) {
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
	public Map<String, Object> sekectWork(String name, Integer pag) {
		Map<String, Object> map = new HashMap<>();
		Pageable p = (Pageable) PageRequest.of(pag, 20);
		List<WorkBean> result = new ArrayList<WorkBean>();
		boolean boo = true;
		// 搜索主題
		Page<WorkBean> page = (Page<WorkBean>) wr.findByNameLikeIgnoreCase("%" + name + "%", p);
		Long total = page.getTotalElements();
		for (WorkBean b : page.getContent()) {
			result.add(b);
		}
		// 搜索負責人	
		page = (Page<WorkBean>) wr.findByUserLikeIgnoreCase("%" + name + "%",p);		
		for (WorkBean b : page.getContent()) {
			for (WorkBean bean : result) {
				if (bean.getWorkid() == b.getWorkid()) {
					boo = false;
				}
			}
			if (boo) {
				result.add(b);
				total++;
			}
		}
		// 搜索客戶
		Integer clientid = clientRepository.selectIdByname(name);
		if (clientid != null) {
			page = (Page<WorkBean>) wr.findByClientid(clientid,p);	
			for (WorkBean b : page.getContent()) {
				for (WorkBean bean : result) {
					if (bean.getWorkid() == b.getWorkid()) {
						boo = false;
					}
				}
				System.out.println(p);
				if (boo)
					result.add(b);
			}
		}
		// 搜索聯絡人
		clientid = contactRepository.selectIdByname(name);
		if (clientid != null) {
			page = (Page<WorkBean>) wr.findByContactid(clientid,p);	
			for (WorkBean b : page.getContent()) {
				for (WorkBean bean : result) {
					if (bean.getWorkid() == b.getWorkid()) {
						boo = false;
					}
				}
				if (boo)
					result.add(b);
			}
		}
		map.put("list", result);
		map.put("total", page.getTotalElements());

		return map;
		
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得工作項目
	public List<WorkBean> workitem(String adminname) {
		List<WorkBean> result = wr.findByUserAndState(adminname, "尚未處理");
		result.addAll(wr.findByUserAndState(adminname, "需求確認"));
		result.addAll(wr.findByUserAndState(adminname, "聯繫中"));
		result.addAll(wr.findByUserAndState(adminname, "處理中"));
		result.addAll(wr.findByUserAndState(adminname, "已報價"));
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得工作項目
	public List<MarketBean> marketitem(String adminname) {
		List<MarketBean> result = mr.findByUserAndStage(adminname, "需求確認");
		result.addAll(mr.findByUserAndStage(adminname, "尚未處理"));
		result.addAll(mr.findByUserAndStage(adminname, "聯繫中"));
		result.addAll(mr.findByUserAndStage(adminname, "處理中"));
		result.addAll(mr.findByUserAndStage(adminname, "已報價"));
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//取得銷售機會
	public List<PotentialCustomerBean> PotentialItem(String adminname) {
		List<PotentialCustomerBean> result = pcr.findByUserAndStatus(adminname, "未處理");
		result.addAll(pcr.findByUserAndStatus(adminname, "已聯繫"));
		return result;
	}

}
