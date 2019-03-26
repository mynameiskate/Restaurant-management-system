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

  constructor(private dishService: DishService) { }

  getImageUrl(imageId) {
    return appConfig.imageUrl + imageId;
  }

  ngOnInit() {
    this.dishService.getDishes()
      .subscribe(res => this.dishes = res);
  }

}
