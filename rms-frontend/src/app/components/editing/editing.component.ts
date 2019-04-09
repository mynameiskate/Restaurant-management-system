import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { Dish } from '../../models/dish.model';
import { DishService } from '../../services/dish.service';
import { appConfig } from '../../configs/app.config';

@Component({
  selector: 'app-editing',
  templateUrl: './editing.component.html',
  styleUrls: ['./editing.component.less'],
  providers: [DishService]
})
export class EditingComponent implements OnInit {
  name: String = '';
  description: String = '';
  cost: String = '';
  weight: String = '';
  nutritionalValue: String = '';
  dishCategory: String = '';
  isAvailable: Boolean = false;

  incorrectData: Boolean = false;
  operationName: String = 'create';

  constructor(private dishService: DishService) { }

  ngOnInit() {
  }

  chooseOperation(event) {
    this.operationName = event.path[0].name;
    this.incorrectData = false;
  }

  checkEnteredData() {
    switch (this.operationName) {
      case 'create': {
        console.log('create');
        if (this.name && this.description && this.cost && this.weight && this.nutritionalValue && this.dishCategory) {
            this.incorrectData = false;
            console.log(this.name, this.description, this.cost,this.weight, this.nutritionalValue,this.dishCategory, this.isAvailable);
            // this.dishService.createDish()
            //   .subscribe(res => {
            //     console.log(res);
            // });
        } else {
          this.incorrectData = true;
        }
        break;
      }
      case 'update': {
        console.log('update');
        break;
      }
      case 'delete': {
        console.log('delete');
        break;
      }
    }
  }

  fileChange(event) {
    let fileList: FileList = event.target.files;
    console.log(fileList);
  }

}
