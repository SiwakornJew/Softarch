package com.medicare_backend.medicare_backend.service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.medicare_backend.medicare_backend.repository.TakeScheduleRepository;
import com.medicare_backend.medicare_backend.schema.relationship.TakeSchedule;

@Service
public class TakeScheduleService {
    private TakeScheduleRepository takeScheduleRepository;

    @Autowired
    public TakeScheduleService(TakeScheduleRepository takeScheduleRepository){
        this.takeScheduleRepository = takeScheduleRepository;
    }
    
    //Get all takeSchedule
    public List<TakeSchedule> getTakeSchedule(){
        return takeScheduleRepository.findAll();
    }

    //Get takeSchedule by scheduleId
    public Optional<TakeSchedule> getTakeScheduleByScheduleId(long scheduleId){
        return takeScheduleRepository.findTakeScheduleByscheduleId(scheduleId);
    }

    //Get takeSchedule by employeeId
    public List<TakeSchedule> getTakeScheduleByEmployeeId(long employeeId){
        return takeScheduleRepository.findTakeScheduleByemployeeId(employeeId);
    }

    //Create takeSchedule
    public String createNewTakeSchedule(long scheduleId, long employeeId) {
        TakeSchedule takeSchedule = new TakeSchedule(employeeId,scheduleId);
        takeScheduleRepository.save(takeSchedule);
        return "Create Success";
    }

    //update appointmentDoctorId
    @Transactional
    public void updateTakeSchedule(long scheduleId, long appointmentDoctorId) {
        TakeSchedule takeSchedule = takeScheduleRepository.findTakeScheduleByscheduleId(scheduleId)
            .orElseThrow(() -> new IllegalStateException(
                "takeSchedule with scheduleId : " + scheduleId + " dose not exist"
            ));
            
        if(appointmentDoctorId != 0 && !Objects.equals(takeSchedule.getEmployeeId(), appointmentDoctorId))
        {
            takeSchedule.setEmployeeId(appointmentDoctorId);
        }
    }
}
