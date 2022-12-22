package com.jetec.CRM.controler.service;


import com.jetec.CRM.model.AdminPermitBean;
import com.jetec.CRM.repository.AdminPermitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AdminService {

    @Autowired
    AdminPermitRepository apr;

    /**
     * 找到AdminPermitBean
     *
     * @param adminid adminid
     * @param permit  许可证
     * @return {@link AdminPermitBean}
     */
    public AdminPermitBean findAdminPermitBeanByAdminAndLevel(Integer adminid, String permit) {
        return  apr.findByAdminAndLevel(adminid,permit);
    }

    public void savePermit(AdminPermitBean apBean) {
        apr.save(apBean);
    }

    public void delPermit(AdminPermitBean apBean) {
        apr.delete(apBean);
    }

    public List<AdminPermitBean> getPermit(Integer adminid) {
        return apr.findByAdmin(adminid);
    }
}
