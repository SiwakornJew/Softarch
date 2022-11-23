package com.medicare_backend.medicare_backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicare_backend.medicare_backend.repository.ScheduleRepository;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;
import com.medicare_backend.medicare_backend.schema.request.AddSchedule;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.transaction.Transactional;

@Service
public class ScheduleService {

    private ScheduleRepository scheduleRepository;
    private CompareDatetime compareDatetime = new CompareDatetime();

    @Autowired
    public ScheduleService(ScheduleRepository scheduleRepository) {
        this.scheduleRepository = scheduleRepository;
    }

    // Get all Schedule
    public List<Schedule> getSchedule() {
        return scheduleRepository.findAll();
    }

    // Get schedule by Id
    public Optional<Schedule> getScheduleById(Long scheduleId) {
        return scheduleRepository.findById(scheduleId);
    }

    public List<Schedule> getScheduleByType(int type) {
        return scheduleRepository.findByScheduleType(type);
    }

    // Post create new schedule
    public Schedule createNewSchedule(AddSchedule addSchedule) {
        Schedule schedule = new Schedule(addSchedule.getScheduleCapacity(),
                addSchedule.getScheduleStart(),
                addSchedule.getScheduleEnd(),
                addSchedule.getScheduleDate(),
                addSchedule.getScheduleLocation(),
                addSchedule.getScheduleType());
        scheduleRepository.save(schedule);
        return schedule;
    }

    // update schedule
    @Transactional
    public void updateSchedule(long scheduleId,
            int scheduleCapacity,
            LocalDateTime scheduleStart,
            LocalDateTime scheduleEnd,
            LocalDate scheduleDate,
            String scheduleLocation,
            boolean scheduleStatus) {
        Schedule schedule = scheduleRepository.findById(scheduleId)
                .orElseThrow(() -> new IllegalStateException(
                        "Schedule with ID : " + scheduleId + " dose not exist"));
        if (scheduleCapacity != 0 && !Objects.equals(schedule.getScheduleCapacity(), scheduleCapacity)) {
            schedule.setScheduleCapacity(scheduleCapacity);
        }
        if (scheduleStart != null && !Objects.equals(schedule.getScheduleStart(), scheduleStart)) {
            schedule.setScheduleStart(scheduleStart);
        }
        if (scheduleEnd != null && !Objects.equals(schedule.getScheduleEnd(), scheduleEnd)) {
            schedule.setScheduleEnd(scheduleEnd);
        }
        if (scheduleDate != null && !Objects.equals(schedule.getScheduleDate(), scheduleDate)) {
            schedule.setScheduleDate(scheduleDate);
        }
        if (scheduleLocation != null && scheduleLocation.length() > 0
                && !Objects.equals(schedule.getScheduleLocation(), scheduleLocation)) {
            schedule.setScheduleLocation(scheduleLocation);
        }
        if (scheduleStatus != schedule.getScheduleStatus()) {
            schedule.setScheduleStatus(scheduleStatus);
        }
    }

    // check is schedule overlap on start,end time
    public boolean isBusy(LocalDateTime scheduleStart, LocalDateTime scheduleEnd, long scheduleId) {
        // get schedule
        Schedule schedule = scheduleRepository.findById(scheduleId)
                .orElseThrow(() -> new IllegalStateException(
                        "Schedule with ID : " + scheduleId + " dose not exist"));

        // if schedule is past or status is false don't need to check
        if (schedule.getScheduleDate().isBefore(LocalDate.now()) || !schedule.getScheduleStatus()) {
            return false;
        }

        return compareDatetime.isOverlap(scheduleStart, scheduleEnd, schedule.getScheduleStart(),
                schedule.getScheduleEnd());
    }

    // check is location at time avaliable
    public boolean isAvaliable(String scheduleLocation, LocalDate scheduleDate, LocalDateTime scheduleStart,
            LocalDateTime scheduleEnd, long IdofcurrentSchedule) {
        List<Schedule> schedules = scheduleRepository.findByScheduleDateAndScheduleLocation(scheduleDate,
                scheduleLocation);
        for (Schedule schedule : schedules) {
            // don't check itself
            if (schedule.getScheduleId() != IdofcurrentSchedule) {
                if (compareDatetime.isOverlap(scheduleStart, scheduleEnd, schedule.getScheduleStart(),
                        schedule.getScheduleEnd())) {
                    return false;
                }

            }
        }
        return true;
    }

}
