import { Component, OnInit, ElementRef } from '@angular/core';
import { Observable } from 'rxjs';
import { Router } from '@angular/router';

import { Dish } from '../../models/dish.model';
import { DishService } from '../../services/dish.service';
import { appConfig } from '../../configs/app.config';
import { RouteHelper } from 'src/app/helpers/route.helper';

import * as jsPDF from 'jspdf';
import { parseLazyRoute } from '@angular/compiler/src/aot/lazy_routes';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.less'],
  providers: [DishService]
})
export class MenuComponent implements OnInit {
  dishes: Dish[] = [];
  choosedDishes = [];

  constructor(private el: ElementRef, private dishService: DishService,
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

    console.log(this.el.nativeElement);
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

  getPdfDocument() {
    let menu = this.getMenu();

    let options = { orientation: 'p', unit: 'mm', format: 'custom' };
    let doc = new jsPDF(options);
    doc.setProperties({
      title: 'Restaurant',
      subject: 'subject',
      author: 'Naty&Kate',
      creator: 'Naty&Kate'
    });

    let docInternals = doc.internal;
    let docPageSize = docInternals.pageSize;
    let docPageWidth = docPageSize.width;
    let docPageHeight = docPageSize.height;

    let fontSize = 35;
    doc.setFontSize(fontSize);
    doc.text(docPageWidth / 2 - 30, docPageHeight * 0.1, 'Restaurant');

    let pos = {
      x: 0,
      y: 0,
    }
    pos.x = docPageWidth * 0.5;
    pos.y = docPageHeight * 0.15;
    let r = 7;

    doc.circle(pos.x, pos.y, r, 'F');

    let xLeft = pos.x;
    let xRight = pos.x;
    for (let i = 0; i < 4; i++) {
      r /= 1.2;

      xLeft -= (r * 2 + 5);
      doc.circle(xLeft, pos.y, r, 'F');

      xRight += (r * 2 + 5);
      doc.circle(xRight, pos.y, r, 'F');
    }

    pos.y += 35;
    fontSize = 40;
    doc.setFontSize(fontSize);
    doc.text(pos.x - 15, pos.y, 'Menu');

    var img = new Image();
    img.src = './assets/images/dishes/no-picture.jpg';
    img.onload = function () {
      doc.addImage(img, 'JPEG', 15, 150, 180, 160);
    };

    pos.x = docPageWidth * 0.1;
    pos.y = 100;
    fontSize = 16;
    doc.setFontSize(fontSize);
    for (let dish of menu) {
      if (pos.y > docPageHeight * 0.9) {
        doc.addPage();
        pos.y = docPageHeight * 0.1;
      }

      doc.text(pos.x, pos.y, dish.name);
      doc.text(docPageWidth * 0.8, pos.y, dish.price.toString());
      pos.y += fontSize;
    }

    doc.save('Menu.pdf');
  }

  getCsvDocument() {
    let menu = this.getMenu();
    let A = [['name', 'price']];

    for (let dish of menu) {
      A.push([dish.name, dish.price.toString()]);
    }

    let csvRows = [];

    for (let i = 0, l = A.length; i < l; ++i) {
      csvRows.push(A[i].join(','));
    }

    let csvString = csvRows.join('\n');
    let a = document.createElement('a');
    a.href = 'data:attachment/csv,' + encodeURIComponent(csvString);
    a.target = '_blank';
    a.download = 'menu.csv';

    document.body.appendChild(a);
    a.click();
  }

  getMenu() {
    let menu = [];

    menu.push({ name: 'Tomato Soup', price: 10 });
    menu.push({ name: 'Mushroom Soup', price: 13 });
    menu.push({ name: 'Chili Soup', price: 10 });
    menu.push({ name: 'Avocado Soup', price: 20 });
    menu.push({ name: 'Greek Salad', price: 25 });
    menu.push({ name: 'Mimosa salad', price: 11 });
    menu.push({ name: 'Nicoise salad', price: 13 });
    menu.push({ name: 'Waldorf salad', price: 14 });
    menu.push({ name: 'Lasagnette', price: 15 });
    menu.push({ name: 'Stracciatella gelato', price: 20 });
    menu.push({ name: 'Spaghetti bolognese', price: 10 });
    menu.push({ name: 'Cinnamon Latte', price: 10 });
    menu.push({ name: 'Sagne', price: 15 });
    menu.push({ name: 'Tomato Soup', price: 10 });
    menu.push({ name: 'Mushroom Soup', price: 13 });
    menu.push({ name: 'Chili Soup', price: 10 });
    menu.push({ name: 'Avocado Soup', price: 20 });
    menu.push({ name: 'Greek Salad', price: 25 });
    menu.push({ name: 'Mimosa salad', price: 11 });
    menu.push({ name: 'Nicoise salad', price: 13 });
    menu.push({ name: 'Waldorf salad', price: 14 });
    menu.push({ name: 'Lasagnette', price: 15 });
    menu.push({ name: 'Stracciatella gelato', price: 20 });
    menu.push({ name: 'Spaghetti bolognese', price: 10 });
    menu.push({ name: 'Cinnamon Latte', price: 10 });
    menu.push({ name: 'Sagne', price: 15 });

    return menu;
  }
}
