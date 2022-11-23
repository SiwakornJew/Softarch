package com.medicare_backend.medicare_backend.schema.entity;

import javax.persistence.*;

@Entity
@Table(name = "employee")
public class Employee {

    private long employeeId;
    private String employeeFirstName;
    private String employeeMiddleName;
    private String employeeLastName;
    private String employeeNationalId;
    private boolean employeeIsAdmin;
    private String employeePhoneNumber;
    private long employeeRole;
    private long employeeDepartment;
    private String employeePassword;

    public Employee() {

    }

    public Employee(String employeeFirstName, String employeeMiddleName,
            String employeeLastName, String employeeNationalId, boolean employeeIsAdmin, String employeePhoneNumber,
            long employeeRole, long employeeDepartment, String employeePassword) {

        this.employeeFirstName = employeeFirstName;
        this.employeeMiddleName = employeeMiddleName;
        this.employeeLastName = employeeLastName;
        this.employeeNationalId = employeeNationalId;
        this.employeeIsAdmin = employeeIsAdmin;
        this.employeePhoneNumber = employeePhoneNumber;
        this.employeeRole = employeeRole;
        this.employeeDepartment = employeeDepartment;
        this.employeePassword = employeePassword;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(long employeeId) {
        this.employeeId = employeeId;
    }

    @Column(name = "employeeFirstName", nullable = false)
    public String getEmployeeFirstName() {
        return this.employeeFirstName;
    }

    public void setEmployeeFirstName(String employeeFirstName){
        this.employeeFirstName = employeeFirstName;
    }
    
    @Column(name = "employeeMiddleName")
    public String getEmployeeMiddleName() {
        return this.employeeMiddleName;
    }

    public void setEmployeeMiddleName(String employeeMiddleName){
        this.employeeMiddleName = employeeMiddleName;
    }
    
    @Column(name = "employeeLastName", nullable = false)
    public String getEmployeeLastName() {
        return this.employeeLastName;
    }

    public void setEmployeeLastName(String employeeLastName){
        this.employeeLastName = employeeLastName;
    }

    @Column(name = "employeeNationalId", nullable = false)
    public String getEmployeeNationalId() {
        return employeeNationalId;
    }

    public void setEmployeeNationalId(String employeeNationalId) {
        this.employeeNationalId = employeeNationalId;
    }

    @Column(name = "employeeIsAdmin", nullable = false)
    public boolean getEmployeeIsAdmin() {
        return this.employeeIsAdmin;
    }

    public void setEmployeeIsAdmin(boolean employeeIsAdmin){
        this.employeeIsAdmin = employeeIsAdmin;
    }

    @Column(name = "employeePhoneNumber", nullable = false)
    public String getEmployeePhoneNumber() {
        return this.employeePhoneNumber;
    }

    public void setEmployeePhoneNumber(String employeePhoneNumber){
        this.employeePhoneNumber = employeePhoneNumber;
    }

    @Column(name = "employeeRole", nullable = false)
    public long getEmployeeRole() {
        return this.employeeRole;
    }

    public void setEmployeeRole(long employeeRole){
        this.employeeRole = employeeRole;
    }

    @Column(name = "employeeDepartment", nullable = false)
    public long getEmployeeDepartment() {
        return this.employeeDepartment;
    }

    public void setEmployeeDepartment(long employeeDepartment){
        this.employeeDepartment = employeeDepartment;
    }

    @Column(name = "employeePassword", nullable = false)
    public String getEmployeePassword() {
        return employeePassword;
    }

    public void setEmployeePassword(String employeePassword) {
        this.employeePassword = employeePassword;
    }

}
