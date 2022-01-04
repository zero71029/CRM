package com.jetec.CRM.controler.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.repository.PotentialCustomerRepository;
import com.jetec.CRM.repository.TrackRepository;

@Service
@Transactional
public class PotentialCustomerService {

	@Autowired
	PotentialCustomerRepository PCR;
	@Autowired
	TrackRepository tr;

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
			if (boo)
				result.add(p);
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
		}

		return result;

	}

}
