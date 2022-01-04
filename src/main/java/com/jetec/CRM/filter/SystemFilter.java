package com.jetec.CRM.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;

import com.jetec.CRM.controler.service.SystemService;
import com.jetec.CRM.model.AdminBean;

public class SystemFilter implements Filter {

	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		servletRequest.setCharacterEncoding("utf-8");
		servletResponse.setCharacterEncoding("utf-8");
		HttpServletRequest request = (HttpServletRequest) servletRequest;
//		HttpServletResponse response = (HttpServletResponse) servletResponse;
		AdminBean user = (AdminBean) request.getSession().getAttribute("user");	
		System.out.println("********filter************");
		System.out.println(request.getSession());
		System.out.println(SecurityContextHolder.getContext().getAuthentication());
		
		if(user == null) {
			SystemService ss = new SystemService();
			ss.auth(SecurityContextHolder.getContext().getAuthentication(), request.getSession());
		}


		chain.doFilter(servletRequest, servletResponse);
		
	}
}
