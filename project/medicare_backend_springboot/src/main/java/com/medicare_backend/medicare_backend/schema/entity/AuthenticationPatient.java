package com.medicare_backend.medicare_backend.schema.entity;

public class AuthenticationPatient {
    private String nationalCardId;
    private String password;

    public AuthenticationPatient() {
        
    }

    public AuthenticationPatient(String nationalCardId, String password) {
        this.nationalCardId = nationalCardId;
        this.password = password;
    }

    public void setNationalCardId(String nationalCardId) {
        this.nationalCardId = nationalCardId;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNationalCardId() {
        return nationalCardId;
    }

    public String getPassword() {
        return password;
    }

}
