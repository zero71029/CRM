package com.jetec.CRM.repository;

import com.jetec.CRM.model.AdminBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AdminRepository extends JpaRepository<AdminBean, Integer>{

	boolean existsByEmailAndPassword(String userName, String userPassword);

	AdminBean findByEmailAndPassword(String userName, String userPassword);

	AdminBean findByName(String user);

	boolean existsByEmail(String email);

	List<AdminBean> getByDepartment(String Department);

	List<AdminBean> getByPosition(String Position);

	AdminBean findByEmail(String username);

	@Query(value = "SELECT  *  from admin WHERE state != '離職' order By adminid ASC ", nativeQuery = true)
	List<AdminBean> getAll();

	List<AdminBean> findByState(String state);
}
