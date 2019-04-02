import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-editing',
  templateUrl: './editing.component.html',
  styleUrls: ['./editing.component.less']
})
export class EditingComponent implements OnInit {
  name: String = '';
  description: String = '';
  cost: String = '';
  weight: String = '';
  nutritionalValue: String = '';
  dishCategory: String = '';
  isAvailable: Boolean = false;

  constructor() { }

  ngOnInit() {
  }

  checkEnteredData() {
  }

  fileChange(event) {
    let fileList: FileList = event.target.files;
    console.log(fileList);
  }

}
