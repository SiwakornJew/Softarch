package com.medicare_backend.medicare_backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.medicare_backend.medicare_backend.schema.relationship.TakeSchedule;

public interface TakeScheduleRepository extends JpaRepository<TakeSchedule,Long> {

    Optional<TakeSchedule> findTakeScheduleByscheduleId(long scheduleId);

    List<TakeSchedule> findTakeScheduleByemployeeId(long employeeId);
    
}
