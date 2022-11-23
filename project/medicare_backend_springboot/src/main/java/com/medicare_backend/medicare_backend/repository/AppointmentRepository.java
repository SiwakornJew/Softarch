package com.medicare_backend.medicare_backend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import com.medicare_backend.medicare_backend.schema.relationship.Appointment;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    List<Appointment> findAppointmentByappointmentScheduleId(long appointmentScheduleId);

    List<Appointment> findAppointmentByappointmentPatientId(long appointmentPatientId);

    List<Appointment> findAppointmentByappointmentDoctorId(long appointmentDoctorId);

    List<Appointment> deleteByAppointmentPatientId(long appointmentPatientId);

    List<Appointment> deleteByAppointmentPatientIdAndAppointmentScheduleId(long appointmentPatientId, long appointmentScheduleId);

}