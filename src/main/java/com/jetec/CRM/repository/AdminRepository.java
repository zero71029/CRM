package com.jetec.CRM.repository;

import com.jetec.CRM.model.AdminBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminRepository extends JpaRepository<AdminBean, Integer>{

	boolean existsByEmailAndPassword(String userName, String userPassword);

	AdminBean findByEmailAndPassword(String userName, String userPassword);

	AdminBean findByName(String user);

	boolean existsByEmail(String email);

	List<AdminBean> getByDepartment(String Department);

	List<AdminBean> getByPosition(String Position);

	AdminBean findByEmail(String username);


}
