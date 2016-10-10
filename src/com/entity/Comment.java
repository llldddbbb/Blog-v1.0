package com.entity;

import java.util.Date;

/**
 * Created by ldb on 2016/9/23.
 */
public class Comment {
    private int id;
    private String nickName;
    private String userIP;
    private String content;
    private Date commentTime;
    private String reply;
    private Blog blog;

    
    public Comment() {
		super();
		// TODO 自动生成的构造函数存根
	}
    

	public Comment(String nickName, String userIP, String content, Blog blog) {
		super();
		this.nickName = nickName;
		this.userIP = userIP;
		this.content = content;
		this.blog = blog;
	}


	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getUserIp() {
        return userIP;
    }

    public void setUserIp(String userIp) {
        this.userIP = userIp;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

	public String getUserIP() {
		return userIP;
	}

	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}

	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}
    
    
}
