import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

import { Dish } from '../models/dish.model';
import { appConfig } from '../configs/app.config';


@Injectable()
export class DishService {
  constructor(private http: HttpClient) {}

  getDishes(): Observable<Dish[]> {
    return this.http.get<Dish[]>(appConfig.dishUrl);
  }
}