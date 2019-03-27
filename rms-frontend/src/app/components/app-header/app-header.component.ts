import { Component, OnInit} from '@angular/core';

@Component({
  selector: 'app-header',
  templateUrl: './app-header.component.html',
  styleUrls: ['./app-header.component.less']
})

export class AppHeaderComponent implements OnInit {
  name: String = 'Restaurant';
  imagesUrl: String = '../../assets/images/';
  menuIsShown: Boolean = false;

  constructor() { }

  ngOnInit() {
  }

  toggleMenuVisibility() {
    this.menuIsShown = !this.menuIsShown;
  }

}
