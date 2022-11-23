package com.medicare_backend.medicare_backend.controller;

import org.springframework.web.bind.annotation.RestController;

import com.medicare_backend.medicare_backend.repository.LogNotificationRepository;
import com.medicare_backend.medicare_backend.schema.entity.LogNotification;
import com.medicare_backend.medicare_backend.service.LogNotificationService;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@RestController
public class LogNotificationController {

    @Autowired
    private LogNotificationRepository logNotificationRepository;
    private LogNotificationService logNotificationService;

    public LogNotificationController(LogNotificationService logNotificationService) {
        this.logNotificationService = logNotificationService;
    }
    
    @GetMapping(path = "/logNotificationinfo/findbyId/{id}")
    public ResponseEntity<?> getLogNotificationById(@PathVariable("id") long logNotificationId) {
        Optional<LogNotification> data = logNotificationService.getLogNotificationById(logNotificationId);

        if (data.isPresent()) {
            return ResponseEntity.ok().body(data);
        } else {
            return ResponseEntity.status(400).body("logNotifications with Id : " + logNotificationId + " Not Found");
        }

    }

    @PostMapping(path = "/addlogNotification")
    public ResponseEntity<?> createLogNotification(@RequestBody LogNotification logNotification) {
        try {
            
            logNotificationService.createLogNotification(logNotification);
            return ResponseEntity.ok().body(logNotification);
            
        } catch (Exception e) {
            System.out.println(e);
            return ResponseEntity.status(400).body(logNotification);
        }
    }
    
}
