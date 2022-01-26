package com.jetec.CRM.controler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jetec.CRM.controler.service.ClientService;
import com.jetec.CRM.controler.service.MarketService;
import com.jetec.CRM.controler.service.PotentialCustomerService;
import com.jetec.CRM.controler.service.WorkSerivce;
import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.WorkBean;

@Controller
@RequestMapping("/work")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')")
public class WorkControler {
	@Autowired
	WorkSerivce ws;
	@Autowired
	ClientService cs;
	@Autowired
	PotentialCustomerService pcs;
	@Autowired
	MarketService ms;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存工作項目
	@RequestMapping("/SaveWork")
	public String SaveWork(WorkBean worKBean) {
		System.out.println("存工作項目");
		System.out.println(worKBean);
		WorkBean save = ws.SaveWork(worKBean);
		return "redirect:/work/detail/" + save.getWorkid();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表
	@RequestMapping("/workList")
	public String workList(Model model) {
		model.addAttribute("list", ws.getList());
		return "/Market/workList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表(結案)
	@RequestMapping("/closed")
	public String closed(Model model) {
		model.addAttribute("list", ws.closed());
		return "/Market/workList";
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//工作項目列表
//
//	@RequestMapping("/ClseWork")
//	public String ClseWork(Model model) {
//		model.addAttribute("list", ws.getList());
//		return "/Market/workList";
//	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 讀取工作項目細節
	@RequestMapping("/detail/{id}")
	public String detail(Model model, @PathVariable("id") Integer id) {
		System.out.println("*****讀取工作項目細節****");
		if (id == 0) {
//			model.addAttribute("bean", new PotentialCustomerBean());
		} else {
			model.addAttribute("bean", ws.getById(id));
		}
		model.addAttribute("clientList", cs.getList());
		return "/Market/work";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表
	@RequestMapping("/clientList")
	@ResponseBody
	public List<ClientBean> clientList() {
		return cs.getList();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表by clientid
	@RequestMapping("/contactList/{clientid}")
	@ResponseBody
	public List<ContactBean> contactList(@PathVariable("clientid") Integer clientid) {
		return ws.getContactList(clientid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索客戶
	@RequestMapping("/selectclient/{name}")
	@ResponseBody
	public List<ClientBean> selectclient(@PathVariable("name") String name) {
		System.out.println("搜索客戶");
		return cs.selectclient(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索聯絡人
	@RequestMapping("/selectContact/{name}")
	@ResponseBody
	public List<ContactBean> selectContact(@PathVariable("name") String name) {
		System.out.println("*****搜索聯絡人****");
		System.out.println(name);
		System.out.println(cs.selectContactByClientName(name));
		return cs.selectContactByClientName(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索潛在顧客
	@RequestMapping("/selectCustomer/{name}")
	@ResponseBody
	public List<PotentialCustomerBean> selectCustomer(@PathVariable("name") String name) {
		System.out.println("搜索潛在顧客");
		return pcs.selectPotentialCustomer(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會
	@RequestMapping("/selectMarket/{name}")
	@ResponseBody
	public List<MarketBean> selectMarket(@PathVariable("name") String name) {
		System.out.println("搜索銷售機會");
		return ms.selectMarket(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除工作項目
	@RequestMapping("/delWork")
	@ResponseBody
	public String delMarket(@RequestParam("id") List<Integer> id) {
		System.out.println("*****刪除工作項目*****");
		ws.delWorkt(id);
		return "刪除成功";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索工作項目
	@RequestMapping("/selectWork")
	public String selectWork(Model model, @RequestParam("name") String name) {
		System.out.println("搜索工作項目");
		name = name.trim();
		model.addAttribute("list", ws.sekectWork(name));
		return "/Market/workList";
	}
}
