package com.medicare_backend.medicare_backend.schema.request;

public class AddTask {
    
    private String token;
    private String username;

    public AddTask () {

    }

    public AddTask (String token, String username) {
        this.token = token;
        this.username = username;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getToken() {
        return token;
    }
    
    public String getUsername() {
        return username;
    }
    
}
