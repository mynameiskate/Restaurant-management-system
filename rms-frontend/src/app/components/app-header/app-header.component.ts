import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-header',
  templateUrl: './app-header.component.html',
  styleUrls: ['./app-header.component.less']
})

export class AppHeaderComponent implements OnInit {
  name: String = 'Restaurant';
  imagesUrl: String = '../../assets/images/';

  constructor() { }

  ngOnInit() {
  }

  NavHandler() {
    let navList = document.querySelector('.navbar-collapse');
    if (navList.classList.contains('show')) {
        document.querySelector('.header-info').classList.remove('hide');
        document.querySelector('.carrot-icon').classList.remove('hide');
    } else {
        document.querySelector('.header-info').classList.add('hide');
        document.querySelector('.carrot-icon').classList.add('hide');
    }
  }

}
