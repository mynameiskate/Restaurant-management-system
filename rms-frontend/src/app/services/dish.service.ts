import { Injectable, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import * as _ from 'underscore';
import { map } from 'rxjs/operators';

import { Dish } from '../models/dish.model';
import { RouteHelper } from '../helpers/route.helper';
import { IDropdownItem } from '../components/shared/models/dropdown-item.interface';

@Injectable()
export class DishService implements OnInit {
  private dishOptionsCache: Array<IDropdownItem> = [];

  constructor(
    private http: HttpClient,
    private routeHelper: RouteHelper) {}

  ngOnInit() {
    this.getDishes()
      .subscribe(data => {
        this.dishOptionsCache = this.mapDataToDropdownModel(data) || [];
      });
  }

  get dishDropdownPromise() {
    return this.getDishes()
      .pipe(map(data => 
        this.mapDataToDropdownModel(data))
      )
      .toPromise();
  }

  getDishAutocompleteOptions (searchInput: string) {
    return Promise.resolve(this.searchDishOptions(searchInput));
  }

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

  private mapDataToDropdownModel(dishes: Array<Dish>): Array<IDropdownItem> {
    return dishes.map((model) => ({...model, value: model.name}));
  }

  private searchDishOptions = (searchInput: string) => {
    return _.filter(this.dishOptionsCache,
      (item: IDropdownItem) => this.isSubstrFound(item.value, searchInput));
  }

  private isSubstrFound(text: string, substr: string): boolean {
    const normalizeStr = (str: string) => str ? str.trim().toLowerCase() : '';

    return normalizeStr(text).indexOf(normalizeStr(substr)) !== -1;
  }
}