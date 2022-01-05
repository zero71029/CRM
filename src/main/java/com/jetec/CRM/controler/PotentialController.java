package com.jetec.CRM.controler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.model.PotentialCustomerBean;

@Controller
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

}
