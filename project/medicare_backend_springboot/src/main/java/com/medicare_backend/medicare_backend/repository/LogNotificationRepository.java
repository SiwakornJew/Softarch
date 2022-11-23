package com.medicare_backend.medicare_backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.medicare_backend.medicare_backend.schema.entity.LogNotification;

@Repository
public interface LogNotificationRepository extends JpaRepository<LogNotification, Long > {
    
    List<LogNotification> findByLogNotificationId(Long logNotificationId);
    Optional<LogNotification> findBylogNotificationId(long l);
   
    
}
