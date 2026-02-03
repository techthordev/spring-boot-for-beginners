import { Employee } from "./model";

export interface PageResponse<T> {
  _embedded?: {
    employees: T[];
  };
}
