package com.jetec.CRM.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.repository.AdminRepository;

@Component
public class AppsAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
	@Autowired
	AdminRepository ar;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		System.out.println("登入失敗");

	
		String username = request.getParameter("username"); // 取得登入帳號
		String password = request.getParameter("password");
		System.out.println(username);
		System.out.println(password);
		AdminBean adminBean =  ar.findByEmail(username);
		String error = "Login failed";
		if(adminBean == null ) {
			System.out.println("找不到使用者");
			error = "User not found";
		}else if(!adminBean.getPassword().equals(password)){			
			error ="Wrong Password";
		}
		request.setCharacterEncoding("UTF-8");		
		response.sendRedirect("/CRM/time.jsp?error="+ error);
//		response.sendRedirect("/CRM.jsp");
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
		
		
	}

}
