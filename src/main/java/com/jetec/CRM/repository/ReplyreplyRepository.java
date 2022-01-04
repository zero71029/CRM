package com.jetec.CRM.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jetec.CRM.model.ReplyreplyBean;

public interface ReplyreplyRepository extends JpaRepository<ReplyreplyBean, String>{

	void deleteByReplyid(String replyId);

}
