package com.entity;

/**
 * Created by ldb on 2016/9/22.
 */
public class Bloger {
    private int id;//主键
    private String userName;//用户名
    private String password;//密码
    private String nickName;//昵称
    private String job;//职业
    private String hobby;//爱好
    private String email;//邮箱
    private String webClick;//博客点击率

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getHobby() {
        return hobby;
    }

    public void setHobby(String hobby) {
        this.hobby = hobby;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

	public String getWebClick() {
		return webClick;
	}

	public void setWebClick(String webClick) {
		this.webClick = webClick;
	}

   
}
