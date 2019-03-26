const Position = require('./position.model');

class Employee {
  constructor(employeeEntity) {
    this.id = employeeEntity.EmployeeId;
    this.name = employeeEntity.Name;
    this.surname = employeeEntity.Surname;
    this.birthday = employeeEntity.Birthday;
    this.telephone = employeeEntity.Telephone;
    this.position = new Position(
      employeeEntity.PositionId,
      employeeEntity.Position
    )
  }
}
  
module.exports = Employee;