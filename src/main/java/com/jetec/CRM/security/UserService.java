package com.jetec.CRM.security;

import com.jetec.CRM.controler.service.AdminService;
import com.jetec.CRM.model.AdminPermitBean;
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

import java.util.List;

@Service
public class UserService implements UserDetailsService {


    @Autowired
    private PasswordEncoder encoder;
    @Autowired
    AdminRepository ar;
    @Autowired
    AdminService as;

    @Override
    public UserDetails loadUserByUsername(String username) throws AuthenticationException {

        AdminBean adminBean = ar.findByEmail(username);
        if (adminBean != null) {
            String password = encoder.encode(adminBean.getPassword());
            adminBean.setPassword(encoder.encode(adminBean.getPassword()));

            List<AdminPermitBean> permitLiat = as.getPermit(adminBean.getAdminid());
            String p = "";
            if(permitLiat != null){
                for (AdminPermitBean adminPermitBean : permitLiat) {
                    p += adminPermitBean.getLevel()+",";
                }
                adminBean.setPermit(p);
            }






            //插入權限
            adminBean.setAuthorities(AuthorityUtils.commaSeparatedStringToAuthorityList(p+adminBean.getPosition() + "," + adminBean.getDepartment() + "," + adminBean.getName()));


            return adminBean;

//		return new User(username, password,AuthorityUtils.commaSeparatedStringToAuthorityList(adminBean.getPosition()+","+adminBean.getDepartment()+","+adminBean.getName()));
        }
        return null;

    }


}
