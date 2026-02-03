import { Component, OnInit, signal, inject } from '@angular/core';
import { EmployeeService } from './services/employee';
import { Employee } from './models/model';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { EmployeeDialog } from './dialogs/employee-dialogs/employee-dialog/employee-dialog';
import { PageResponse } from './models/page-response';

@Component({
  selector: 'app-root',
  imports: [
    CommonModule,
    MatTableModule,
    MatButtonModule,
    MatIconModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
  ],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App implements OnInit {
  private service = inject(EmployeeService);
  private dialog = inject(MatDialog);

  protected readonly title = signal('Employee Directory');
  protected employees = signal<Employee[]>([]);
  protected displayedColumns: string[] = ['id', 'firstName', 'lastName', 'email', 'actions'];

  ngOnInit() {
    this.loadEmployees();
  }

  loadEmployees() {
    this.service.getEmployees().subscribe(data => {
      this.employees.set(data._embedded?.employees ?? []);
    });
  }

  // CREATE
  onAdd() {
    const dialogRef = this.dialog.open(EmployeeDialog, {
      width: '400px',
      data: { firstName: '', lastName: '', email: '' } as Employee,
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.service.addEmployee(result).subscribe(() => this.loadEmployees());
      }
    });
  }

  // UPDATE
  patchEmployee(employee: Employee) {
    const dialogRef = this.dialog.open(EmployeeDialog, {
      width: '400px',
      data: { ...employee }
    });
  
    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        const { id, ...changes } = result;
        this.service.patchEmployee(employee.id!, changes)
          .subscribe(() => this.loadEmployees());
      }
    });
  }
  
  // updateEmployee(employee: Employee) {
  //   const dialogRef = this.dialog.open(EmployeeDialog, {
  //     width: '400px',
  //     data: { ...employee }
  //   });
  
  //   dialogRef.afterClosed().subscribe(result => {
  //     if (result) {
  //       this.service.updateEmployee(employee.id!, result)
  //         .subscribe(() => this.loadEmployees());
  //     }
  //   });
  // }

  // DELETE
  onDelete(id: number) {
    if (confirm('Delete this entry?')) {
      this.service.deleteEmployee(id).subscribe(() => this.loadEmployees());
    }
  }
}
