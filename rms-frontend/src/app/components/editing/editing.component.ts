import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';

import { Dish } from '../../models/dish.model';
import { DishService } from '../../services/dish.service';
import { appConfig } from '../../configs/app.config';
import { IDropdownItem } from '../shared/models/dropdown-item.interface';

@Component({
  selector: 'app-editing',
  templateUrl: './editing.component.html',
  styleUrls: ['./editing.component.less'],
  providers: [DishService]
})
export class EditingComponent implements OnInit {
  incorrectData: Boolean = false;
  operationName: String = 'create';
  selectedDish: Dish;
  editedDish: Dish = {
    id: null,
    name: '',
    description: '',
    cost: null,
    weight: null,
    nutritionalValue: null,
    isAvailable: false,
    category: {
      id: null,
      name: null
    }
  };
  dishOptionsCache: Array<any> = [];
  categoryOptionsCache: Array<any> = [];

  constructor(private dishService: DishService) { }

  ngOnInit() {
    this.dishService.dishDropdownPromise
      .then((data) => {
        this.dishOptionsCache = data;
      });

    this.dishService.categoryDropdownPromise
      .then((data) => {
        this.categoryOptionsCache = data;
      })
  }

  onDishSelect(id: number) {
    this.selectedDish = this.dishOptionsCache
      .find((dish) => dish.id == id);
    
    this.editedDish = { ...this.selectedDish };
  }

  setDishCategory(id: number) {
    this.editedDish.category = this.categoryOptionsCache
      .find((dish) => dish.id == id);
  }

  chooseOperation(event) {
    this.operationName = event.path[0].name;
    this.incorrectData = false;
  }

  checkEnteredData() {
    const { name, description, cost, weight, nutritionalValue } = this.editedDish;
    switch (this.operationName) {
      case 'create': {
        console.log('create');
        if (name && description && cost && weight && nutritionalValue /* && this.dishCategory*/) {
            this.incorrectData = false;
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

  autocompleteOptions = (searchInput: string) => (
    this.dishService.getDishAutocompleteOptions(searchInput)
  )
}
