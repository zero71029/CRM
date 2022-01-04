package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.AuthorizeBean;

public interface AuthorizeRepository extends JpaRepository<AuthorizeBean, String>{

}
