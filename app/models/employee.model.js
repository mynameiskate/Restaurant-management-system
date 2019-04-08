const Position = require('./position.model');
const User = require('./user.model');

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
    );
    this.user = new User(
      employeeEntity.UserId,
      employeeEntity.Email,
      employeeEntity.Password
    )
  }
}
  
module.exports = Employee;