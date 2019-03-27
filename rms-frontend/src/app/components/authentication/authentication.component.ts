import { Component, OnInit } from '@angular/core';
import { Employee } from '../../models/employee.model';
import { UserService } from '../../services/user.service';

@Component({
  selector: 'app-authentication',
  templateUrl: './authentication.component.html',
  styleUrls: ['./authentication.component.less'],
  providers: [UserService]
})
export class AuthenticationComponent implements OnInit {
  imagesUrl: String = '../../assets/images/';
  employees: Employee[] = [];
  email: String = '';
  password: String = '';
  incorrectEmail: Boolean = false;
  incorrectPassword: Boolean = false;

  constructor(private userService: UserService) { }

  ngOnInit() {
    this.userService.getEmployees()
      .subscribe(res => this.employees = res);
  }

  checkEnteredData() {
    console.log(this.email, this.password);
    this.incorrectEmail = (this.email.length < 5) ? true : false;
    this.incorrectPassword = (this.password.length < 5) ? true : false;
  }

}
