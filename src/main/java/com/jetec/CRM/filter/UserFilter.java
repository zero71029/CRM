package com.jetec.CRM.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jetec.CRM.model.AdminBean;


public class UserFilter implements Filter {


	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		servletRequest.setCharacterEncoding("utf-8");
		servletResponse.setCharacterEncoding("utf-8");
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;		
		AdminBean user = (AdminBean) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/time.jsp?mess=1");
		} else {
				chain.doFilter(servletRequest, servletResponse);

		}
	}
}
