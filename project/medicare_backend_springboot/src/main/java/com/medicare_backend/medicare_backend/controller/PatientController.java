package com.medicare_backend.medicare_backend.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.medicare_backend.medicare_backend.repository.AppointmentRepository;
import com.medicare_backend.medicare_backend.repository.EmployeeRepository;
import com.medicare_backend.medicare_backend.repository.PatientRepository;
import com.medicare_backend.medicare_backend.schema.entity.Employee;
import com.medicare_backend.medicare_backend.schema.entity.Patient;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;
import com.medicare_backend.medicare_backend.schema.relationship.Appointment;
import com.medicare_backend.medicare_backend.schema.relationship.TakeSchedule;
import com.medicare_backend.medicare_backend.schema.request.AddAppointment;
import com.medicare_backend.medicare_backend.schema.request.PostPoneAppointment;
import com.medicare_backend.medicare_backend.service.AppointmentService;
import com.medicare_backend.medicare_backend.service.PatientService;
import com.medicare_backend.medicare_backend.service.ScheduleService;
import com.medicare_backend.medicare_backend.service.TakeScheduleService;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
public class PatientController {
    private PatientService patientService;
    @Autowired
    private PatientRepository patientRepository;
    @Autowired
    private AppointmentRepository appointmentRepository;
    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private ScheduleService scheduleService;
    @Autowired
    private TakeScheduleService takeScheduleService;

    @Autowired
    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }

    @GetMapping(path = "/patients")
    public ResponseEntity<?> getPatient() {
        List<Patient> data = patientService.getPatient();
        for (Patient _patient : data) {
            _patient.setPatientPassword("mai bok eiei");
        }
        if (!(data != null && data.isEmpty())) {
            return ResponseEntity.ok().body(data);
        } else {
            return ResponseEntity.status(500).body("Patient List Not Found");
        }
    }

    @GetMapping(path = "/patientsinfo/findbyId/{id}")
    public ResponseEntity<?> getPatientmentById(@PathVariable("id") long patientHNId) {
        Optional<Patient> data = patientService.getPatientById(patientHNId);

        data.get().setPatientPassword("mai bok eiei");

        if (data.isPresent()) {
            return ResponseEntity.ok().body(data);
        } else {
            return ResponseEntity.status(500).body("Patients with Id : " + patientHNId + " Not Found");
        }
    }

    // @PostMapping(path = "/addpatients")
    // public ResponseEntity<?> createPatient(@RequestBody Patient patient) {
    // try {
    // patientService.createPatient(patient);
    // return ResponseEntity.ok().body(patient);
    // } catch (Exception e) {
    // System.out.println(e);
    // return ResponseEntity.status(500).body(patient);
    // }
    // }

    @PutMapping(path = "/updatePatient/{id}")
    public ResponseEntity<?> updatePatient(@PathVariable long id, @RequestBody Patient patient) {
        try {
            Patient _patient = patientService.updatePatient(id, patient);
            if (_patient == null) {
                return ResponseEntity.status(400).body("patientid is not found");
            }
            Patient updatePatient = patientRepository.save(_patient);
            return ResponseEntity.ok().body(updatePatient);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body(patient);
        }

    }

    @GetMapping(path = "/getappointmentbyPatient/{id}")
    public ResponseEntity<?> getAppointmentByPatientId(@PathVariable("id") long patientId) {
        try {
            // Optional<Patient> patient = patientService.getPatientById(patientId);
            List<Appointment> appointments = appointmentRepository
                    .findAppointmentByappointmentPatientId(patientId);
            if (appointments == null || appointments.isEmpty()) {
                return ResponseEntity.status(400).body("Patient with ID : " + patientId +
                        "is not exiting");
            }
            List<JSONObject> data = new ArrayList<>();
            for (Appointment a : appointments) {

                JSONObject object = new JSONObject();
                Optional<Employee> employee = employeeRepository.findById(a.getAppointmentDoctorId());
                Optional<Schedule> schedule = scheduleService.getScheduleById(a.getAppointmentScheduleId());
                if (employee == null || !employee.isPresent()) {
                    return ResponseEntity.status(400).body("Employee with ID : " + patientId +
                            "is not exiting");
                }
                object.put("EmployeeId", employee.get().getEmployeeId());
                object.put("scheduleId", a.getAppointmentScheduleId());
                object.put("Scheduletype", schedule.get().getScheduleType());
                object.put("appointmentDate", a.getAppointmentDate());
                object.put("appointmentTimeStart", a.getAppiontmentTimeStart());
                object.put("appointmentTimeEnd", a.getAppiontmentTimeEnd());
                object.put("EmployeeFirstName", employee.get().getEmployeeFirstName());
                object.put("EmployeeMiddleName", employee.get().getEmployeeMiddleName());
                object.put("EmployeeLastName", employee.get().getEmployeeLastName());
                object.put("EmployeeDepartment", employee.get().getEmployeeDepartment());
                data.add(object);
            }
            return ResponseEntity.ok().body(data);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body(e);

        }

    }

    @PostMapping(path = "patient/createNewAppointment")
    public ResponseEntity<?> createNewAppointment(@RequestBody AddAppointment addAppointment) {
        try {
            Optional<Schedule> schedule = scheduleService.getScheduleById(addAppointment.getScheduleId());
            if (schedule.get().getScheduleType() == 1) {
                return ResponseEntity.status(400).body("type is not allowed");
            }
            Optional<Patient> patient = patientService
                    .getPatientBypatientNationalId(addAppointment.getPatientNationalId());
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
            boolean isBusy = appointmentService.isPatientBusy(schedule.get().getScheduleStart(),
                    schedule.get().getScheduleEnd(),
                    patient.get().getpatientHNId(), 0);
            if (isBusy) {
                return ResponseEntity.status(400).body("Patient Busy");
            }
            Optional<TakeSchedule> takeSchedule = takeScheduleService
                    .getTakeScheduleByScheduleId(addAppointment.getScheduleId());

            // create new appointment //checked
            String data = appointmentService.createNewAppointment(schedule, addAppointment,
                    patient.get().getpatientHNId(), takeSchedule.get().getEmployeeId());
            if (data == "Create Success") {
                return ResponseEntity.ok().body(data);
            }
            return ResponseEntity.status(400).body(data);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @PostMapping(path = "patient/postponeAppointment")
    public ResponseEntity<?> postponeAppointment(@RequestBody PostPoneAppointment postponeAppointment) {
        try {
            Optional<Schedule> schedule = scheduleService.getScheduleById(postponeAppointment.getToScheduleId());
            if (schedule.get().getScheduleType() == 1) {
                return ResponseEntity.status(400).body("type is not allowed");
            }

            Optional<Patient> patient = patientService
                    .getPatientBypatientNationalId(postponeAppointment.getPatientNationalId());

            List<Appointment> appointments = appointmentService
                    .getAppointmentByScheduleId(postponeAppointment.getToScheduleId());

            if (appointments.size() == schedule.get().getScheduleCapacity()) {
                return ResponseEntity.status(400)
                        .body("Schedule with ID : " + postponeAppointment.getToScheduleId() + " is already full");
            }

            for (Appointment appointment : appointments) {
                if (appointment.getAppointmentPatientId() == patient.get().getpatientHNId()) {
                    return ResponseEntity.status(400).body("Patient with NationalId : "
                            + postponeAppointment.getPatientNationalId() + " is already in schedule");
                }
            }

            boolean isBusy = appointmentService.isPatientBusy(schedule.get().getScheduleStart(),
                    schedule.get().getScheduleEnd(),
                    patient.get().getpatientHNId(), 0);
            if (isBusy) {
                return ResponseEntity.status(400).body("Patient Busy");
            }

            Optional<TakeSchedule> takeSchedule = takeScheduleService
                    .getTakeScheduleByScheduleId(postponeAppointment.getToScheduleId());

            AddAppointment addAppointment = new AddAppointment();
            addAppointment.setPatientNationalId(postponeAppointment.getPatientNationalId());
            addAppointment.setScheduleId(postponeAppointment.getToScheduleId());

            // Move to new appointment //checked

            String dateDelete = appointmentService.deleteAppointmentByPatientIdAndScheduleId(patient.get().getpatientHNId(), postponeAppointment.getPreviousScheduleId());
            if (dateDelete != "Delete Success") {
                return ResponseEntity.status(400).body("No Appointment in this Schedule");
            }
            String data = appointmentService.createNewAppointment(schedule, addAppointment,
                    patient.get().getpatientHNId(), takeSchedule.get().getEmployeeId());
            if (data == "Create Success") {
                return ResponseEntity.ok().body("Post Pone Success");
            }

            return ResponseEntity.status(400).body(data);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }
}
