import { Category } from "./category.model";

export interface Dish {
  id: number;
  name: string;
  description: string;
  cost: number;
  weight: number;
  nutritionalValue: number;
  isAvailable: boolean;
  category: Category;
  imageId?: string;
}