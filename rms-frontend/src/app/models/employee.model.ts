import { Position } from './position.model';

export interface Employee {
  id: number,
  name: string,
  surname: string,
  birthday: Date,
  telephone:  string,
  position: Position
}