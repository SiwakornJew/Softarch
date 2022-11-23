package com.medicare_backend.medicare_backend.schema.request;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class AddSchedule {
    private int scheduleCapacity;
    private LocalDateTime scheduleStart;
    private LocalDateTime scheduleEnd;
    private LocalDate scheduleDate;
    private String scheduleLocation;
    private long employeeId;
    private int scheduleType;

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

    public long getEmployeeId() {
        return this.employeeId;
    }

    public void setEmployeeId(long employeeId) {
        this.employeeId = employeeId;
    }

    public int getScheduleType() {
        return this.scheduleType;
    }

    public void setScheduleType(int scheduleType) {
        this.scheduleType = scheduleType;
    }    

}
