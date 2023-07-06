part of 'employee_bloc.dart';


abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}
class RegisterEmployeeEvent extends EmployeeEvent {
  final String emailID;
  final String orgCode;
  final String designationCode;
  final String depatCode;
  final String firstName;
  final String lastName;
  final String contact;
  final String? gender;
  RegisterEmployeeEvent({
    required this.emailID,
    required this.designationCode,
    required this.gender,
    required this.orgCode,
    required this.depatCode,
    this.firstName = "",
    this.lastName = "",
    required this.contact,
  });
  @override
  List<Object> get props => [
    emailID,
  ];
}

class CreateGroupEvent extends EmployeeEvent {
  final String groupName;
  final String discription;
  final List<String> userlist;

  CreateGroupEvent({
    required this.groupName,
    required this.discription,
    required this.userlist,

  });
  @override
  List<Object> get props => [
    groupName,
  ];
}

//post image
class PostImageEvent extends EmployeeEvent {
  final File image;
  const PostImageEvent(this.image);
}
//readgroup
class GetGroupTReadEvent extends EmployeeEvent {
  final int id;
  const GetGroupTReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}
//readEmployee
class GetEmployeeReadEvent extends EmployeeEvent {
  final int id;
  const GetEmployeeReadEvent(this.id);
  @override
  List<Object> get props => [this.id];
}

//updateEmployee
class UpdateEmployeeEvent extends EmployeeEvent {
  final String emailID;
  final String orgCode;
  final String designationCode;
  final String depatCode;
  final String firstName;
  final String lastName;
  final String contact;
  final String? gender;
  final bool isActive;
  const UpdateEmployeeEvent(
      {
        required this.emailID,
        required this.designationCode,
        required this.gender,
        required this.orgCode,
        required this.depatCode,
        this.firstName = "",
        this.lastName = "",
        required this.contact,
        required this.isActive,

      });
}
//deleteemployee
class DeleteEmployeeEvent extends EmployeeEvent {
  final int employeId;
  const DeleteEmployeeEvent(this.employeId);
}
//
class GetActivityLogListingEvent extends EmployeeEvent {
  final int? id;
  const GetActivityLogListingEvent(this.id);
}