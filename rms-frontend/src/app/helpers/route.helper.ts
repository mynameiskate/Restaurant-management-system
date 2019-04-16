import { appConfig } from '../configs/app.config';
import { Injectable } from '@angular/core';

@Injectable()
export class RouteHelper {
  get dishRoute() { return this.constructUrl(appConfig.dishUrl)};
  get employeeRoute() { return this.constructUrl(appConfig.employeeUrl)};
  get imageRoute() { return this.constructUrl(appConfig.imageUrl)};
  get categoryRoute() { return this.constructUrl(appConfig.categoryUrl)};
  get authRoute() { return this.constructUrl(appConfig.authUrl)};

  public construct = (path: string, subpath: any) => `${path}/${subpath}`;
  private constructUrl = (path: string) => this.construct(appConfig.apiUrl, path);
}