package com.medicare_backend.medicare_backend.repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import com.medicare_backend.medicare_backend.schema.entity.Schedule;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Long> {

    List<Schedule> findByScheduleDateAndScheduleLocation(LocalDate scheduleDate, String scheduleLocation);

    List<Schedule> findByScheduleType(int type);
}
