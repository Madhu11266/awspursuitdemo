package com.example.awspursuitdemo;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;


@Entity
public class User {
    @Id
    private String userId;
    private  String name;

    public String getUserId(){
        return userId;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name=name;
    }

    public void setUserId(String userId){
        this.userId=userId;
    }


}
