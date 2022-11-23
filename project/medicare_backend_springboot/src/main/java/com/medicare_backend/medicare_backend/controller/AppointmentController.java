package com.medicare_backend.medicare_backend.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.medicare_backend.medicare_backend.schema.entity.Patient;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;
import com.medicare_backend.medicare_backend.schema.relationship.Appointment;
import com.medicare_backend.medicare_backend.schema.relationship.TakeSchedule;
import com.medicare_backend.medicare_backend.schema.request.AddAppointment;
import com.medicare_backend.medicare_backend.service.AppointmentService;
import com.medicare_backend.medicare_backend.service.PatientService;
import com.medicare_backend.medicare_backend.service.ScheduleService;
import com.medicare_backend.medicare_backend.service.TakeScheduleService;
import com.medicare_backend.medicare_backend.service.TokenAuthenticationService;

@RestController
public class AppointmentController {

    private AppointmentService appointmentService;
    private PatientService patientService;
    private ScheduleService scheduleService;
    private TakeScheduleService takeScheduleService;
    private TokenAuthenticationService tokenService;

    @Autowired
    public AppointmentController(AppointmentService appointmentService,
            PatientService patientService,
            ScheduleService scheduleService,
            TakeScheduleService takeScheduleService) {
        this.appointmentService = appointmentService;
        this.patientService = patientService;
        this.scheduleService = scheduleService;
        this.takeScheduleService = takeScheduleService;
    }

    @GetMapping(path = "/appointments")
    public ResponseEntity<?> getAppointment() {
        try {
            List<Appointment> data = appointmentService.getAppointment();
            if (!(data != null && data.isEmpty())) {
                return ResponseEntity.ok().body(data);
            } else {
                return ResponseEntity.status(500).body("Appointment List Not Found");
            }
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @GetMapping(path = "/appointments/findbyId/{id}")
    public ResponseEntity<?> getAppointmentById(@PathVariable("id") Long appointmentId) {
        try {
            Optional<Appointment> data = appointmentService.getAppointmentById(appointmentId);
            if (data.isPresent()) {
                return ResponseEntity.ok().body(data);
            } else {
                return ResponseEntity.status(500).body("Appointment with Id : " + appointmentId + " Not Found");
            }
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @GetMapping(path = "/appointments/findPatientbyScheduleId/{id}") // finish
    public ResponseEntity<?> getPatientByScheduleId(@RequestHeader("authtoken") String authtoken ,@PathVariable("id") long appointmentScheduleId) {
        try {
            String authEmployeeID = tokenService.verifyJWTToken(authtoken);
            if (authEmployeeID == "error") {
                return ResponseEntity.status(400)
                    .body("Auth Time Out");
            }

            // check is schedule exist
            Optional<Schedule> schedule = scheduleService.getScheduleById(appointmentScheduleId);
            if (!schedule.isPresent()) {
                return ResponseEntity.status(400)
                        .body("Schedule with ID : " + appointmentScheduleId + " dose not exist");
            }

            // get List of appointment with scheduleId
            List<Appointment> dataAp = appointmentService.getAppointmentByScheduleId(appointmentScheduleId);
            // List of JSONdata
            List<JSONObject> data = new ArrayList<>();
            // if appointment with scheduleId exist
            if (dataAp != null && !dataAp.isEmpty()) {
                for (Appointment a : dataAp) {
                    // get patient info and add to JSONdata
                    Optional<Patient> patient = patientService.getPatientById(a.getAppointmentPatientId());
                    JSONObject object = new JSONObject();
                    object.put("appointmentDate", a.getAppointmentDate());
                    object.put("appointmentTimeStart", a.getAppiontmentTimeStart());
                    object.put("appointmentTimeEnd", a.getAppiontmentTimeEnd());
                    object.put("patientFirstName", patient.get().getPatientFirstName());
                    object.put("patientMiddleName", patient.get().getPatientMiddleName());
                    object.put("patientLastName", patient.get().getPatientLastName());
                    data.add(object);
                }
                return ResponseEntity.ok().body(data);
            } else {
                // if schedule have no petient
                return ResponseEntity.status(200)
                        .body("Schedule with ID : " + appointmentScheduleId + " doesn't have Patient");
            }
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @PostMapping(path = "/appointments/createNewAppointment") // finish
    public ResponseEntity<?> createNewAppointment(@RequestHeader("authtoken") String authtoken ,@RequestBody AddAppointment addAppointment) {
        try {
            String authEmployeeID = tokenService.verifyJWTToken(authtoken);
            if (authEmployeeID == "error") {
                return ResponseEntity.status(400)
                    .body("Auth Time Out");
            }

            // get schedule & check is schedule exist //checked
            Optional<Schedule> schedule = scheduleService.getScheduleById(addAppointment.getScheduleId());
            if (!schedule.isPresent()) {
                return ResponseEntity.status(400)
                        .body("Schedule with ID : " + addAppointment.getScheduleId() + " dose not exist");
            }

            // get patient & check is patient exist //checked
            Optional<Patient> patient = patientService
                    .getPatientBypatientNationalId(addAppointment.getPatientNationalId());
            if (!patient.isPresent()) {
                return ResponseEntity.status(400)
                        .body("Patient with NationalId : " + addAppointment.getPatientNationalId() + " dose not exist");
            }

            // get appointment & check is schedule full & check is patient alread in
            // schedule //checked
            List<Appointment> appointments = appointmentService
                    .getAppointmentByScheduleId(addAppointment.getScheduleId());
            if (appointments.size() == schedule.get().getScheduleCapacity()) {
                return ResponseEntity.status(400)
                        .body("Schedule with ID : " + addAppointment.getScheduleId() + " is already full");
            }
            for (Appointment appointment : appointments) {
                if (appointment.getAppointmentPatientId() == patient.get().getpatientHNId()) {
                    return ResponseEntity.status(400).body("Patient with NationalId : "
                            + addAppointment.getPatientNationalId() + " is already in schedule");
                }
            }

            // check is patient busy //checked
            boolean isBusy = appointmentService.isPatientBusy(schedule.get().getScheduleStart(),
                    schedule.get().getScheduleEnd(),
                    patient.get().getpatientHNId(), 0);
            if (isBusy) {
                return ResponseEntity.status(400).body("Patient Busy");
            }

            // get takeSchedule for doctorId & check is takeSchedule exist
            Optional<TakeSchedule> takeSchedule = takeScheduleService
                    .getTakeScheduleByScheduleId(addAppointment.getScheduleId());


            //check date to make appointment is not in range 3 day
            if (appointmentService.isWithinRange(schedule.get().getScheduleDate())) {
                return ResponseEntity.status(400).body("Can't Appointment before 3 day");
            }

            //create new appointment //checked
            String data = appointmentService.createNewAppointment(schedule, addAppointment, patient.get().getpatientHNId(), takeSchedule.get().getEmployeeId());

            if (data == "Create Success") {
                return ResponseEntity.ok().body(data);
            }
            return ResponseEntity.status(400).body(data);

        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }
}