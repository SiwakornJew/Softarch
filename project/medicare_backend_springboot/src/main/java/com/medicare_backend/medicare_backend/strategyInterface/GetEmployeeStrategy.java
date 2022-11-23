package com.medicare_backend.medicare_backend.strategyInterface;

import java.util.List;

import com.medicare_backend.medicare_backend.schema.entity.Employee;

public interface GetEmployeeStrategy {
    List<Employee> getEmployee();
}
