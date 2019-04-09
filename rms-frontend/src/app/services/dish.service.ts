import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

import { Dish } from '../models/dish.model';
import { RouteHelper } from '../helpers/route.helper';

@Injectable()
export class DishService {
  constructor(
    private http: HttpClient,
    private routeHelper: RouteHelper) {}

  getDishes(): Observable<Dish[]> {
    return this.http.get<Dish[]>(this.routeHelper.dishRoute);
  }

  updateDish(dish: Dish): Observable<any> {
    const url = this.routeHelper
      .construct(this.routeHelper.dishRoute, dish.id);
    return this.http.put<Dish>(url, dish);
  }

  createDish(dish: Dish): Observable<Dish> {
    return this.http.post<Dish>(this.routeHelper.dishRoute, dish);
  }

  deleteDish(dishId: number): Observable<any> {
    const url = this.routeHelper
      .construct(this.routeHelper.dishRoute, dishId);
    return this.http.delete(url);
  }
}