import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { Dish } from '../../models/dish.model';
import { DishService } from '../../services/dish.service';
import { appConfig } from '../../configs/app.config';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.less'],
  providers: [DishService]
})
export class MenuComponent implements OnInit {
  dishes: Dish[] = [];
  choosedDishes = [];

  constructor(private dishService: DishService) { }

  getImageUrl(imageId) {
    return appConfig.imageUrl + imageId;
  }

  ngOnInit() {
    this.dishService.getDishes()
      .subscribe(res => {
        this.dishes = res;
        //temp
        for (let dish of this.dishes) {
          dish.isAvaliable = true;
        }
      }); 
  }

  chooseDish(choosedDish) {
    if (this.choosedDishes.every(element => element.name != choosedDish.name)) {
      choosedDish.isChoosed = true;
      this.choosedDishes.push(choosedDish);
    } else {
      choosedDish.isChoosed = false;
      this.choosedDishes = this.choosedDishes.filter(element => element.name != choosedDish.name);
    }
  }

  createOrder() {
    console.log(this.choosedDishes);
  }
}
