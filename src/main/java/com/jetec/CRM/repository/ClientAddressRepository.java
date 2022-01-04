package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.ClientAddressBean;

public interface ClientAddressRepository extends JpaRepository<ClientAddressBean, String>{

}
