package com.medicare_backend.medicare_backend.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.medicare_backend.medicare_backend.schema.entity.Employee;
import com.medicare_backend.medicare_backend.schema.entity.Patient;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    List<Employee> findByEmployeeNationalId(String employeeNationalId);

    List<Employee> findByEmployeeRole(Long employeeRoleId);
    
    Employee save(Optional<Employee> _employee);



    // List<Employee> findByEmployeeFirstNameAndEmployeeLastName(String
    // employeeFirstName, String employeeLastName);

}
