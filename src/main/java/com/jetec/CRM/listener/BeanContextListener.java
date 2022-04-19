package com.jetec.CRM.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.repository.AdminRepository;
import com.jetec.CRM.repository.BillboardGroupRepository;
import com.jetec.CRM.repository.ClientRepository;
import com.jetec.CRM.repository.LibraryRepository;

@Component
public class BeanContextListener implements ServletContextListener {
	@Autowired
	AdminRepository ar;
	@Autowired
	ClientRepository cr;
	@Autowired
	BillboardGroupRepository bgr;
	@Autowired
	LibraryRepository lr;
	@Autowired
	SystemService ss; 
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("bean context 初始化");
		System.out.println("上傳library");
		ServletContext app = sce.getServletContext();
		Sort sort = Sort.by(Sort.Direction.DESC, "libraryoption");
		app.setAttribute("library", lr.findAll(sort));
		app.setAttribute("admin", ar.findByStateOrState("在職","新"));
		app.setAttribute("client", cr.findAll());
		app.setAttribute("billboardgroup", bgr.findAll());
		System.out.println("清除檔案 只有資料庫");
		ss.delBbillboardFfile();
		
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("bean context 销毁");
	}

}
