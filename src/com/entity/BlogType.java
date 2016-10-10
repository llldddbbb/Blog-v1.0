package com.entity;

/**
 * Created by ldb on 2016/9/22.
 */
public class BlogType {
    private int id;//主键
    private String typeName;//类型名称

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
