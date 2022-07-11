package com.jetec.CRM.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.jetec.CRM.model.AdminBean;
import com.jetec.CRM.repository.AdminRepository;

@Service
public class UserService implements UserDetailsService{

	
	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	AdminRepository ar;
	@Override
	public UserDetails loadUserByUsername(String username) throws AuthenticationException {
		
		AdminBean adminBean= ar.findByEmail(username);		
		if(adminBean != null) {
		String password = encoder.encode(adminBean.getPassword());
		adminBean.setPassword(encoder.encode(adminBean.getPassword()));
		adminBean.setAuthorities(AuthorityUtils.commaSeparatedStringToAuthorityList(adminBean.getPosition()+","+adminBean.getDepartment()+","+adminBean.getName()));
		return adminBean;

//		return new User(username, password,AuthorityUtils.commaSeparatedStringToAuthorityList(adminBean.getPosition()+","+adminBean.getDepartment()+","+adminBean.getName()));
		}
		return null;
		
	}
	
	
	
	
	
}
