package com.medicare_backend.medicare_backend.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.medicare_backend.medicare_backend.repository.LogNotificationRepository;
import com.medicare_backend.medicare_backend.schema.entity.LogNotification;

@Service
public class LogNotificationService {

    private final LogNotificationRepository logNotificationRepository;

    public LogNotificationService(LogNotificationRepository logNotificationRepository) {
        this.logNotificationRepository = logNotificationRepository;
    }
    public List<LogNotification> getLogNotification() {
        return logNotificationRepository.findAll();
    }

    public Optional<LogNotification> getLogNotificationById(long l) {
        return logNotificationRepository.findBylogNotificationId(l);
    }

    public String createLogNotification (LogNotification logNotification){
        logNotificationRepository.save(logNotification);
        return "Suscess";
    }

    
}
