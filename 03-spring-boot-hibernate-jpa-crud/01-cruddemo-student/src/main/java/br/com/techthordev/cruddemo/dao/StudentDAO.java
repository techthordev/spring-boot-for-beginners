package br.com.techthordev.cruddemo.dao;

import java.util.List;

import br.com.techthordev.cruddemo.entity.Student;

public interface StudentDAO {

	void save(Student theStudent);
	
	Student findById(Integer id);
	
	List<Student> findAll();
	
	List<Student> findByLastName(String lastName);
	
	void update(Student theStudent);
	
	void delete(Integer id);
	
	int deleteAll();
	
}