package com.medicare_backend.medicare_backend.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicare_backend.medicare_backend.repository.PatientRepository;
import com.medicare_backend.medicare_backend.schema.entity.Patient;

@Service
public class PatientService {
    private PatientRepository patientRepository;
    private AuthenticationService authservice;

    @Autowired
    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public List<Patient> getPatient() {
        return patientRepository.findAll();
    }

    public Optional<Patient> getPatientById(long l) {
        return patientRepository.findById(l);
    }

    public String createPatient(Patient patient) {
        patientRepository.save(patient);
        return "suscess";
    }

    public Optional<Patient> getPatientBypatientNationalId(String patientNationalId) {
        return patientRepository.findPatientBypatientNationalId(patientNationalId);
    }

    public Patient updatePatient(long id, Patient patient) {
        try {
            Patient _patient = patientRepository.findBypatientHNId(id)
                    .orElseThrow(() -> new Handler("Patient not exit with id" + id));
            if (patient.getPatientFirstName() != null)
                _patient.setPatientFirstName(patient.getPatientFirstName());
            if (patient.getPatientMiddleName() != null)
                _patient.setPatientMiddleName(patient.getPatientMiddleName());
            if (patient.getPatientLastName() != null)
                _patient.setPatientLastName(patient.getPatientLastName());
            if (patient.getPatientNationalId() != null)
                _patient.setPatientNationalId(patient.getPatientNationalId());
            if (patient.getPatientPhoneNumber() != null)
                _patient.setPatientPhoneNumber(patient.getPatientPhoneNumber());
            if (patient.getPatientBirthDate() != null)
                _patient.setPatientBirthDate(patient.getPatientBirthDate());
            if (patient.getPatientLocation() != null)
                _patient.setPatientLocation(patient.getPatientLocation());
            if (patient.getPatientBloodType() != null)
                _patient.setPatientBloodType(patient.getPatientBloodType());
            if (patient.getPatientProfileIndex() != null)
                _patient.setPatientProfileIndex(patient.getPatientProfileIndex());
            if (patient.getPatientMedicine() != null)
                _patient.setPatientMedicine(patient.getPatientMedicine());
            _patient.setPatientAllergy(patient.getPatientAllergy());
            if (patient.getPatientDisease() != null)
                _patient.setPatientDisease(patient.getPatientDisease());
            if (patient.getPatientPassword() != null) {
                byte[] hash = authservice.getEncryptedPassword(patient.getPatientPassword(), "salt".getBytes());
                _patient.setPatientPassword(authservice.bytesToHex(hash));
            }

            return _patient;
        } catch (Exception e) {
            return patient;
        }
    }
}
