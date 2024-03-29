package com.jetec.CRM.controler.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jetec.CRM.Tool.ZeroTools;
import com.jetec.CRM.model.ClientAddressBean;
import com.jetec.CRM.model.ClientBean;
import com.jetec.CRM.model.ClientTagBean;
import com.jetec.CRM.model.ContactBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.QuotationBean;
import com.jetec.CRM.repository.ClientAddressRepository;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.ClientTagRepsitory;
import com.jetec.CRM.repository.ContactRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.QuotationRepository;

@Service
@Transactional
public class ClientService {

	@Autowired
	ClientRepository cr;
	@Autowired
	ContactRepository contactRepository;
	@Autowired
	MarketRepository mr;
	@Autowired
	QuotationRepository qr;
	@Autowired
	ClientAddressRepository car;
	@Autowired
	ClientTagRepsitory ctr;
	@Autowired
	ZeroTools zTools;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存客戶
	public ClientBean SaveAdmin(ClientBean clientBean) {
		return cr.save(clientBean);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表
	public List<ClientBean> getList() {
		return cr.findByState(1);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶細節
	public ClientBean getById(Integer id) {
		return cr.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶細節byName
	public ClientBean getCompanyByName(String name) {
		return cr.findByName(name);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除客戶
	public void delClient(List<Integer> id) {
		System.out.println(id);
		for (Integer i : id) {
			cr.deleteById(i);
		}

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//儲存聯絡人
	public ContactBean SaveContact(ContactBean contactBean) {
		// 用公司名稱 去找id
		if (contactBean.getClientid() == null){
			contactBean.setClientid(cr.selectIdByname(contactBean.getCompany()));
		}
		return contactRepository.save(contactBean);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人列表
	public Map<String, Object> getContactList(Integer pag) {
		Pageable p = PageRequest.of(pag, 40);
		Map<String, Object> result = new HashMap<>();
		Page<ContactBean> page = contactRepository.findAll(p);
		List<ContactBean> aaa = page.getContent();
		result.put("list", aaa);
		result.put("total", page.getTotalElements());
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人細節
	public Object getContactById(Integer id) {
		return contactRepository.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人細節
	public Object getByNameAndCompany(String name, String company) {
		return contactRepository.findByNameAndCompany(name, company);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取聯絡人by名稱
	public List<ContactBean> selectContactByClientName(String name) {
		return contactRepository.findByCompanyLikeIgnoreCase("%"+name+"%");
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除聯絡人
	public void delMarket(List<Integer> id) {
		for (Integer i : id) {
			contactRepository.deleteById(i);
		}

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 搜索聯絡人
	public List<ContactBean> selectContact(String name) {
		boolean boo = true;
		// 搜索名稱
		List<ContactBean> result = new ArrayList<>(contactRepository.findByNameLikeIgnoreCase("%" + name + "%"));
		// 用公司搜索
		for (ContactBean p : contactRepository.findByCompanyLikeIgnoreCase("%" + name + "%")) {
			for (ContactBean bean : result) {
				if (Objects.equals(bean.getContactid(), p.getContactid())) {
					boo = false;
					break;
				}
			}
			if (boo)
				result.add(p);
		}
		// 用客戶搜索
		for (ContactBean p : contactRepository.findByPhoneLikeIgnoreCase("%" + name + "%")) {
			for (ContactBean bean : result) {
				if (Objects.equals(bean.getContactid(),p.getContactid()) ) {
					boo = false;
					break;
				}
			}
			if (boo)
				result.add(p);
		}
		//
		for (ContactBean p : contactRepository.findByMoblieLikeIgnoreCase("%" + name + "%")) {
			for (ContactBean bean : result) {
				if (Objects.equals(bean.getContactid(), p.getContactid())) {
					boo = false;
					break;
				}
			}
			if (boo)
				result.add(p);
		}

		return result;

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索客戶
	public List<ClientBean> selectclient(String name) {
		boolean boo = true;
		// 搜索名稱
		List<ClientBean> result = new ArrayList<>(cr.findByNameLikeIgnoreCase("%" + name + "%"));

		// 用統編搜索
		for (ClientBean p : cr.findByUniformnumberLikeIgnoreCase("%" + name + "%")) {
			for (ClientBean bean : result) {
				if (Objects.equals(bean.getClientid(), p.getClientid())) {
					boo = false;
					break;
				}
			}
			if (boo)
				result.add(p);
		}
		// 用電話搜索
		for (ClientBean p : cr.findByPhoneLikeIgnoreCase("%" + name + "%")) {
			for (ClientBean bean : result) {
				if (Objects.equals(bean.getClientid(), p.getClientid())) {
					boo = false;
					break;
				}
			}
			if (boo)
				result.add(p);
		}
		// 用聯絡人搜索
		for (ClientBean p : cr.findByUserLikeIgnoreCase("%" + name + "%")) {
			for (ClientBean bean : result) {
				if (Objects.equals(bean.getClientid(), p.getClientid())) {
					boo = false;
					break;
				}
			}
			if (boo)
				result.add(p);
		}

		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取銷售機會by公司
	public List<MarketBean> getMarketListByClient(String name) {

		return mr.findByClient(name,Sort.by(Sort.Direction.DESC,"aaa"));
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取報價單by公司
	public List<QuotationBean> getQuotationByClient(String name) {
		// TODO Auto-generated method stub

		return qr.findByName(name);
	}

/////////////////////////////////////////////////////////////////////////
	// 判段客戶存在
	public boolean existsByName(String name) {
		return cr.existsByName(name);
	}

/////////////////////////////////////////////////////////////////////////
//判段聯絡人存在
	public boolean existsContactByName(String name, String company) {
		return contactRepository.existsByNameAndCompany(name, company);
	}

	// 判段公司存在
	public boolean existsContactByCompany(String company) {
		return cr.existsByName(company);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增其他地址
	public void newAddress(ClientAddressBean cabean) {
		if (cabean.getAddressid() == null)
			cabean.setAddressid(ZeroTools.getUUID());
		car.save(cabean);

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除其他地址
	public void delAddress(String addressid) {
		car.deleteById(addressid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//新增標籤
	public String saveTag(String tagName, Integer clientid) {

		if (!ctr.existsByClientidAndName(clientid, tagName)) {
			ClientTagBean clientTagBean = new ClientTagBean();
			clientTagBean.setClientid(clientid);
			clientTagBean.setClienttagid(ZeroTools.getUUID());
			clientTagBean.setName(tagName);
			ctr.save(clientTagBean);
			return "新增成功";
		}
		return "已有標籤";
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//刪除標籤
	public void removeTag(String clienttagid) {
		ctr.deleteById(clienttagid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取標籤列表
	public List<ClientTagBean> getTagList(Integer clientid) {
		return ctr.findByClientid(clientid);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//點擊標籤
	public List<ClientBean> clickTag(String tag) {
		List<ClientTagBean> list = ctr.getTagList(tag);
		List<ClientBean> result = new ArrayList<>();
		for (ClientTagBean bean : list) {
			result.add(cr.getById(bean.getClientid()));
		}
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//各戶負責人改變
	public void changeUser(Integer clientid, String user) {
		ClientBean cBean = cr.getById(clientid);
		cBean.setUser(user);
		cr.save(cBean);
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取客戶列表pag
    public Map<String, Object> init(Integer pag) {
		Pageable p = PageRequest.of(pag, 40, Sort.Direction.ASC, "clientid");
		Page<ClientBean> page = cr.findAll(p);
		Map<String, Object> result = new HashMap<>();
		result.put("list", page.getContent());
		result.put("todayTotal", page.getTotalElements());
		return result;
    }

	public void saveMarket(MarketBean marketBean) {
		mr.save(marketBean);
	}

	public List<MarketBean> getMarketListByClientid(Integer clientid) {
		return mr.findByClientid(clientid);
	}

	public List<ContactBean> getContactByClientid(Integer clientid) {

		return contactRepository.findByClientid(clientid);
	}

	public ContactBean getContactByNameAndCompany(String name, String company) {
		return (ContactBean) contactRepository.findByNameAndCompany(name,company);
	}

	public boolean existsByid(Integer clientid) {
		return cr.existsById(clientid);
	}

    public List<MarketBean> getMarketListByContactid(Integer contactid) {
		return mr.findByContactid(contactid);
    }

	public List<ContactBean> getContactByCompany(String company) {
		return  contactRepository.findByCompany(company);
	}
}
