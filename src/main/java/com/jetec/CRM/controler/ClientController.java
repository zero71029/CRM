package com.jetec.CRM.controler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.model.ClientTagBean;

@Controller
@ResponseBody
@RequestMapping("/client")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')OR hasAuthority('行銷')")
public class ClientController {

	@Autowired
	ClientService CS;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取標籤列表
	@RequestMapping("/getTag/{clientid}")
	public List<ClientTagBean> getTagList(@PathVariable("clientid") Integer clientid) {
		System.out.println("*****讀取標籤列表*****");
		return CS.getTagList(clientid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除標籤
	@RequestMapping("/removeTag/{clientid}/{clienttagid}")
	public List<ClientTagBean> removeTag(@PathVariable("clienttagid") String clienttagid,
			@PathVariable("clientid") Integer clientid) {
		System.out.println("***刪除標籤***");
		CS.removeTag(clienttagid);
		return CS.getTagList(clientid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增標籤
	@RequestMapping("/addTag/{clientid}/{tagName}")
	public List<ClientTagBean> tag(@PathVariable("tagName") String tagName,
			@PathVariable("clientid") Integer clientid) {
		System.out.println("***新增標籤***");
		CS.saveTag(tagName, clientid);
		
		
		
		
		return CS.getTagList(clientid);
	}


}
