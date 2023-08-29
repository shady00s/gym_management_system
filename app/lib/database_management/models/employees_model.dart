class EmployeesModel{
  late String employeeName;
 late  int employeePhoneNumber;
 late  String employeeSpecialization;
 late String employeePosition;
  late double employeeSalary;
  late String employeeAddress;
  late int teamId;


  EmployeesModel({required this.employeeAddress,required this.employeeSalary,required this.employeePosition,required this.employeeSpecialization,required this.employeePhoneNumber,required this.teamId,required this.employeeName});
}