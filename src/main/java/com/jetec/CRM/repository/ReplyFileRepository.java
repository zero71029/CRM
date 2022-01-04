package com.jetec.CRM.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.ReplyFileBean;

public interface ReplyFileRepository extends JpaRepository<ReplyFileBean, String>{

	List<ReplyFileBean> findByAuthorize(String authorizeId);

	void deleteAllByReplyid(String Replyid);
	
	

}
