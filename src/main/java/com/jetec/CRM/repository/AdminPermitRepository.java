package com.jetec.CRM.repository;

import com.jetec.CRM.model.AdminPermitBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminPermitRepository extends JpaRepository<AdminPermitBean,String> {


    AdminPermitBean findByAdminAndLevel(Integer adminid, String permit);

    List<AdminPermitBean> findByAdmin(Integer adminid);
}
