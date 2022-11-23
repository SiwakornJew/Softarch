package com.medicare_backend.medicare_backend.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.medicare_backend.medicare_backend.proxy.PublicApiProxy;
import com.medicare_backend.medicare_backend.schema.entity.Schedule;

@Service
public class PublicApiService implements PublicApiProxy {

    private ScheduleService scheduleService;

    public PublicApiService(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    public List<Schedule> getAllSchedule() {
        try {
            List<Schedule> data = scheduleService.getSchedule();
            return data;
        } catch (Exception e) {
            System.out.println(e);
            List<Schedule> tempList = new ArrayList<Schedule>();
            return tempList;
        }
    }

}
