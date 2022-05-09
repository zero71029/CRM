package com.jetec.CRM.repository;

import com.jetec.CRM.model.ZeroMailBean;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface ZeroMailRepository extends JpaRepository< ZeroMailBean,String> {
    boolean existsByCreatetime(String ld);

    ZeroMailBean findByCreatetime(String ld);
}
