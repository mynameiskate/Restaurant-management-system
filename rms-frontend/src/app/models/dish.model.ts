export interface Dish {
  id: number;
  name: string;
  description: string;
  cost: number;
  weight: number;
  nutritionalValue: number;
  isAvailable: boolean;
  imageId?: string;
}