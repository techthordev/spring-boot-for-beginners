import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Employee } from '../models/model';
import { PageResponse } from '../models/page-response';

@Injectable({
  providedIn: 'root',
})
export class EmployeeService {
  
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:8080/api/employees';
  
  getEmployees(): Observable<PageResponse<Employee>> {
    return this.http.get<PageResponse<Employee>>(
      `${this.apiUrl}?page=0&size=50&sort=id,asc`
    );
  }
  
  getEmployeeById(id: number): Observable<Employee> {
      return this.http.get<Employee>(`${this.apiUrl}/${id}`);
  }
  
  addEmployee(employee: Employee): Observable<Employee> {
    return this.http.post<Employee>(this.apiUrl, employee);
  }
  
  updateEmployee(id: number, employee: Employee): Observable<Employee> {
      return this.http.put<Employee>(`${this.apiUrl}/${id}`, employee);
  }
  
  patchEmployee(id: number, changes: Partial<Employee>): Observable<Employee> {
      return this.http.patch<Employee>(`${this.apiUrl}/${id}`, changes);
  }
  
  deleteEmployee(id: number): Observable<string> {
    return this.http.delete(`${this.apiUrl}/${id}`, { responseType: 'text' });
  }
}
