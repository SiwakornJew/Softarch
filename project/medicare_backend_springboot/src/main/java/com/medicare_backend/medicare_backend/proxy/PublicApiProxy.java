package com.medicare_backend.medicare_backend.proxy;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.medicare_backend.medicare_backend.schema.entity.Schedule;

public interface PublicApiProxy {
    List<Schedule> getAllSchedule();
}
