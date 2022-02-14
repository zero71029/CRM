package com.jetec.CRM.controler.service;

import java.text.SimpleDateFormat;
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
import com.jetec.CRM.model.AgreementBean;
import com.jetec.CRM.model.MarketBean;
import com.jetec.CRM.model.MarketRemarkBean;
import com.jetec.CRM.model.QuotationBean;
import com.jetec.CRM.model.QuotationDetailBean;
import com.jetec.CRM.model.TrackBean;
import com.jetec.CRM.repository.AgreementRepository;
import com.jetec.CRM.repository.MarketRemarkRepository;
import com.jetec.CRM.repository.MarketRepository;
import com.jetec.CRM.repository.QuotationRepository;
import com.jetec.CRM.repository.TrackRepository;

@Service
@Transactional
public class MarketService {
	@Autowired
	MarketRepository mr;
	@Autowired
	MarketRemarkRepository mrr;
	@Autowired
	TrackRepository tr;
	@Autowired
	QuotationRepository qr;
	@Autowired
	AgreementRepository ar;
	@Autowired
	ZeroTools zTools;

	public MarketBean save(MarketBean marketBean) {

		//插入日期
		if (marketBean.getAaa() == "") {			
			marketBean.setAaa(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
		}
		return mr.save(marketBean);
	}

/////////////////////////////////////////////////////////////////////////////////////
	// 銷售機會列表
	public List<MarketBean> getList(Integer pag) {

		Pageable p = (Pageable) PageRequest.of(pag, 20);
		Page<MarketBean> page = (Page<MarketBean>) mr.findStage(p);
		List<MarketBean> result = page.getContent();
//		Sort sort = Sort.by(Direction.DESC, "marketid");
//		List<MarketBean> result = mr.findByStage("尚未處理", sort);
//		result.addAll(mr.findByStage("需求確認", sort));
//		result.addAll(mr.findByStage("聯繫中", sort));
//		result.addAll(mr.findByStage("處理中", sort));
//		result.addAll(mr.findByStage("已報價", sort));
		return result;
	}
	//所有筆數
	public Integer getTotal() {		
		return mr.getTotal();
	}

/////////////////////////////////////////////////////////////////////////////////////
	// 銷售機會列表(結案)
	public List<MarketBean> CloseMarket() {
		Sort sort = Sort.by(Direction.DESC, "marketid");
		List<MarketBean> result = mr.findByStage("成功結案", sort);
		result.addAll(mr.findByStage("失敗結案", sort));
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////
	public MarketBean getById(String id) {
		return mr.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////	
	public void SaveRemark(MarketRemarkBean mrb) {
		mrr.save(mrb);
	}

/////////////////////////////////////////////////////////////////////////////////////	
	// 刪除銷售機會
	public void delMarket(List<String> id) {
		for (String i : id) {
			mrr.deleteByMarketid(i);
			mr.deleteById(i);
		}
	}

/////////////////////////////////////////////////////////////////////////////////////	
//搜索銷售機會
	public List<MarketBean> selectMarket(String name) {
		name = name.trim();
		List<MarketBean> result = new ArrayList<MarketBean>();
		boolean boo = true;
		// 搜索名稱
		for (MarketBean p : mr.findByNameLikeIgnoreCase("%" + name + "%")) {
			result.add(p);
		}

		// 用業務搜索
		for (MarketBean p : mr.findByUserLikeIgnoreCase("%" + name + "%")) {
			for (MarketBean bean : result) {
				if (bean.getMarketid() == p.getMarketid()) {
					boo = false;
				}
			}
			if (boo)
				result.add(p);
		}
		// 用客戶搜索
		for (MarketBean p : mr.findByClientLikeIgnoreCase("%" + name + "%")) {
			for (MarketBean bean : result) {
				if (bean.getMarketid() == p.getMarketid()) {
					boo = false;
				}
			}
			if (boo)
				result.add(p);
		}
		// 用聯絡人搜索
		for (MarketBean p : mr.findByContactnameLikeIgnoreCase("%" + name + "%")) {
			for (MarketBean bean : result) {
				if (bean.getMarketid() == p.getMarketid()) {
					boo = false;
				}
			}
			if (boo)
				result.add(p);
		}

		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////	
//刪除備註
	public void delRemark(Integer remarkId) {
		mrr.deleteById(remarkId);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存追蹤
	public TrackBean SaveTrack(TrackBean trackBean) {
		 return tr.save(trackBean);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存報價單
	public QuotationBean SaveQuotation(QuotationBean qBean) {
		System.out.println(qBean.getQdb());
		for (QuotationDetailBean qdb : qBean.getQdb()) {
			if (qdb.getId() == null || qdb.getId().length() == 0) {
				qdb.setId(zTools.getUUID());
				qdb.setQuotationid(qBean.getQuotationid());
			}
		}

		QuotationBean save = qr.save(qBean);
		qr.delNull();
		return save;

//		qr.alterINCREMENT();

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取報價單細節
	public QuotationBean getQuotationById(Integer id) {
		return qr.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//報價單列表
	public List<QuotationBean> getQuotationList() {
		Sort sort = Sort.by(Direction.DESC, "quotationid");
		return qr.findAll(sort);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//存合約	
	public void SaveAgreement(AgreementBean aBean) {
		ar.save(aBean);

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//讀取合約細節
	public AgreementBean getAgreementBeanById(Integer id) {
		return ar.getById(id);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 搜索銷售機會by日期
	public List<MarketBean> selectDate(Date startTime, Date endTime) {
		return mr.findCreatetime(startTime, endTime);

	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by狀態
	public List<MarketBean> selectStage(String name) {
		Sort sort = Sort.by(Direction.DESC, "marketid");
		return mr.findByStage(name, sort);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//銷售機會列表
	public List<MarketBean> selectContantPhone(String phone) {
		List<MarketBean> result = mr.findByContactphone(phone);
		Boolean isBoolean = true;
		for (MarketBean bean : mr.findByContactmoblie(phone)) {
			System.out.println(bean);
			for (MarketBean phonebeBean : result) {
				if (bean.getMarketid() == phonebeBean.getMarketid()) {
					isBoolean = false;
				}
			}
			if (isBoolean)
				result.add(bean);
			isBoolean = true;
		}
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產品類別
	public List<MarketBean> selectProductType(List<String> data) {
		List<MarketBean> result = new ArrayList<MarketBean>();
		for (String typeString : data) {
			result.addAll(mr.findProducttype(typeString));
			result.addAll(mr.findSource(typeString));
		}
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產業
	public List<MarketBean> selectIndustry(List<String> data) {
		List<MarketBean> result = new ArrayList<MarketBean>();
		for (String typeString : data) {
			result.addAll(mr.selectType(typeString));
		}
		return result;
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by產品類別
	public List<MarketBean> selectClinch(String clinch) {
		// TODO Auto-generated method stub
		return mr.selectClinch(clinch);
	}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//搜索銷售機會by預算
	public List<MarketBean> selectBudget(String start, String to) {
		// TODO Auto-generated method stub
		return mr.selectBudget(start, to);
	}



}
