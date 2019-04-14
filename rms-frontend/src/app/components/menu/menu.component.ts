import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Router } from '@angular/router';

import { Dish } from '../../models/dish.model';
import { DishService } from '../../services/dish.service';
import { appConfig } from '../../configs/app.config';
import { RouteHelper } from 'src/app/helpers/route.helper';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.less'],
  providers: [DishService]
})
export class MenuComponent implements OnInit {
  dishes: Dish[] = [];
  choosedDishes = [];

  constructor(private dishService: DishService,
    private routeHelper: RouteHelper,
    private router: Router) { }

  getImageUrl(imageId) {
    return `${this.routeHelper.imageRoute}/${imageId}`;
  }

  ngOnInit() {
    this.dishService.getDishes()
      .subscribe(res => {
        this.dishes = res;
        console.log(this.dishes);
      }); 
  }

  chooseDish(choosedDish) {
    if (choosedDish.isAvailable) {
      if (this.choosedDishes.every(element => element.name != choosedDish.name)) {
        choosedDish.isChoosed = true;
        this.choosedDishes.push(choosedDish);
      } else {
        choosedDish.isChoosed = false;
        this.choosedDishes = this.choosedDishes.filter(element => element.name != choosedDish.name);
      }
    }
  }

  createOrder() {
    console.log(this.choosedDishes);
  }

  updateDish(dish) {
    localStorage.setItem('editingDish', JSON.stringify(dish));
    localStorage.setItem('operationName', 'update');
  }

  deleteDish(dish) {
    localStorage.setItem('editingDish', JSON.stringify(dish));
    localStorage.setItem('operationName', 'delete');
  }
}
