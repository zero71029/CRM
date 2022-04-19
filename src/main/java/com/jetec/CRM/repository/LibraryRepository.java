package com.jetec.CRM.repository;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.LibraryBean;

import java.util.List;

public interface LibraryRepository extends JpaRepository<LibraryBean, String>{

    List<LibraryBean> findByLibrarygroup(String librarygroup, Sort sort);

    boolean existsByLibrarygroupAndLibraryoption(String librarygroup, String libraryoption);
}
