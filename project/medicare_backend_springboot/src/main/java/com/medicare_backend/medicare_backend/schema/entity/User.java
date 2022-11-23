package com.medicare_backend.medicare_backend.schema.entity;

import java.time.LocalDateTime;

import javax.persistence.*;

@Entity
@Table(name = "user")
public class User {
    
    private long id;
    private String patientHNId;
    private String patientFirstName;
    private String patientMiddleName;
    private String patientLastName;
    private String patientNationalId;
    private String patientPhoneNumber;
    private LocalDateTime patientBirthDate;
    private String patientLocation;
    private Long patientBloodType;
    private Long patientGender;
    private String patientPassword;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getId() {
        return this.id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Column(name = "patientHNId", nullable = false)
    public String getPatientHNId() {
        return this.patientHNId;
    }

    public void setPatientHNId(String patientHNId) {
        this.patientHNId = patientHNId;
    }

    @Column(name = "patientFirstName", nullable = false)
    public String getPatientFirstName() {
        return this.patientFirstName;
    }

    public void setPatientFirstName(String patientFirstName) {
        this.patientFirstName = patientFirstName;
    }

    @Column(name = "patientMiddleName")
    public String getPatientMiddleName() {
        return this.patientMiddleName;
    }

    public void setPatientMiddleName(String patientMiddleName) {
        this.patientMiddleName = patientMiddleName;
    }

    @Column(name = "patientLastName", nullable = false)
    public String getPatientLastName() {
        return this.patientLastName;
    }

    public void setPatientLastName(String patientLastName) {
        this.patientLastName = patientLastName;
    }

    @Column(name = "patientNationalId", nullable = false)
    public String getPatientNationalId() {
        return this.patientNationalId;
    }

    public void setPatientNationalId(String patientNationalId) {
        this.patientNationalId = patientNationalId;
    }

    @Column(name = "patientPhoneNumber", nullable = false)
    public String getPatientPhoneNumber() {
        return this.patientPhoneNumber;
    }

    public void setPatientPhoneNumber(String patientPhoneNumber) {
        this.patientPhoneNumber = patientPhoneNumber;
    }

    @Column(name = "patientBirthDate", nullable = false)
    public LocalDateTime getPatientBirthDate() {
        return this.patientBirthDate;
    }

    public void setPatientBirthDate(LocalDateTime patientBirthDate) {
        this.patientBirthDate = patientBirthDate;
    }

    @Column(name = "patientLocation", nullable = false)
    public String getPatientLocation() {
        return this.patientLocation;
    }

    public void setPatientLocation(String patientLocation) {
        this.patientLocation = patientLocation;
    }

    @Column(name = "patientBloodType", nullable = false)
    public Long getPatientBloodType() {
        return this.patientBloodType;
    }

    public void setPatientBloodType(Long patientBloodType) {
        this.patientBloodType = patientBloodType;
    }

    @Column(name = "patientGender", nullable = false)
    public Long getPatientGender() {
        return this.patientGender;
    }

    public void setPatientGender(Long patientGender) {
        this.patientGender = patientGender;
    }

    @Column(name = "patientPassword", nullable = false)
    public String getPatientPassword() {
        return patientPassword;
    }

    public void setPatientPassword(String patientPassword) {
        this.patientPassword = patientPassword;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + patientFirstName + ", emailId=" + patientHNId
       + "]";
    }

}
