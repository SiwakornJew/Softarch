package com.medicare_backend.medicare_backend.schema.entity;

import java.time.LocalDate;

import javax.persistence.*;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.GenericGenerator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.medicare_backend.medicare_backend.service.CustomIdGenerate;

@Entity
@Table(name = "patient")
public class Patient {

    private long patientHNId;
    private String patientFirstName;
    private String patientMiddleName;
    private String patientLastName;
    private String patientNationalId;
    private String patientPhoneNumber;
    private LocalDate patientBirthDate;
    private String patientLocation;
    private Integer patientBloodType;
    private Integer patientProfileIndex;
    // *****//
    private String patientMedicine;
    private String patientAllergy;
    private String patientDisease;
    // *****//
    private String patientPassword;

    public Patient() {
    }

    public Patient(long patientHNId, String patientFirstName, String patientMiddleName, String patientLastName,
            String patientNationalId, String patientPhoneNumber, LocalDate patientBirthDate, String patientLocation,
            int patientBloodType, int patientProfileIndex, String patientMedicine, String patientAllergy,
            String patientDisease, String patientPassword) {
        this.patientHNId = patientHNId;
        this.patientFirstName = patientFirstName;
        this.patientMiddleName = patientMiddleName;
        this.patientLastName = patientLastName;
        this.patientNationalId = patientNationalId;
        this.patientPhoneNumber = patientPhoneNumber;
        this.patientBirthDate = patientBirthDate;
        this.patientLocation = patientLocation;
        this.patientBloodType = patientBloodType;
        this.patientProfileIndex = patientProfileIndex;
        this.patientMedicine = patientMedicine;
        this.patientAllergy = patientAllergy;
        this.patientDisease = patientDisease;
        this.patientPassword = patientPassword;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getpatientHNId() {
        return patientHNId;
    }

    public void setpatientHNId(Long id) {
        this.patientHNId = id;
    }

    @Column(name = "patient_first_name", nullable = false)
    public String getPatientFirstName() {
        return this.patientFirstName;
    }

    public void setPatientFirstName(String patientFirstName) {
        this.patientFirstName = patientFirstName;
    }

    @Column(name = "patient_middle_name")
    public String getPatientMiddleName() {
        return this.patientMiddleName;
    }

    public void setPatientMiddleName(String patientMiddleName) {
        this.patientMiddleName = patientMiddleName;
    }

    @Column(name = "patient_last_name", nullable = false)
    public String getPatientLastName() {
        return this.patientLastName;
    }

    public void setPatientLastName(String patientLastName) {
        this.patientLastName = patientLastName;
    }

    @Column(name = "patient_national_id", nullable = false)
    public String getPatientNationalId() {
        return this.patientNationalId;
    }

    public void setPatientNationalId(String patientNationalId) {
        this.patientNationalId = patientNationalId;
    }

    @Column(name = "patient_phone_number", nullable = false)
    public String getPatientPhoneNumber() {
        return this.patientPhoneNumber;
    }

    public void setPatientPhoneNumber(String patientPhoneNumber) {
        this.patientPhoneNumber = patientPhoneNumber;
    }

    @Column(name = "patient_birth_date", nullable = false)
    public LocalDate getPatientBirthDate() {
        return this.patientBirthDate;
    }

    public void setPatientBirthDate(LocalDate patientBirthDate) {
        this.patientBirthDate = patientBirthDate;
    }

    @Column(name = "patient_location", nullable = false)
    public String getPatientLocation() {
        return this.patientLocation;
    }

    public void setPatientLocation(String patientLocation) {
        this.patientLocation = patientLocation;
    }

    @Column(name = "patient_blood_type", nullable = false)
    public Integer getPatientBloodType() {
        return this.patientBloodType;
    }

    public void setPatientBloodType(int patientBloodType) {
        this.patientBloodType = patientBloodType;
    }

    @Column(name = "patient_profile_index", nullable = false)
    public Integer getPatientProfileIndex() {
        return patientProfileIndex;
    }

    public void setPatientProfileIndex(int patientProfileIndex) {
        this.patientProfileIndex = patientProfileIndex;
    }

    @Column(name = "patient_medicine")
    public String getPatientMedicine() {
        return patientMedicine;
    }

    public void setPatientMedicine(String patientMedicine) {
        this.patientMedicine = patientMedicine;
    }

    @Column(name = "patient_allergy")
    public String getPatientAllergy() {
        return patientAllergy;
    }

    public void setPatientAllergy(String patientAllergy) {
        this.patientAllergy = patientAllergy;
    }

    @Column(name = "patient_disease")
    public String getPatientDisease() {
        return patientDisease;
    }

    public void setPatientDisease(String patientDisease) {
        this.patientDisease = patientDisease;
    }

    @Column(name = "patient_password", nullable = false)
    public String getPatientPassword() {
        return patientPassword;
    }

    public void setPatientPassword(String patientPassword) {
        this.patientPassword = patientPassword;
    }

}