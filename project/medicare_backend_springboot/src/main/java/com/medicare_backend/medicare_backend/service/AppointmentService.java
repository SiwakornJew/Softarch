package com.medicare_backend.medicare_backend.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicare_backend.medicare_backend.repository.AppointmentRepository;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;
import com.medicare_backend.medicare_backend.schema.relationship.Appointment;
import com.medicare_backend.medicare_backend.schema.request.AddAppointment;

@Service
public class AppointmentService {
    private AppointmentRepository appointmentRepository;
    private CompareDatetime compareDatetime = new CompareDatetime();

    @Autowired
    public AppointmentService(AppointmentRepository appointmentRepository) {
        this.appointmentRepository = appointmentRepository;
    }

    // Get all Appointment //for test
    public List<Appointment> getAppointment() {
        return appointmentRepository.findAll();
    }

    // Get Appointment by Id //for test
    public Optional<Appointment> getAppointmentById(Long appointmentId) {
        return appointmentRepository.findById(appointmentId);
    }

    // Delete Appointment By PatientId
    @Transactional
    public String deleteAppointmentByPatientId(Long patientId) {
        appointmentRepository.deleteByAppointmentPatientId(patientId);
        return "Delete Success";
    }

    // Delete Appointment By PatientId and ScheduleId
    @Transactional
    public String deleteAppointmentByPatientIdAndScheduleId(Long patientId, Long scheduleId) {
        appointmentRepository.deleteByAppointmentPatientIdAndAppointmentScheduleId(patientId, scheduleId);
        return "Delete Success";
    }

    // Create new Appointment
    public String createNewAppointment(Appointment appointment) {
        appointmentRepository.save(appointment);
        return "Create Success";
    }

    // Create new Appointment
    public String createNewAppointment(Optional<Schedule> schedule, AddAppointment addAppointment, long patientHNId,
            long employeeId) {
        Appointment appointment = new Appointment(patientHNId,
                employeeId,
                schedule.get().getScheduleDate(),
                schedule.get().getScheduleLocation(),
                addAppointment.getScheduleId(),
                schedule.get().getScheduleStart(),
                schedule.get().getScheduleEnd());
        appointmentRepository.save(appointment);
        return "Create Success";
    }

    // Get Appointment by ScheduleId
    public List<Appointment> getAppointmentByScheduleId(long appointmentScheduleId) {
        return appointmentRepository.findAppointmentByappointmentScheduleId(appointmentScheduleId);
    }

    // Update Appointment from Schedule
    @Transactional
    public List<Long> updateApponimentFromSchedule(long scheduleId,
            LocalDateTime appointmentTimeStart,
            LocalDateTime appointmentTimeEnd,
            LocalDate appointmentDate,
            String appointmentLocation,
            long appointmentDoctorId,
            boolean scheduleStatus) {
        List<Appointment> appointments = getAppointmentByScheduleId(scheduleId);
        List<Long> patientHNId = new ArrayList<>();
        if (appointments == null || appointments.isEmpty()) {
            return patientHNId;
        }

        for (Appointment a : appointments) {
            if (appointmentTimeStart != null && !Objects.equals(a.getAppiontmentTimeStart(), appointmentTimeStart)) {
                a.setAppiontmentTimeStart(appointmentTimeStart);
                patientHNId.add(a.getAppointmentPatientId());
            }
            if (appointmentTimeEnd != null && !Objects.equals(a.getAppiontmentTimeEnd(), appointmentTimeEnd)) {
                a.setAppiontmentTimeEnd(appointmentTimeEnd);
                if (!patientHNId.contains(a.getAppointmentPatientId())) {
                    patientHNId.add(a.getAppointmentPatientId());
                }
            }
            if (appointmentDate != null && !Objects.equals(a.getAppointmentDate(), appointmentDate)) {
                a.setAppointmentDate(appointmentDate);
                if (!patientHNId.contains(a.getAppointmentPatientId())) {
                    patientHNId.add(a.getAppointmentPatientId());
                }
            }
            if (appointmentLocation != null && appointmentLocation.length() > 0
                    && !Objects.equals(a.getAppiontmentLocation(), appointmentLocation)) {
                a.setAppiontmentLocation(appointmentLocation);
                if (!patientHNId.contains(a.getAppointmentPatientId())) {
                    patientHNId.add(a.getAppointmentPatientId());
                }
            }
            if (appointmentDoctorId != 0 && !Objects.equals(a.getAppointmentDoctorId(), appointmentDoctorId)) {
                a.setAppointmentDoctorId(appointmentDoctorId);
                if (!patientHNId.contains(a.getAppointmentPatientId())) {
                    patientHNId.add(a.getAppointmentPatientId());
                }
            }
            if (a.getAppointmentStatus() != scheduleStatus) {
                a.setAppointmentStatus(scheduleStatus);
                if (!patientHNId.contains(a.getAppointmentPatientId())) {
                    patientHNId.add(a.getAppointmentPatientId());
                }
            }
        }
        return patientHNId;
    }

    // check is patientbusy
    public boolean isPatientBusy(LocalDateTime scheduleStart, LocalDateTime scheduleEnd, long appointmentPatientId,
            long IdofcurrentSchedule) {
        List<Appointment> appointments = appointmentRepository
                .findAppointmentByappointmentPatientId(appointmentPatientId);
        for (Appointment appointment : appointments) {
            // appointment status need to be true and in future to check
            if (appointment.getAppointmentStatus() &&
                    appointment.getAppointmentDate().isAfter(LocalDate.now()) &&
                    appointment.getAppointmentScheduleId() != IdofcurrentSchedule) {
                if (compareDatetime.isOverlap(scheduleStart, scheduleEnd, appointment.getAppiontmentTimeStart(),
                        appointment.getAppiontmentTimeEnd())) {
                    return true;
                }
            }
        }
        return false;
    }

    //check date is valid
    public boolean isWithinRange(LocalDate scheduleDate) {
        LocalDate now = LocalDate.now();
        LocalDate start = scheduleDate;
        LocalDate stop = start.minusDays(3);
        return ( ! now.isBefore( stop ) ) && ( now.isBefore( start ) );
     }

}
