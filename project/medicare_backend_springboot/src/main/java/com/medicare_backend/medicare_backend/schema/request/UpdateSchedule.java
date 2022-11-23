package com.medicare_backend.medicare_backend.schema.request;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class UpdateSchedule {
    private long scheduleId;
    private int scheduleCapacity;
    private LocalDateTime scheduleStart;
    private LocalDateTime scheduleEnd;
    private LocalDate scheduleDate;
    private String scheduleLocation;
    private boolean scheduleStatus;
    private long appointmentDoctorId;

    public long getScheduleId() {
        return this.scheduleId;
    }

    public void setScheduleId(long scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getScheduleCapacity() {
        return this.scheduleCapacity;
    }

    public void setScheduleCapacity(int scheduleCapacity) {
        this.scheduleCapacity = scheduleCapacity;
    }

    public LocalDateTime getScheduleStart() {
        return this.scheduleStart;
    }

    public void setScheduleStart(LocalDateTime scheduleStart) {
        this.scheduleStart = scheduleStart;
    }

    public LocalDateTime getScheduleEnd() {
        return this.scheduleEnd;
    }

    public void setScheduleEnd(LocalDateTime scheduleEnd) {
        this.scheduleEnd = scheduleEnd;
    }

    public LocalDate getScheduleDate() {
        return this.scheduleDate;
    }

    public void setScheduleDate(LocalDate scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    public String getScheduleLocation() {
        return this.scheduleLocation;
    }

    public void setScheduleLocation(String scheduleLocation) {
        this.scheduleLocation = scheduleLocation;
    }

    public long getAppointmentDoctorId() {
        return this.appointmentDoctorId;
    }

    public void setAppointmentDoctorId(long appointmentDoctorId) {
        this.appointmentDoctorId = appointmentDoctorId;
    }

    public boolean isScheduleStatus() {
        return this.scheduleStatus;
    }

    public boolean getScheduleStatus() {
        return this.scheduleStatus;
    }

    public void setScheduleStatus(boolean scheduleStatus) {
        this.scheduleStatus = scheduleStatus;
    }
}