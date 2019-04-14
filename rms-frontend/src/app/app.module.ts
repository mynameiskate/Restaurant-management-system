import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { HttpModule } from '@angular/http';
import { HttpClientModule } from '@angular/common/http';
import { Routes, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';

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

const appRoutes: Routes = [
  {path: '', component: HomeComponent},
  {path: 'menu', component: MenuComponent},
  {path: 'order', component: OrderComponent},
  {path: 'authentication', component: AuthenticationComponent},
  {path: 'editing', component: EditingComponent},
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
    NgbModule
  ],
  exports: [
    RouterModule
  ],
  providers: [
    RouteHelper,
    DishService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
