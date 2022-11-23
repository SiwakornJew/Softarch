package com.medicare_backend.medicare_backend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InternalPayload {

    private ArrayList<Object> payload = new ArrayList<>();

    public InternalPayload (String statusCode, String statusText) {
        Map<String, String> tempPayload = new HashMap<String, String>();
        payload.add(statusCode);
        payload.add(statusText);
        payload.add(tempPayload);
    }

    public InternalPayload (String statusCode, String statusText, Map<String,String>  payload) {
        this.payload.add(statusCode);
        this.payload.add(statusText);
        this.payload.add(payload);
    }

    public String getStatusCode() {
        return (String) payload.get(0);
    }

    public String getStatusText() {
        return (String) payload.get(1);
    }

    public Object getPayload() {
        return payload.get(2);
    }

    public void setStatusCode(String statusCode) {
        payload.set(0, statusCode);
    }

    public void setStatusText(String statusText) {
        payload.set(1, statusText);
    }

    public void setPayload(Map<Integer,String> payload) {
        this.payload.set(2, payload);
    }

}
