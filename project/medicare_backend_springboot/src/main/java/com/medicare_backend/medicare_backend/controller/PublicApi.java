package com.medicare_backend.medicare_backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.medicare_backend.medicare_backend.proxy.PublicApiProxy;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;
import com.medicare_backend.medicare_backend.service.ScheduleService;

@EnableCaching
@RestController
public class PublicApi {
    
    @Autowired
    private PublicApiProxy publicApiProxy;

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping(path = "/getSlotTime")
    public ResponseEntity<?> getSchedule() {
        try {
            List<Schedule> data = publicApiProxy.getAllSchedule();
            if (!(data != null && data.isEmpty())) {
                return ResponseEntity.ok().body(data);
            } else {
                return ResponseEntity.status(400).body("Not Found Data");
            }
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(500).body("server error");
        }
    }

}
