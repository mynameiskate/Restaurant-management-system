import { Position } from './position.model';
import { User } from './user.model';

export interface Employee {
  id: number,
  name: string,
  surname: string,
  birthday: Date,
  telephone:  string,
  position: Position,
  user: User
}