import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { Dish } from './models/dish.model';
import { DishService } from './services/dish.service';
import { appConfig } from './configs/app.config';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.less'],
  providers: [DishService]
})
export class AppComponent implements OnInit {
  title = 'rms-frontend';
  dishes: Dish[] = [];

  constructor(private dishService: DishService) {
  }

  getImageUrl(imageId) {
    return appConfig.imageUrl + imageId;
  }

  ngOnInit() {
    this.dishService.getDishes()
      .subscribe(res => this.dishes = res);
  }
}
