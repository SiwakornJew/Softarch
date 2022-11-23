package com.medicare_backend.medicare_backend.schema.relationship;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "takeschedule")
public class TakeSchedule {
    private long takeScheduleId;
    private long employeeId;
    private long scheduleId;
    private LocalDateTime takeScheduleDate;

    public TakeSchedule() {
        
    }

    public TakeSchedule(long employeeId, long scheduleId) {
        this.employeeId = employeeId;
        this.scheduleId = scheduleId;
        this.takeScheduleDate = LocalDateTime.now();
    }


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getTakeScheduleId() {
        return takeScheduleId;
    }

    public void setTakeScheduleId(long takeScheduleId) {
        this.takeScheduleId = takeScheduleId;
    }

    @Column(name = "employee_id", nullable = false)
    public long getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(long employeeId) {
        this.employeeId = employeeId;
    }

    @Column(name = "schedule_id", nullable = false)
    public long getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(long scheduleId) {
        this.scheduleId = scheduleId;
    }

    @Column(name = "take_schedule_date", nullable = false)
    public LocalDateTime getTakeScheduleDate() {
        return takeScheduleDate;
    }

    public void setTakeScheduleDate(LocalDateTime takeScheduleDate) {
        this.takeScheduleDate = takeScheduleDate;
    }

}
