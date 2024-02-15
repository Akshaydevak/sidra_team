part of 'employee_bloc.dart';


abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}
class RegisterEmployeeEvent extends EmployeeEvent {
  final String emailID;
  final String orgCode;
  final String netCode;
  final String designationCode;
  final String whatsapp;
  final String depatCode;
  final String firstName;
  final String lastName;
  final String contact;
  final String nationality;
  final String password;
  final int officialRole;
  final String userRole;
  final List<int> additionalRole;
  final String? gender;
  final List<String> roleNameList;
  final String roleName;
  final dynamic profilePic;
  RegisterEmployeeEvent({
    required this.emailID,
    required this.profilePic,
    required this.designationCode,
    required this.gender,
    required this.orgCode,
    required this.depatCode,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.password,
    required this.additionalRole,
    required this.officialRole,
    required this.nationality,
    required this.netCode,
    required this.whatsapp,
    required this.userRole,
    required this.roleName,
    required this.roleNameList,
  });
  @override
  List<Object> get props => [
    emailID,
  ];
}


class ChangeUserPasswordEvent extends EmployeeEvent {
  final String employeeCode;
  final String newPassword;

  ChangeUserPasswordEvent({

    required this.employeeCode,
    required this.newPassword,
  });
  @override
  List<Object> get props => [
    employeeCode,
  ];
}

class GetReadTypeEvent extends EmployeeEvent {

  const GetReadTypeEvent();

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

//updateGop
class UpdateGroupEvent extends EmployeeEvent {
  final String groupName;
  final String discription;
  final List<GetUserList> userList;
  final bool isActive;
  final int id;

  UpdateGroupEvent({
    required this.groupName,
    required this.discription,
    required this.userList,
    required this.isActive,
    required this.id,

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
class PostImageAllEvent extends EmployeeEvent {
  final File image;
  const PostImageAllEvent(this.image);
}
//
class PostImageAll2Event extends EmployeeEvent {
  final File image;
  const PostImageAll2Event(this.image);
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
  final String netCode;
  final String whatsapp;
  final String designationCode;
  final String depatCode;
  final String firstName;
  final String lastName;
  final String contact;
  final String nationality;
  final int officialRole;
  final String userRole;
  final List<int> additionalRole;
  final String? gender;
  final List<String> roleNameList;
  final String roleName;
  final bool isActive;
  final int id;
  final dynamic profileImg;
  const UpdateEmployeeEvent(
      {
        required this.emailID,
        required this.whatsapp,
        required this.profileImg,
        required this.netCode, required this.nationality,
  required this.officialRole, required this.userRole, required this.additionalRole,
        required this.designationCode,
        required this.roleNameList, required this.roleName, required this.id,
        required this.gender,
        required this.orgCode,
        required this.depatCode,
        required this.firstName,
        required this.lastName,
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
class DeleteGroupEvent extends EmployeeEvent {
  final int groupId;
  const DeleteGroupEvent(this.groupId);
}
//
class GetActivityLogListingEvent extends EmployeeEvent {
  final int? id;
  const GetActivityLogListingEvent(this.id);
}


//chage pass
class ChangePasswordEvent extends EmployeeEvent {
  final String userName;
  final String current;
  final String newPass;
  final String? otp;


  const ChangePasswordEvent( {
    required this.current,
    this.otp,
    required this.newPass,
    required this.userName,

  });
  @override
  List<Object> get props => [
    newPass,
  ];
}
class CreateTaskGroupCommunicationEvent extends EmployeeEvent {
  final CommunicationTaskGroup communicationTaskGroup;
  const CreateTaskGroupCommunicationEvent(this.communicationTaskGroup);
}

class FcmTokenRegisterEvent extends EmployeeEvent {
  final String fcmToken;
  const FcmTokenRegisterEvent(this.fcmToken);
}