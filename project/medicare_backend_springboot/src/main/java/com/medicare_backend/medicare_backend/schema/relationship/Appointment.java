package com.medicare_backend.medicare_backend.schema.relationship;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.*;

@Entity
@Table(name = "appointment")
public class Appointment {

    private long appointmentId;
    private long appointmentPatientId;
    private long appointmentDoctorId;
    private LocalDate appointmentDate;
    private String appiontmentLocation;
    private long appointmentScheduleId;
    private LocalDateTime appiontmentTimeStart;
    private LocalDateTime appiontmentTimeEnd;
    private boolean appointmentStatus;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
        public long getAppointmentId() {
        return appointmentId;
    }
    public void setAppointmentId(long id) {
        this.appointmentId = id;
    }

    public Appointment() {
    }

    public Appointment(long appointmentPatientId, 
                    long appointmentDoctorId, 
                    LocalDate appointmentDate, 
                    String appiontmentLocation, 
                    long appointmentScheduleId, 
                    LocalDateTime appiontmentTimeStart, 
                    LocalDateTime appiontmentTimeEnd) {
        this.appointmentPatientId = appointmentPatientId;
        this.appointmentDoctorId = appointmentDoctorId;
        this.appointmentDate = appointmentDate;
        this.appiontmentLocation = appiontmentLocation;
        this.appointmentScheduleId = appointmentScheduleId;
        this.appiontmentTimeStart = appiontmentTimeStart;
        this.appiontmentTimeEnd = appiontmentTimeEnd;
        this.appointmentStatus = true;
    }

    @Column(name = "appointment_patient_id", nullable = false)
    public long getAppointmentPatientId() {
        return this.appointmentPatientId;
    }

    public void setAppointmentPatientId(long appointmentPatientId) {
        this.appointmentPatientId = appointmentPatientId;
    }

    @Column(name = "appointment_doctor_id", nullable = false)
    public long getAppointmentDoctorId() {
        return this.appointmentDoctorId;
    }

    public void setAppointmentDoctorId(long appointmentDoctorId) {
        this.appointmentDoctorId = appointmentDoctorId;
    }

    @Column(name = "appointment_date", nullable = false)
    public LocalDate getAppointmentDate() {
        return this.appointmentDate;
    }

    public void setAppointmentDate(LocalDate appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    @Column(name = "appiontment_location", nullable = false)
    public String getAppiontmentLocation() {
        return this.appiontmentLocation;
    }

    public void setAppiontmentLocation(String appiontmentLocation) {
        this.appiontmentLocation = appiontmentLocation;
    }

    @Column(name = "appointment_schedule_id", nullable = false)
    public long getAppointmentScheduleId() {
        return this.appointmentScheduleId;
    }

    public void setAppointmentScheduleId(long appointmentScheduleId) {
        this.appointmentScheduleId = appointmentScheduleId;
    }

    @Column(name = "appiontment_time_start", nullable = false)
    public LocalDateTime getAppiontmentTimeStart() {
        return this.appiontmentTimeStart;
    }

    public void setAppiontmentTimeStart(LocalDateTime appiontmentTimeStart) {
        this.appiontmentTimeStart = appiontmentTimeStart;
    }

    @Column(name = "appiontment_time_end", nullable = false)
    public LocalDateTime getAppiontmentTimeEnd() {
        return this.appiontmentTimeEnd;
    }

    public void setAppiontmentTimeEnd(LocalDateTime appiontmentTimeEnd) {
        this.appiontmentTimeEnd = appiontmentTimeEnd;
    }

    public boolean getAppointmentStatus() {
        return this.appointmentStatus;
    }

    public void setAppointmentStatus(boolean appointmentStatus) {
        this.appointmentStatus = appointmentStatus;
    }

}