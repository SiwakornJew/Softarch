package com.medicare_backend.medicare_backend.schema.request;

public class PostPoneAppointment {
    
    private long previousScheduleId;
    private long toScheduleId;
    private String patientNationalId;

    public long getPreviousScheduleId() {
        return previousScheduleId;
    }

    public void setPreviousScheduleId(long previousScheduleId) {
        this.previousScheduleId = previousScheduleId;
    }

    public long getToScheduleId() {
        return toScheduleId;
    }

    public void setToScheduleId(long toScheduleId) {
        this.toScheduleId = toScheduleId;
    }

    public String getPatientNationalId() {
        return this.patientNationalId;
    }

    public void setPatientNationalId(String patientNationalId) {
        this.patientNationalId = patientNationalId;
    }

}
