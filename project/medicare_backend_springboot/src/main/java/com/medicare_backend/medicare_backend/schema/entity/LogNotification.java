package com.medicare_backend.medicare_backend.schema.entity;


import java.time.LocalDateTime;

import javax.persistence.*;



@Entity
@Table(name = "logNotification")
public class LogNotification {

    private long logNotificationId;
    private long logNotificationType;
    private String logNotificationTitle;
    private String logNotificationBody;
    private long logNotificationAppointmentID;

    private LocalDateTime logNotificationDateCreated;

    public LogNotification() {

    }

    public LogNotification(long logNotificationType, String logNotificationTitle,
            String logNotificationBody, long logNotificationAppointmentID, LocalDateTime logNotificationDateCreated) {

        this.logNotificationType = logNotificationType;
        this.logNotificationTitle = logNotificationTitle;
        this.logNotificationBody = logNotificationBody;
        this.logNotificationAppointmentID = logNotificationAppointmentID;
        this.logNotificationDateCreated = logNotificationDateCreated;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getlogNotificationId() {
        return logNotificationId;
    }

    public void setlogNotificationId(Long logNotificationId) {
        this.logNotificationId = logNotificationId;
    }

    @Column(name = "logNotification_Type", nullable = false)
    public long getLogNotificationType() {
        return logNotificationType;
    }

    public void setLogNotificationType(long logNotificationType) {
        this.logNotificationType = logNotificationType;
    }

    @Column(name = "logNotification_Title", nullable = false)
    public String getLogNotificationTitle() {
        return logNotificationTitle;
    }

    public void setLogNotificationTitle(String logNotificationTitle) {
        this.logNotificationTitle = logNotificationTitle;
    }

    @Column(name = "logNotification_Body", nullable = false)
    public String getLogNotificationBody() {
        return logNotificationBody;
    }

    public void setLogNotificationBody(String logNotificationBody) {
        this.logNotificationBody = logNotificationBody;
    }

    @Column(name = "logNotificationAppointmentID", nullable = false)
    public long getLogNotificationAppointmentID() {
        return logNotificationAppointmentID;
    }

    public void setLogNotificationAppointmentID(long logNotificationAppointmentID) {
        this.logNotificationAppointmentID = logNotificationAppointmentID;
    }
    

    @Column(name = "logNotification_DateCreated", nullable = false)
    public LocalDateTime getLogNotificationDateCreated() {
        return logNotificationDateCreated;
    }

    public void setLogNotificationDateCreated(LocalDateTime logNotificationDateCreated) {
        this.logNotificationDateCreated = logNotificationDateCreated;
    }
}
