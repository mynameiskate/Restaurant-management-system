import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

import { Employee } from '../models/employee.model';
import { appConfig } from '../configs/app.config'


@Injectable()
export class UserService {
  constructor(private http: HttpClient) {}

  getEmployees(): Observable<Employee[]> {
    return this.http.get<Employee[]>(appConfig.employeeUrl);
  }
}