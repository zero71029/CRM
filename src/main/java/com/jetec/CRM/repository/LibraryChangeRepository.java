package com.jetec.CRM.repository;

import com.jetec.CRM.model.LibraryChangeBean;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface LibraryChangeRepository extends JpaRepository<LibraryChangeBean,String> {
    Optional<List<LibraryChangeBean>> findByLibrarygroup(String librarygroup, Sort sort);
}
