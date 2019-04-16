import { Component } from '@angular/core';

import { Employee } from '../../models/employee.model';
import { AuthService } from 'src/app/services/auth.service';
import { first } from 'rxjs/operators';
import { Router } from '@angular/router';

@Component({
  selector: 'app-authentication',
  templateUrl: './authentication.component.html',
  styleUrls: ['./authentication.component.less']
})
export class AuthenticationComponent {
  imagesUrl: string = '../../assets/images/';
  employees: Employee[] = [];
  email: string = '';
  password: string = '';
  incorrectEmail: boolean = false;
  incorrectPassword: boolean = false;

  constructor(private authService: AuthService,
    private router: Router) { }

  login() {
    this.incorrectEmail = this.email.length < 5;
    this.incorrectPassword = this.password.length < 5;

    if (!this.incorrectEmail && !this.incorrectPassword) {
      this.authService.login(this.email, this.password)
        .pipe(first())
        .subscribe(
          result => this.router.navigate(['']),
          // todo: style message
          err => alert('Could not authenticate')
        );
    }
  }

}
