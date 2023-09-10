import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_model/employee_model.dart';
import 'package:cluster/presentation/task_operation/home/model/joblist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common_widgets/gradient_button.dart';
import '../../../../../common_widgets/reusable_textfield.dart';
import '../../../../../core/color_palatte.dart';
import '../../../../../core/common_snackBar.dart';
import '../../../../../core/utils/variables.dart';
import '../home/bloc/job_bloc.dart';

class NewEmployee extends StatefulWidget {
  final bool editEmployee;
  const NewEmployee({Key? key,  this.editEmployee=false}) : super(key: key);

  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  int? empId;
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController gendercontroller=TextEditingController();
  String? selGender;
  List<String> gender = ["Male", "Female", "Other"];
  List<String> nationalityList = ["IND", "PAK", "AUS"];
  String? selectedGender;
  String? designationCode;
  String? country;
  GetEmployeeList? employeeCreate;
  String contactNumber = "";
  List<DesignationListing>designation=[];
  @override
  void initState() {
    context.read<JobBloc>().add(GetDesignationListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "New Employee"),
      ),
      body: MultiBlocListener(
  listeners: [
    BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {

        if (state is EmployeeLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is EmployeeFailed) {
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is EmployeeSuccess) {
          // employeeCreate = state.user;

          Fluttertoast.showToast(
              msg: 'Successfully Created',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
        }

  },
),
    BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {

        if (state is UpdateEmployeeLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is UpdateEmployeeFailed) {
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is UpdateEmployeeSuccess) {
          // employeeCreate = state.user;

          Fluttertoast.showToast(
              msg: 'Successfully Created',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          Navigator.pop(context);

        }

      },
    ),
    // BlocListener<EmployeeBloc, EmployeeState>(
    //   listener: (context, state) {
    //     print("state group$state");
    //     if(state is GetEmployeeReadLoading){
    //
    //     }
    //     if(state is GetEmployeeReadSuccess){
    //       print(":GPName4${state.getEmployee.userCode}");
    //       firstName.text=state.getEmployee.fName??"";
    //       lastName.text=state.getEmployee.lName??"";
    //       selectedGender=state.getEmployee.gender??"";
    //       contact.text=state.getEmployee.contactNumber??"";
    //       email.text=state.getEmployee.email??"";
    //       Variable.employeeId=state.getEmployee.id??0;
    //       setState(() {
    //
    //       });
    //     }
    //
    //   },
    // ),
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if(state is GetDesignationListLoading){

        }
        if(state is GetDesignationListSuccess){
          designation=state.designationList;
          print("desi$designation");
          setState(() {

          });
        }
      },
    ),

  ],
  child: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                  padding: EdgeInsets.all(16),
                  child: Column(children: [
                    TextFormReusable(
                      label: "First Name",
                      hint: "eg.shifas",
                      controller: firstName,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormReusable(
                      label: "Last Name",
                      hint: "eg.shifu",
                      controller: lastName,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: w / 2.3,
                              // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              //height: 20.0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), width: 1),
                              ),
                              child: DropdownButton(
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                                  underline: Container(),
                                  items: gender.map((String items) {
                                    return DropdownMenuItem(
                                      enabled: true,
                                      value: items,
                                      child: Text(items,
                                          style: TextStyle(
                                              color: Colors.black)),
                                    );
                                  }).toList(),
                                  value: selectedGender,
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedGender = value;
                                      if (value == "Male") {
                                        selGender = "M";
                                      } else if (value == "Female") {
                                        selGender = "F";
                                      } else if (value == "Other") {
                                        selGender = "N";
                                      }
                                      // Gender = value;
                                    });
                                  },
                                  hint: Text(
                                    "Gender",
                                    style: GoogleFonts.poppins(
                                        color:Colors.grey,fontSize: 14),
                                  )),
                            ),
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nationality",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: w / 2.3,
                                // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                //height: 20.0,
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(width: 1, color: Color(0xffe6ecf0)),
                                ),
                                child: DropdownButton(
                                    isExpanded: true,
                                    underline: Container(),
                                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                                    value: country,
                                    items: nationalityList.map((String items) {
                                      return DropdownMenuItem(
                                        alignment: Alignment.centerLeft,
                                        enabled: true,
                                        value: items,
                                        child: Text(items,
                                            style: const TextStyle(color: Colors.black)),
                                      );
                                    }).toList(),
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        // country = value;
                                      });
                                    },
                                    hint: Text(
                                      "Select one",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xffe6ecf0), fontSize: 14),
                                    )),
                              )
                            ]),]),
                        const SizedBox(
                          height: 16,
                        ),

                        TextFormReusable(
                          label: "Email Address",
                          hint: "eg.supermarket",
                          controller: email,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                    Container(
                      width: w,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Phone Number",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    IntlPhoneField(
                      controller: contact,
                      validator: (text) {
                        if (text == null) {
                          return 'Text is empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "eg.8606200441",
                        hintStyle: TextStyle(
                          color: Color(0x66151522),
                          fontSize: 15,
                        ),
                        contentPadding:
                        EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffe6ecf0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffe6ecf0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      onChanged: (phone) {
                        contactNumber = phone.completeNumber.toString();
                        contact = TextEditingController(text: phone.completeNumber);
                        print("number${contactNumber}");

                      },
                      onCountryChanged: (country) {},
                      cursorColor: Colors.black,
                      dropdownIcon: const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      dropdownIconPosition: IconPosition.trailing,
                      flagsButtonMargin: EdgeInsets.only(left: 10, right: 30),
                      disableLengthCheck: false,
                      showDropdownIcon: false,
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      width: w / 1,
                      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //height: 20.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.2), width: 1),
                      ),
                      child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          underline: Container(),
                          items: designation.map((DesignationListing items) {
                            return DropdownMenuItem(
                              enabled: true,
                              value: items,
                              child: Text(items.organization.toString()??"",
                                  style: TextStyle(
                                      color: Colors.black)),
                            );
                          }).toList(),
                          value: designationCode,
                          onChanged: (dynamic value) {

                          },
                          hint: Text(
                            "Designation Code",
                            style: GoogleFonts.poppins(
                                color:Colors.grey,fontSize: 14),
                          )),
                    ),
                    const SizedBox(height: 16,),
                    GradientButton(
                        color:ColorPalette.primary ,
                        onPressed: ()async {
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String? legalentry=sharedPreferences.getString('legalEntry');
                          String? organizationCode=sharedPreferences.getString('organizationCode');
                          print("NUM${contact.text}");
                          // widget.editEmployee?BlocProvider.of<EmployeeBloc>(context).add(
                          //     UpdateEmployeeEvent(
                          //       isActive: true,
                          //         contact: contactNumber==""?contact.text:contactNumber,
                          //         depatCode: legalentry??"",
                          //         designationCode: "DSGN001",
                          //         emailID: email.text,
                          //         gender: selectedGender,
                          //         orgCode: organizationCode??"",
                          //         firstName: firstName.text,
                          //         lastName: lastName.text
                          //     )):BlocProvider.of<EmployeeBloc>(context).add(
                          //     RegisterEmployeeEvent(
                          //         contact: contactNumber,
                          //         depatCode: legalentry??"",
                          //         designationCode: "DSGN001",
                          //         emailID: email.text,
                          //         gender: selectedGender,
                          //         orgCode: organizationCode??"",
                          //         firstName: firstName.text,
                          //         lastName: lastName.text
                          //     ));
                          context.read<JobBloc>().add( GetEmployeeListEvent('','',''));

                        },
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:[
                              ColorPalette.primary,
                              ColorPalette.primary
                            ]),
                        child: Text(
                          widget.editEmployee?"Update Employee":"Create New Employee",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
),
    );
  }
}
