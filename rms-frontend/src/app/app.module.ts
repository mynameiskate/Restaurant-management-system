import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { HttpModule } from '@angular/http';
import { HttpClientModule } from '@angular/common/http';
import { Routes, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { AuthGuard } from './guards/auth.guard';
import { AppComponent } from './app.component';
import { AppHeaderComponent } from './components/app-header/app-header.component';
import { HomeComponent } from './components/home/home.component';
import { MenuComponent } from './components/menu/menu.component';
import { OrderComponent } from './components/order/order.component';
import { AuthenticationComponent } from './components/authentication/authentication.component';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { EditingComponent } from './components/editing/editing.component';
import { RouteHelper } from './helpers/route.helper';
import { DishService } from './services/dish.service';
import { AutocompleteComponent } from './components/shared/autocomplete/autocomplete.component';
import { ContentEditableComponent } from './components/shared/content-editable/content-editable.component';
import { JwtModule } from '@auth0/angular-jwt';
import { appConfig } from './configs/app.config';

export function tokenGetter() {
  return localStorage.getItem('access_token');
}

const appRoutes: Routes = [
  {path: '', component: HomeComponent},
  {path: 'menu', component: MenuComponent},
  {path: 'order', component: OrderComponent},
  {path: 'authentication', component: AuthenticationComponent},
  {path: 'editing', component: EditingComponent, canActivate: [AuthGuard]},
  {path: 'editing/:id', component: EditingComponent },
  {path: '**', component: NotFoundComponent}
]

@NgModule({
  declarations: [
    AppComponent,
    AppHeaderComponent,
    HomeComponent,
    MenuComponent,
    OrderComponent,
    AuthenticationComponent,
    NotFoundComponent,
    EditingComponent,
    AutocompleteComponent,
    ContentEditableComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    HttpClientModule,
    RouterModule.forRoot(appRoutes),
    FormsModule,
    NgbModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: tokenGetter,
        whitelistedDomains: [appConfig.appDomain],
        blacklistedRoutes: [`${appConfig.apiUrl}/${appConfig.authUrl}`]
      }
    })
  ],
  exports: [
    RouterModule
  ],
  providers: [
    RouteHelper,
    DishService,
    AuthGuard
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
