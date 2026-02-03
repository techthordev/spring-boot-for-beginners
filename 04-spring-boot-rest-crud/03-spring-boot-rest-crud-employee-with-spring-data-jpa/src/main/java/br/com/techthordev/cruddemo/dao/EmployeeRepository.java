package br.com.techthordev.cruddemo.dao;

import br.com.techthordev.cruddemo.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

    List<Employee> findAllByOrderByIdAsc();
    // that's it ... no need to write any code LOL!
}
