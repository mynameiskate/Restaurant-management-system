import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { Dish } from './models/dish.model';
import { DishService } from './services/dish.service';
import { appConfig } from './configs/app.config';
import { UserService } from './services/user.service';
import { Employee } from './models/employee.model';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.less'],
  providers: [DishService,
    UserService]
})
export class AppComponent implements OnInit {
  title = 'rms-frontend';
  dishes: Dish[] = [];
  employees: Employee[] = [];

  constructor(private dishService: DishService,
    private userService: UserService) {
  }

  getImageUrl(imageId) {
    return appConfig.imageUrl + imageId;
  }

  ngOnInit() {
    this.dishService.getDishes()
      .subscribe(res => this.dishes = res);
    
    this.userService.getEmployees()
      .subscribe(res => {this.employees = res; console.log(res)});
  }
}
