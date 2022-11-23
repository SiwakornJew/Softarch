package com.medicare_backend.medicare_backend.strategyContext;

import java.util.List;
import com.medicare_backend.medicare_backend.schema.entity.Employee;
import com.medicare_backend.medicare_backend.strategyInterface.GetEmployeeStrategy;

public class GetEmployeeStrategyContext {

    private GetEmployeeStrategy getEmployeeStrategy;

    public GetEmployeeStrategyContext() {
        this.setStrategy(getEmployeeStrategy);
    }

    public void setStrategy(GetEmployeeStrategy getEmployeeStrategy) {
        this.getEmployeeStrategy = getEmployeeStrategy;
    }

    public List<Employee> executeGetEmployee() {
        return this.getEmployeeStrategy.getEmployee();
    }
    
}
