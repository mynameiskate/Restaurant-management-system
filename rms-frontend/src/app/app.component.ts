import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { Dish } from './models/dish.model';
import { DishService } from './services/dish.service';

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

  ngOnInit() {
    this.dishService.getDishes()
      .subscribe(res => this.dishes = res);
  }
}
