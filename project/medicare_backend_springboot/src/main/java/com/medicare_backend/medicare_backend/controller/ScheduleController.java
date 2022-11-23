package com.medicare_backend.medicare_backend.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.medicare_backend.medicare_backend.schema.entity.Employee;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;
import com.medicare_backend.medicare_backend.schema.relationship.Appointment;
import com.medicare_backend.medicare_backend.schema.relationship.TakeSchedule;
import com.medicare_backend.medicare_backend.schema.request.AddSchedule;
import com.medicare_backend.medicare_backend.schema.request.UpdateSchedule;
import com.medicare_backend.medicare_backend.service.ScheduleService;
import com.medicare_backend.medicare_backend.service.TakeScheduleService;
import com.medicare_backend.medicare_backend.service.TokenAuthenticationService;
import com.medicare_backend.medicare_backend.service.AppointmentService;
import com.medicare_backend.medicare_backend.service.EmployeeService;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
public class ScheduleController {

    private ScheduleService scheduleService;
    private AppointmentService appointmentService;
    private TakeScheduleService takeScheduleService;
    private EmployeeService employeeService;
    private TokenAuthenticationService tokenService;

    @Autowired
    public ScheduleController(ScheduleService scheduleService,
            AppointmentService appointmentService,
            TakeScheduleService takeScheduleService,
            EmployeeService employeeService) {
        this.scheduleService = scheduleService;
        this.appointmentService = appointmentService;
        this.takeScheduleService = takeScheduleService;
        this.employeeService = employeeService;
    }

    @GetMapping(path = "/schedules")
    public ResponseEntity<?> getSchedule() {
        try {
            List<Schedule> data = scheduleService.getSchedule();
            List<JSONObject> objects = new ArrayList<>();
            for (Schedule s : data) {
                List<Appointment> appointments = appointmentService.getAppointmentByScheduleId(s.getScheduleId());
                Optional<TakeSchedule> takeSchedule = takeScheduleService
                        .getTakeScheduleByScheduleId(s.getScheduleId());
                Optional<Employee> e = employeeService.getEmployeeById(takeSchedule.get().getEmployeeId());
                JSONObject _object = new JSONObject();
                System.out.println(e);
                _object.put("docterFirstName", e.get().getEmployeeFirstName());
                _object.put("docterMiddleName", e.get().getEmployeeMiddleName());
                _object.put("docterLastName", e.get().getEmployeeLastName());
                _object.put("docterDepartMent", e.get().getEmployeeDepartment());
                _object.put("docterEmployeeId", e.get().getEmployeeId());
                _object.put("scheduleId", s.getScheduleId());
                _object.put("scheduleType", s.getScheduleType());
                _object.put("scheduleDate", s.getScheduleDate());
                _object.put("scheduleStartTIme", s.getScheduleStart());
                _object.put("scheduleFinishTime", s.getScheduleEnd());
                _object.put("scheduleCapacity", s.getScheduleCapacity());
                _object.put("patientCount", appointments.size());
                _object.put("scheduleStatus", s.getScheduleStatus());
                objects.add(_object);
            }
            if (!(data != null && data.isEmpty())) {

                return ResponseEntity.ok().body(objects);
            } else {
                return ResponseEntity.status(500).body("Schedule List Not Found");
            }
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @GetMapping(path = "/schedules/findbyId/{id}")
    public ResponseEntity<?> getScheduleById(@PathVariable("id") Long scheduleId) {
        try {
            Optional<Schedule> data = scheduleService.getScheduleById(scheduleId);
            if (data.isPresent()) {
                return ResponseEntity.ok().body(data);
            } else {
                return ResponseEntity.status(500).body("Schedule with Id : " + scheduleId + " Not Found");
            }
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @PostMapping(path = "/schedules/createNewSchedule") // finish
    public ResponseEntity<?> createNewSchedule(@RequestHeader("authtoken") String authtoken,
            @RequestBody AddSchedule addSchedule) {
        try {
            String authEmployeeID = tokenService.verifyJWTToken(authtoken);
            if (authEmployeeID == "error") {
                return ResponseEntity.status(400)
                        .body("Auth Time Out");
            }

            // check is employee present
            Optional<Employee> employee = employeeService.getEmployeeById(addSchedule.getEmployeeId());
            if (!employee.isPresent()) {
                return ResponseEntity.status(400)
                        .body("Employee with ID : " + addSchedule.getEmployeeId() + " dose not exits");
            }

            // check is employee busy
            boolean isBusy = false;
            // get every ScheduleId of employee
            List<TakeSchedule> takeSchedules = takeScheduleService
                    .getTakeScheduleByEmployeeId(addSchedule.getEmployeeId());
            for (TakeSchedule takeSchedule : takeSchedules) {
                // check is busy
                isBusy = scheduleService.isBusy(addSchedule.getScheduleStart(), addSchedule.getScheduleEnd(),
                        takeSchedule.getScheduleId());
                if (isBusy) {
                    return ResponseEntity.status(400).body("Employee Busy");
                }
            }

            // check is schedule taken
            boolean isAvaliable = scheduleService.isAvaliable(
                    addSchedule.getScheduleLocation(),
                    addSchedule.getScheduleDate(),
                    addSchedule.getScheduleStart(),
                    addSchedule.getScheduleEnd(), 0);
            if (!isAvaliable) {
                return ResponseEntity.status(400).body("Location is taken at that time");
            }

            // craete schedule & get schedule
            Schedule schedule = scheduleService.createNewSchedule(addSchedule);
            if (schedule == null) {
                return ResponseEntity.status(400).body("Can't create schedule");
            }

            // craete take Schedule
            String data = takeScheduleService.createNewTakeSchedule(schedule.getScheduleId(),
                    addSchedule.getEmployeeId());
            if (data == "Create Success") {
                return ResponseEntity.ok().body(data);
            } else {
                return ResponseEntity.status(400).body("Can't create takeSchedule");
            }

        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @PutMapping(path = "/schedules/update") // finish
    public ResponseEntity<?> updateSchedule(@RequestHeader("authtoken") String authtoken,
            @RequestBody UpdateSchedule updateSchedule) {
        // if don't want to update schedule status -> sent true
        try {
            String authEmployeeID = tokenService.verifyJWTToken(authtoken);
            if (authEmployeeID == "error") {
                return ResponseEntity.status(400)
                        .body("Auth Time Out");
            }

            // get schedule & check is Schedule present
            Optional<Schedule> schedule = scheduleService.getScheduleById(updateSchedule.getScheduleId());
            if (!schedule.isPresent()) {
                return ResponseEntity.status(400)
                        .body("Schedule with ID : " + updateSchedule.getScheduleId() + " dose not exist");
            }

            // assign variable
            String location = schedule.get().getScheduleLocation();
            LocalDate date = schedule.get().getScheduleDate();
            LocalDateTime start = schedule.get().getScheduleStart();
            LocalDateTime end = schedule.get().getScheduleEnd();
            if (updateSchedule.getScheduleLocation() != "") {
                location = updateSchedule.getScheduleLocation();
            }
            if (updateSchedule.getScheduleDate() != null) {
                date = updateSchedule.getScheduleDate();
            }
            if (updateSchedule.getScheduleStart() != null) {
                start = updateSchedule.getScheduleStart();
            }
            if (updateSchedule.getScheduleEnd() != null) {
                end = updateSchedule.getScheduleEnd();
            }

            // check is Employee present (if update employeeId)
            if (updateSchedule.getAppointmentDoctorId() != 0) {
                Optional<Employee> employee = employeeService.getEmployeeById(updateSchedule.getAppointmentDoctorId());
                if (!employee.isPresent()) {
                    return ResponseEntity.status(400)
                            .body("Employee with ID : " + updateSchedule.getAppointmentDoctorId() + " dose not exits");
                }
            }

            // check can update capacity (if update capacity)
            if (updateSchedule.getScheduleCapacity() != 0) {
                List<Appointment> appointments = appointmentService
                        .getAppointmentByScheduleId(updateSchedule.getScheduleId());
                if (appointments.size() > updateSchedule.getScheduleCapacity()) {
                    return ResponseEntity.status(400).body("Schedule capacity is less then present patient");
                }
            }

            boolean isBusy = false;
            // check is employee busy (if update start,end,date,employeeId)
            if (updateSchedule.getScheduleDate() != null || updateSchedule.getScheduleStart() != null
                    || updateSchedule.getScheduleEnd() != null || updateSchedule.getAppointmentDoctorId() != 0) {
                List<TakeSchedule> takeSchedules = new ArrayList<>();
                // if update employeeId -> check new employeeId
                if (updateSchedule.getAppointmentDoctorId() != 0) {
                    takeSchedules = takeScheduleService
                            .getTakeScheduleByEmployeeId(updateSchedule.getAppointmentDoctorId());
                } else {
                    // if not update employeeId -> check old employeeId
                    Optional<TakeSchedule> takeSchedule = takeScheduleService
                            .getTakeScheduleByScheduleId(updateSchedule.getScheduleId());
                    takeSchedules = takeScheduleService.getTakeScheduleByEmployeeId(takeSchedule.get().getEmployeeId());
                }
                for (TakeSchedule takeSchedule : takeSchedules) {
                    // check is employee busy
                    if (takeSchedule.getScheduleId() != updateSchedule.getScheduleId()) { // not check itself
                        isBusy = scheduleService.isBusy(start, end, takeSchedule.getScheduleId());
                        if (isBusy) {
                            return ResponseEntity.status(400).body("Employee Busy");
                        }
                    }
                }
            }

            // check is patient busy (if update start,end,date)
            if (updateSchedule.getScheduleDate() != null || updateSchedule.getScheduleStart() != null
                    || updateSchedule.getScheduleEnd() != null) {
                // get list of patients of schedule
                List<Appointment> appointments = appointmentService
                        .getAppointmentByScheduleId(updateSchedule.getScheduleId());
                for (Appointment appointment : appointments) {
                    // check is patient busy
                    isBusy = appointmentService.isPatientBusy(start, end, appointment.getAppointmentPatientId(),
                            updateSchedule.getScheduleId());
                    if (isBusy) {
                        return ResponseEntity.status(400).body("Patient Busy");
                    }
                }
            }

            // check is schedule taken (if update start,end,date,location)
            if (updateSchedule.getScheduleDate() != null || updateSchedule.getScheduleStart() != null
                    || updateSchedule.getScheduleEnd() != null || updateSchedule.getScheduleLocation() != null) {
                boolean isAvaliable = scheduleService.isAvaliable(location, date, start, end,
                        updateSchedule.getScheduleId());
                if (!isAvaliable) {
                    return ResponseEntity.status(400).body("Location is taken at that time");
                }
            }

            // update appointment , return list of patientHNId of edited appointment <-- can
            // empty
            List<Long> patientHNId = appointmentService
                    .updateApponimentFromSchedule(updateSchedule.getScheduleId(),
                            updateSchedule.getScheduleStart(),
                            updateSchedule.getScheduleEnd(),
                            updateSchedule.getScheduleDate(),
                            updateSchedule.getScheduleLocation(),
                            updateSchedule.getAppointmentDoctorId(),
                            updateSchedule.getScheduleStatus());

            // update schedule
            scheduleService.updateSchedule(updateSchedule.getScheduleId(),
                    updateSchedule.getScheduleCapacity(),
                    updateSchedule.getScheduleStart(),
                    updateSchedule.getScheduleEnd(),
                    updateSchedule.getScheduleDate(),
                    updateSchedule.getScheduleLocation(),
                    updateSchedule.getScheduleStatus());

            // update takeSchedule
            takeScheduleService.updateTakeSchedule(updateSchedule.getScheduleId(),
                    updateSchedule.getAppointmentDoctorId());

            if (patientHNId.isEmpty()) { // if list of patientHNId of edited appointment is empty
                return ResponseEntity.ok()
                        .body("Schedule with ID: " + updateSchedule.getScheduleId() + " has update successfully");
            }
            return ResponseEntity.ok().body(patientHNId);

        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

    @GetMapping(path = "/getScheduleBytpye/{id}")
    public ResponseEntity<?> getScheduleBytpye(@PathVariable("id") int type) {
        try {
            List<Schedule> data = scheduleService.getScheduleByType(type);
            List<JSONObject> objects = new ArrayList<>();
            for (Schedule s : data) {
                List<Appointment> appointments = appointmentService.getAppointmentByScheduleId(s.getScheduleId());
                Optional<TakeSchedule> takeSchedule = takeScheduleService
                        .getTakeScheduleByScheduleId(s.getScheduleId());
                Optional<Employee> e = employeeService.getEmployeeById(takeSchedule.get().getEmployeeId());
                JSONObject _object = new JSONObject();
                System.out.println(e);
                _object.put("docterFirstName", e.get().getEmployeeFirstName());
                _object.put("docterMiddleName", e.get().getEmployeeMiddleName());
                _object.put("docterLastName", e.get().getEmployeeLastName());
                _object.put("docterDepartMent", e.get().getEmployeeDepartment());
                _object.put("scheduleId", s.getScheduleId());
                _object.put("scheduleType", s.getScheduleType());
                _object.put("scheduleDate", s.getScheduleDate());
                _object.put("scheduleStartTIme", s.getScheduleStart());
                _object.put("scheduleFinishTime", s.getScheduleEnd());
                _object.put("scheduleCapacity", s.getScheduleCapacity());
                _object.put("patientCount", appointments.size());
                objects.add(_object);
            }

            return ResponseEntity.ok().body(objects);
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body(e);
        }
    }
}
