import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import {Subscription} from 'rxjs';
import { ActivatedRoute} from '@angular/router';
import { Router } from '@angular/router';

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
  private routeSubscription: Subscription;
  private querySubscription: Subscription;
  private id: number;

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

  constructor(private dishService: DishService,
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.id = parseInt(this.route.snapshot.paramMap.get('id'));
    this.operationName = this.route.snapshot.paramMap.get('operation') || 'create';

    if (this.id){
      this.dishService.getDish(this.id)
          .subscribe(res => {
            this.editedDish = res;
          });
    }

    this.dishService.dishDropdownPromise
      .then((data) => {
        this.dishOptionsCache = data;
      });

    this.dishService.categoryDropdownPromise
      .then((data) => {
        this.categoryOptionsCache = data;
      });
  }

  onDishSelect(id: number) {
    this.selectedDish = this.dishOptionsCache
      .find((dish) => dish.id == id);
    this.editedDish = { ...this.selectedDish };
    this.completeOperation();
  }

  setDishCategory(id: number) {
    this.editedDish.category = this.categoryOptionsCache
      .find((dish) => dish.id == id);
  }

  chooseOperation(event) {
    this.operationName = event.path[0].name;
    this.incorrectData = false;
    this.completeOperation();
  }

  checkEnteredData() {
    const { name, description, cost, weight, nutritionalValue, category } = this.editedDish;
    switch (this.operationName) {
      case 'create': {
        if (name && description && cost && weight && nutritionalValue && category) {
          this.incorrectData = false;
          this.dishService.createDish(this.editedDish)
            .subscribe(res => {
              console.log(res);
              alert('dish was successfully created');
            });
        } else {
          this.incorrectData = true;
        }
        break;
      }
      case 'update': {
        if (this.editedDish.id) {
          this.dishService.updateDish(this.editedDish)
            .subscribe((res) => {
              console.log(res);
              alert('dish was successfully updated');
              this.completeOperation();
            });
        }
        break;
      }
      case 'delete': {
        if (this.editedDish.id) {
          this.dishService.deleteDish(this.editedDish.id)
            .subscribe((res) => {
              console.log(res);
              alert('dish was successfully deleted');
              this.completeOperation();
            });
        }
        break;
      }
    }
  }

  completeOperation() {
    this.router.navigate(['/editing', {operation: this.operationName}]);
  }

  fileChange(event) {
    let fileList: FileList = event.target.files;
    console.log(fileList);
  }

  autocompleteOptions = (searchInput: string) => (
    this.dishService.getDishAutocompleteOptions(searchInput)
  )
}
