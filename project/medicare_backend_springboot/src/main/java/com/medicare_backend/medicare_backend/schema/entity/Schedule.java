package com.medicare_backend.medicare_backend.schema.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "schedule")
public class Schedule {

    private long scheduleId;
    private int scheduleCapacity;
    private LocalDateTime scheduleStart;
    private LocalDateTime scheduleEnd;
    private LocalDate scheduleDate;
    private String scheduleLocation;
    private boolean scheduleStatus;
    private int scheduleType;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
        public long getScheduleId() {
        return scheduleId;
    }
    public void setScheduleId(long id) {
        this.scheduleId = id;
    }

    public Schedule() {
    }

    public Schedule(int scheduleCapacity, 
                    LocalDateTime scheduleStart, 
                    LocalDateTime scheduleEnd, 
                    LocalDate scheduleDate, 
                    String scheduleLocation,
                    int scheduleType) {
        this.scheduleCapacity = scheduleCapacity;
        this.scheduleStart = scheduleStart;
        this.scheduleEnd = scheduleEnd;
        this.scheduleDate = scheduleDate;
        this.scheduleLocation = scheduleLocation;
        this.scheduleStatus = true;
        this.scheduleType = scheduleType;
    }

    @Column(name = "schedule_capacity", nullable = false)
    public int getScheduleCapacity() {
        return this.scheduleCapacity;
    }

    public void setScheduleCapacity(int scheduleCapacity) {
        this.scheduleCapacity = scheduleCapacity;
    }

    @Column(name = "schedule_start", nullable = false)
    public LocalDateTime getScheduleStart() {
        return this.scheduleStart;
    }

    public void setScheduleStart(LocalDateTime scheduleStart) {
        this.scheduleStart = scheduleStart;
    }

    @Column(name = "schedule_end", nullable = false)
    public LocalDateTime getScheduleEnd() {
        return this.scheduleEnd;
    }

    public void setScheduleEnd(LocalDateTime scheduleEnd) {
        this.scheduleEnd = scheduleEnd;
    }

    @Column(name = "schedule_date", nullable = false)
    public LocalDate getScheduleDate() {
        return this.scheduleDate;
    }

    public void setScheduleDate(LocalDate scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    @Column(name = "schedule_location", nullable = false)
    public String getScheduleLocation() {
        return this.scheduleLocation;
    }

    public void setScheduleLocation(String scheduleLocation) {
        this.scheduleLocation = scheduleLocation;
    }

    public boolean getScheduleStatus() {
        return this.scheduleStatus;
    }

    public void setScheduleStatus(boolean scheduleStatus) {
        this.scheduleStatus = scheduleStatus;
    }

    public int getScheduleType() {
        return this.scheduleType;
    }

    public void setScheduleType(int scheduleType) {
        this.scheduleType = scheduleType;
    }

}