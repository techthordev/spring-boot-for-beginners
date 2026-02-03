package br.com.techthordev.cruddemo.dao;

import br.com.techthordev.cruddemo.entity.Employee;

import java.util.List;

public interface EmployeeDAO {

    List<Employee> findAll();


    Employee findById(int theId);

    Employee save(Employee theEmployee);

    void deleteById(int theId);
    

}
