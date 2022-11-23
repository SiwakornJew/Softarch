package com.medicare_backend.medicare_backend.service;

import java.time.LocalDateTime;

public class CompareDatetime {
    
    public CompareDatetime() {
    }

    public boolean isOverlap(LocalDateTime startA, LocalDateTime endA, LocalDateTime startB, LocalDateTime endB){
        if(startA.isBefore(endB) && endA.isAfter(startB)){
            return true;
        }
        return false;
    }
}
