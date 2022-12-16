package com.jetec.CRM.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "laboratory_forum_content")
public class LaboratoryForumContentBean {

    public LaboratoryForumContentBean() {
    }

    public LaboratoryForumContentBean(String forumid, String content) {
        this.forumid = forumid;
        this.content = content;
    }

    @Id
    @Column(columnDefinition = "char(32)")
    private String forumid;

    @Column(columnDefinition = "longtext")
    private String content;


    public String getForumid() {
        return forumid;
    }

    public void setForumid(String forumid) {
        this.forumid = forumid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
