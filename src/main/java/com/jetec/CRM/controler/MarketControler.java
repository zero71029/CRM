package com.jetec.CRM.controler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.jetec.CRM.model.AgreementBean;
import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.MarketRemarkBean;
import com.jetec.CRM.model.PotentialCustomerBean;
import com.jetec.CRM.model.QuotationBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.model.WorkBean;
import com.jetec.CRM.repository.AdminRepository;

@Controller
@RequestMapping("/Market")
@PreAuthorize("hasAuthority('系統') OR hasAuthority('主管') OR hasAuthority('業務')")
public class MarketControler {
	@Autowired
	MarketService ms;
	@Autowired
	PotentialCustomerService PCS;
	@Autowired
	ClientService cs;
	@Autowired
	AdminRepository ar;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/SavePotentialCustomer")
	public String SavePotentialCustomer(PotentialCustomerBean pcb) {
		System.out.println("*****儲存潛在客戶*****");
		System.out.println(pcb);
		PCS.SavePotentialCustomer(pcb);
		return "redirect:/Market/PotentialCustomerList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表
	@RequestMapping("/PotentialCustomerList")
	public String clientList(Model model) {
		System.out.println("*****讀取潛在客戶列表*****");
		model.addAttribute("list", PCS.getList());
		return "/Market/potentialcustomerList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取潛在客戶列表(結案)
	@RequestMapping("/closed")
	public String closed(Model model) {
		System.out.println("*****讀取潛在客戶列表*****");
		model.addAttribute("list", PCS.closed());
		return "/Market/potentialcustomerList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	讀取潛在客戶細節
	@RequestMapping("/potentialcustomer/{id}")
	public String potentialcustomer(Model model, @PathVariable("id") Integer id) {
		System.out.println("*****讀取潛在客戶細節****");
		if (id == 0) {
//			model.addAttribute("bean", new PotentialCustomerBean());
		} else {
			model.addAttribute("bean", PCS.getById(id));
		}
//		model.addAttribute("admin", ar.findAll());

		return "/Market/potentialcustomer";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表
	@RequestMapping("/MarketList")
	public String Market(Model model) {
		model.addAttribute("list", ms.getList());
		return "/Market/MarketList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表(結案)
	@RequestMapping("/CloseMarket")
	public String CloseMarket(Model model) {
		model.addAttribute("list", ms.CloseMarket());
		return "/Market/MarketList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 存銷售機會
	@RequestMapping("/SaveMarket")
	public String SaveMarket(MarketBean marketBean) {
		System.out.println(marketBean);
		ms.save(marketBean);
		return "redirect:/Market/MarketList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping("/Market/{id}")
	public String Market(Model model, @PathVariable("id") Integer id) {
		model.addAttribute("bean", ms.getById(id));
		return "/Market/Market";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存備註
	@RequestMapping("/SaveRemark")
	public String SaveRemark(MarketRemarkBean mrb) {
		System.out.println("存備註");
		ms.SaveRemark(mrb);
		return "redirect:/Market/Market/" + mrb.getMarketid();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除銷售機會
	@RequestMapping("/delMarket")
	@ResponseBody
	public String delMarket(@RequestParam("id") List<Integer> id) {
		System.out.println("*****刪除銷售機會*****");
		ms.delMarket(id);
		return "刪除成功";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索銷售機會
	@RequestMapping("/selectMarket")
	public String selectMarket(Model model, @RequestParam("name") String name) {
		System.out.println("搜索銷售機會");
		model.addAttribute("list", ms.selectMarket(name));
		return "/Market/MarketList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除備註
	@RequestMapping("/delRemark/{remarkId}/{MarketId}")
	public String delRemark(@PathVariable("remarkId") Integer remarkId, @PathVariable("MarketId") Integer MarketId) {
		System.out.println("*****刪除備註*****");
		ms.delRemark(remarkId);
		return "redirect:/Market/Market/" + MarketId;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤	
	@RequestMapping("/SaveTrack")
	public String SaveTrack(TrackBean trackBean) {
		System.out.println("存追蹤");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
		trackBean.setTracktime(sdf.format(date));
		ms.SaveTrack(trackBean);
		return "redirect:/Market/potentialcustomer/" + trackBean.getCustomerid();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除潛在客戶
	@RequestMapping("/delPotentialCustomer")
	@ResponseBody
	public String delPotentialCustomer(@RequestParam("id") List<Integer> id) {
		System.out.println("*****刪除潛在客戶*****");
		System.out.println(id.toString());
		PCS.delPotentialCustomer(id);
		return "刪除成功";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 搜索潛在客戶
	@RequestMapping("/selectPotentialCustomer")
	public String selectPotentialCustomer(Model model, @RequestParam("name") String name) {
		System.out.println("搜索潛在客戶");
		model.addAttribute("list", PCS.selectPotentialCustomer(name));
		return "/Market/potentialcustomerList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//轉成報價單
	@RequestMapping("/goQuotation.action")
	public String goQuotation(MarketBean marketBean, Model model) {
		System.out.println(marketBean);
		QuotationBean qBean = new QuotationBean();
		qBean.setName(marketBean.getClient());
		qBean.setPhone(marketBean.getContactphone());
		qBean.setContactname(marketBean.getContactname());
		qBean.setContactmoblie(marketBean.getContactmoblie());
		qBean.setRemark(marketBean.getMessage());
		qBean.setUser(marketBean.getUser());
		model.addAttribute("bean", qBean);
		return "/Market/Quotation";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存報價單
	@RequestMapping("/SaveQuotation")
	public String SaveQuotation(QuotationBean qBean) {
		System.out.println("存報價單");
		System.out.println(qBean);
		System.out.println(qBean.getQdb());

		QuotationBean save = ms.SaveQuotation(qBean);
		return "redirect:/Market/Quotation/" + save.getQuotationid();
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取報價單細節
	@RequestMapping("/Quotation/{id}")
	public String Quotation(Model model, @PathVariable("id") Integer id) {
		System.out.println("*****讀取報價單細節****");

		if (id == 0) {
			model.addAttribute("bean", new QuotationBean());
		} else {
			QuotationBean qBean = ms.getQuotationById(id);
			model.addAttribute("bean", qBean);
			model.addAttribute("contact", cs.selectContactByClientName(qBean.getName()));// 讀取聯絡人by客戶
		}
//model.addAttribute("admin", ar.findAll());

		return "/Market/Quotation";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//報價單列表
	@RequestMapping("/QuotationList")
	public String QuotationList(Model model) {
		model.addAttribute("list", ms.getQuotationList());
		return "/Market/QuotationList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存合約	
	@RequestMapping("/SaveAgreement")
	public String SaveAgreement(AgreementBean aBean) {
		System.out.println("存合約");
		System.out.println(aBean);
		ms.SaveAgreement(aBean);
		return "redirect:/Market/Agreement/1";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取合約細節
	@RequestMapping("/Agreement/{id}")
	public String Agreement(Model model, @PathVariable("id") Integer id) {
		System.out.println("*****讀取合約細節****");

		if (id == 0) {
			model.addAttribute("bean", new AgreementBean());
		} else {
			model.addAttribute("bean", ms.getAgreementBeanById(id));

		}
//model.addAttribute("admin", ar.findAll());

		return "/Market/agreement";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//判斷客戶存在
	@RequestMapping("/existsClient")
	@ResponseBody
	public String existsClient(PotentialCustomerBean Bean, Model model) {
		System.out.println("*****判斷客戶存在****");
		if (cs.existsByName(Bean.getCompany())) {
			return "客戶已存在";
		}
		return "不存在";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶轉成客戶
	@RequestMapping("/changeClient.action")
	public String changeClient(PotentialCustomerBean Bean, Model model) {
		System.out.println("*****潛在各戶轉成客戶****");
		ClientBean clientBean = new ClientBean();
		clientBean.setName(Bean.getCompany());
		clientBean.setPhone(Bean.getPhone());
		clientBean.setIndustry(Bean.getIndustry());
		clientBean.setEmail(Bean.getEmail());
		clientBean.setFax(Bean.getFax());
		clientBean.setRemark(Bean.getRemark());
		clientBean.setBillcity(Bean.getCity());
		clientBean.setBilltown(Bean.getTown());
		clientBean.setBillpostal(Bean.getPostal());
		clientBean.setBilladdress(Bean.getAddress());
		clientBean.setDelivercity(Bean.getCity());
		clientBean.setDelivertown(Bean.getTown());
		clientBean.setDeliverpostal(Bean.getPostal());
		clientBean.setDeliveraddress(Bean.getAddress());
		clientBean.setState(1);
		System.out.println(clientBean);
		ClientBean saveBean = cs.SaveAdmin(clientBean);

		model.addAttribute("message", "儲存成功");
		model.addAttribute("bean", saveBean);
		return "/client/client";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//判斷客戶存在
	@RequestMapping("/existsContact")
	@ResponseBody
	public String existsContact(PotentialCustomerBean Bean, Model model) {
		System.out.println("*****判斷客戶存在****");
		if (cs.existsContactByName(Bean.getName(), Bean.getCompany())) {
			System.out.println("*****聯絡人已存在****");
			return "聯絡人已存在";
		}
		System.out.println("*****不存在****");
		return "不存在";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會 轉 聯絡人
	@RequestMapping("/changeContact.action")
	public String changeContact(ContactBean contactBean, Model model) {
		System.out.println("*****潛在各戶 轉 聯絡人****");
//		ContactBean contactBean = new ContactBean();
//		contactBean.setName(Bean.getName());
//		contactBean.setPhone(Bean.getPhone());
//		contactBean.setMoblie(Bean.getMoblie());
//		contactBean.setEmail(Bean.getEmail());
//		contactBean.setCompany(Bean.getCompany());
//		contactBean.setUser(Bean.getUser());
//		contactBean.setDepartment(Bean.getDepartment());
//		contactBean.setDirector(Bean.getDirector());
//		contactBean.setFax(Bean.getFax());
//		contactBean.setRemark(Bean.getRemark());
//		contactBean.setUser(Bean.getUser());
		contactBean.setClientid(4);

		cs.SaveContact(contactBean);
		model.addAttribute("message", "儲存成功");
		model.addAttribute("bean", contactBean);
		return "/client/contact";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人by名稱 ajax
	@RequestMapping("/selectContactByClientName/{name}")
	@ResponseBody
	public List<ContactBean> selectContactByClientName(@PathVariable("name") String name) {

		return cs.selectContactByClientName(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//潛在各戶轉工作項目
	@RequestMapping("/changeWork")
	public String changeWork(Model model, PotentialCustomerBean potentialCustomerBean) {
		WorkBean bean = new WorkBean();
		bean.setCustomer(potentialCustomerBean);
		model.addAttribute("bean", bean);
		return "/Market/work";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by負則人
	@RequestMapping("/selectMarket/{name}")
	public String selectName(Model model, @PathVariable("name") String name) {
		System.out.println("搜索銷售機會");
		model.addAttribute("list", ms.selectMarket(name));
		return "/Market/MarketList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by日期
	@RequestMapping("/selectDate")
	public String selectDate(Model model, @RequestParam("from") String from, @RequestParam("to") String to) {
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
			ms.selectDate(formDate, toDate);
			model.addAttribute("list", ms.selectDate(formDate, toDate));

		} catch (ParseException e) {

		}
		return "/Market/MarketList";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by狀態
	@RequestMapping("/selectStage/{name}")
	public String selectStage(Model model, @PathVariable("name") String name) {
		System.out.println("搜索銷售機會");
		model.addAttribute("list", ms.selectStage(name));
		return "/Market/MarketList";
	}
}
