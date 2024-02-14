import 'dart:io';

import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/seller_admin_app/model_seller_admin/seller_admin_models.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:cluster/presentation/task_operation/create/create_svg.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../common_widgets/title_app_bar.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../mpos/search_card.dart';
import '../../order_app/order_svg.dart';
import '../../promotion_app/dropdown_card.dart';
import '../../promotion_app/promotion_svg.dart';
import '../employee_model/employee_model.dart';
import '../home/bloc/job_bloc.dart';

class CreateUser extends StatefulWidget {
  final bool? edit;
  final GetEmployeeList? readEmployee;
  const CreateUser({super.key, this.edit, this.readEmployee});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  int selectIndex = 0;
  List<RoleModelList> roleList = [];
  List<String> genderList = [];
  List<String> userTypeList = [];
  List<int> passIdList = [];
  List<String> passNameList = [];
  String departmentCode = '';
  TextEditingController designationTitle = TextEditingController();
  TextEditingController designationDescription = TextEditingController();
  refresh() {
    print("department code here $departmentCode");
    setState(() {});
  }

  List<String> gender = ["Male", "Female", "Other"];
  String? selectedGender;
  String? selGender;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController whatsappmobileController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String designationCode = '';
  String departmentName = '';
  String businessunitName = '';
  String businessunitCode = '';
  String officialRoleName = '';
  String designationName = '';
  String departmentCodeUser = '';
  String contactNumber = '';
  String completeNumber="";
  String countryCode="IN";
  String userRoleName = 'Normal User';
  String contactNumberWhatsapp = '';
  String completeNumberWhatsapp="";
  String countryCodeWhatsapp="IN";
  int officialId = 0;
  int select = 0;
  void onselct(index) {
    setState(() {
      select = index;
      print("seler$select");
    });
  }

  @override
  void initState() {
    // readUser();
    context.read<EmployeeBloc>().add(const GetReadTypeEvent());
    context
        .read<SellerAdminBloc>()
        .add(const AdditionalRoleListEvent('', "", ""));
    context.read<SellerAdminBloc>().add(const CountryListEvent());

    super.initState();
  }
  readUser(){

      readEmployee = widget.readEmployee;
      drop ?? (drop = readEmployee?.country?.toUpperCase());
      if (readEmployee?.gender == 'M') {
        selectedGender = 'Male';
        selGender = 'M';
      } else if (readEmployee?.gender == 'F') {
        selectedGender = 'Female';
        selGender = 'F';
      } else {
        selectedGender = 'Other';
        selGender = 'O';
      }
      // selGender ?? (drop=readEmployee?.gender);
      // dropState ?? (dropState=sellerRead?.state.toString().toTitleCase());

      fNameController.text = readEmployee?.fname ?? "";
      lNameController.text = readEmployee?.lname ?? "";
      // selectedGender=state.getEmployee.gender??"";
      mobileController.text = readEmployee?.contactNum?.number ?? "";
      whatsappmobileController.text = readEmployee?.WhatsappNum?.number ?? "";

      contactNumber = readEmployee?.primaryMobile ?? "";
      completeNumberWhatsapp="${readEmployee?.WhatsappNum?.countryCode}${readEmployee?.WhatsappNum?.number}";
      completeNumber="${readEmployee?.contactNum?.countryCode}${readEmployee?.contactNum?.number}";
      countryCode=readEmployee?.contactNum?.countryCode??"";
      countryCodeWhatsapp=readEmployee?.WhatsappNum?.countryCode??"";
      emailController.text = readEmployee?.email ?? "";
      designationName = readEmployee?.designation ?? "";
      userRoleName = readEmployee?.role ?? "";
      officialRoleName = readEmployee?.userMete?.roleName ?? "";
      departmentName = readEmployee?.departmentCode ?? "";
      designationName = readEmployee?.designation ?? "";
      imageId=readEmployee?.userMete?.profile??"";
      imageUrl=readEmployee?.userMete?.profile??"";
      for (var i = 0;
      i < readEmployee!.userMete!.roleList!.length;
      i++) {
        passNameList
            .add(readEmployee?.userMete!.roleList?[i] ?? "");

      }
      context
          .read<SellerAdminBloc>()
          .add(const AdditionalRoleListEvent('', "", ""));
      print("pass ${passNameList.length}");
      print("mobhhh${completeNumber}");
      print("mobhhh$completeNumberWhatsapp");

      setState(() {});

  }

  String? drop;
  GetEmployeeList? readEmployee;
  String imageUrl='';
  dynamic imageId = 0;
  List<CountryStateModel>? countryList = [];
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return MultiBlocListener(
      listeners: [
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is Pic2Success) {
              print("Inside Success${state.data}\t${state.url}");
              setState(() {
                // picModel.replaceRange(indexImage, indexImage+1,
                //      [PicModel(data: state.data,url: state.url)]);
                imageId = state.data;
                imageUrl = state.url;
                // isUpoloading = false;
              });
              // print("pic model length${picModel.length}");
            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is GetReadTypeSuccess) {
              userTypeList = state.readType.userRole ?? [];
              userRoleName = state.readType.userRole?[0] ?? "";
              genderList = state.readType.gender ?? [];
              print("user type List$userTypeList");
              setState(() {});
            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            print("state group$state");
            if (state is GetEmployeeReadSuccess) {
              readEmployee = state.getEmployee;
              drop ?? (drop = readEmployee?.country?.toUpperCase());
              if (readEmployee?.gender == 'M') {
                selectedGender = 'Male';
                selGender = 'M';
              } else if (readEmployee?.gender == 'F') {
                selectedGender = 'Female';
                selGender = 'F';
              } else {
                selectedGender = 'Other';
                selGender = 'O';
              }
              // selGender ?? (drop=readEmployee?.gender);
              // dropState ?? (dropState=sellerRead?.state.toString().toTitleCase());

              fNameController.text = state.getEmployee.fname ?? "";
              lNameController.text = state.getEmployee.lname ?? "";
              countryCode=state.getEmployee.WhatsappNum?.countryCode??"";
              // selectedGender=state.getEmployee.gender??"";
              mobileController.text = state.getEmployee.contactNum?.number ?? "";
              whatsappmobileController.text = state.getEmployee.WhatsappNum?.number ?? "";

              contactNumber = state.getEmployee.primaryMobile ?? "";
              completeNumberWhatsapp="${state.getEmployee?.WhatsappNum?.countryCode}${state.getEmployee?.WhatsappNum?.number}";
              completeNumber="${state.getEmployee?.contactNum?.countryCode}${state.getEmployee?.contactNum?.number}";
              countryCode=state.getEmployee?.contactNum?.countryCode??"";
              countryCodeWhatsapp=state.getEmployee?.WhatsappNum?.countryCode??"";
              emailController.text = state.getEmployee.email ?? "";
              designationName = state.getEmployee?.designation ?? "";
              userRoleName = state.getEmployee?.role ?? "";
              officialRoleName = state.getEmployee?.userMete?.roleName ?? "";
              departmentName = state.getEmployee?.departmentCode ?? "";
              designationName = state.getEmployee?.designation ?? "";
              imageId=state.getEmployee?.userMete?.profile??"";
              imageUrl=state.getEmployee?.userMete?.profile??"";
              for (var i = 0;
                  i < state.getEmployee.userMete!.roleList!.length;
                  i++) {
                passNameList
                    .add(state.getEmployee?.userMete!.roleList?[i] ?? "");

              }
              context
                  .read<SellerAdminBloc>()
                  .add(const AdditionalRoleListEvent('', "", ""));
              print("pass ${passNameList.length}");
              print("mobhhh${completeNumber}");
              print("mobhhh$completeNumberWhatsapp");

              setState(() {});
            }
          },
        ),
        BlocListener<SellerAdminBloc, SellerAdminState>(
          listener: (context, state) {
            if (state is AdditionalRoleListSuccess) {
              roleList = state.role ?? [];
              setState(() {});
            }
          },
        ),
        BlocListener<SellerAdminBloc, SellerAdminState>(
          listener: (context, state) {
            if (state is GetCountryListSuccess) {
              countryList = state.country;
              setState(() {});
            }
          },
        ),
        BlocListener<SellerAdminBloc, SellerAdminState>(
          listener: (context, state) {
            if (state is CreateDesignationSuccess) {
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {

            if (state is EmployeeSuccess) {
              showSnackBar(context,
                  message: state.user ?? "", color: ColorPalette.green);
              Navigator.pop(context);
              context.read<JobBloc>().add(GetEmployeeListEvent('', '', ''));
            }
            if (state is EmployeeFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.green);
            }
          },
        ),
        BlocListener<EmployeeBloc, EmployeeState>(
          listener: (context, state) {

            if (state is UpdateEmployeeSuccess) {
              showSnackBar(context,
                  message: state.user, color: ColorPalette.green);
              Navigator.pop(context);
              context.read<JobBloc>().add(GetEmployeeListEvent('', '', ''));
            }
            if (state is UpdateEmployeeFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.green);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: BackAppBar(
              label: "New User",
              isAction: false,
              isBack: false,
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    if (state is GetReadTypeLoading) {
                      return customCupertinoLoading();
                    }
                    if (state is GetReadTypeSuccess) {
                      userTypeList = state.readType.userRole ?? [];
                      return SizedBox(
                          width: w,
                          height: 20,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(right: 0, left: 0),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: userTypeList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return GestureDetector(
                                  onTap: () {
                                    onselct(i);
                                    userRoleName = userTypeList[i];
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.string(select == i
                                          ? HomeSvg().radioButtonActive
                                          : CreateSvg().radioInActiveButton),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        userTypeList[i] == "Staff"
                                            ? "Normal User"
                                            : userTypeList[i] ==
                                                    "Associative Admin"
                                                ? "Associative Admin"
                                                : userTypeList[i] == "Admin"
                                                    ? "Admin"
                                                    : "",
                                        style: select == i
                                            ? GoogleFonts.roboto(
                                                color: ColorPalette.black,
                                                fontSize: w / 23,
                                                fontWeight: FontWeight.w500,
                                              )
                                            : GoogleFonts.roboto(
                                                color: ColorPalette.black,
                                                fontSize: w / 23,
                                              ),
                                      ),
                                    ],
                                  ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 16,
                              );
                            },
                          ));
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)),
                    child: imageUrl == ""
                        ? SvgPicture.string(TaskSvg().noImage)
                        : Container(
                      padding: EdgeInsets.all(1),
                      // alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          color: Color(0xFFF7F7F7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50,
                                color: Color(0xFFCBCED0)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              imageUrl != ""
                                  ? imageUrl
                                  : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf1P_4ikSWJtFvk7JqNq-n0e2KNnqqlYgNrw&usqp=CAU",
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: w1 / 3,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: Color(0x4CD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: Color(0xFFE1E4E6)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            imageUrl='';
                            imageId=0;
                            getImage(ImageSource.camera);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 17,
                                color: Color(0xff6D6D6D),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Use Camera",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: w1 / 3,
                      height: 32,
                      decoration: ShapeDecoration(
                        color: Color(0x4CD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: Color(0xFFE1E4E6)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            imageUrl='';
                            imageId=0;
                            getImage(ImageSource.gallery);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                size: 17,
                                color: Color(0xff6D6D6D),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Use Gallery",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "First Name",
                  hint: "eg.Tom",
                  controller: fNameController,
                  isMandatory: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Last Name",
                  hint: "eg.joseph",
                  controller: lNameController,
                  isMandatory: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Email",
                  hint: "eg.example@gmail.com",
                  controller: emailController,
                  isMandatory: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Phone Number",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        " *",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                IntlPhoneField(
                  pickerDialogStyle:
                  PickerDialogStyle(backgroundColor: Colors.white,
                      searchFieldCursorColor:
                      const Color(0xffff9900),
                      listTileDivider: const Divider(
                        height: 0,
                      ),
                      searchFieldInputDecoration:
                      const InputDecoration(
                          focusedBorder:
                          UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(
                                      0xffff9900),
                                  width: 2.0,
                                  style: BorderStyle
                                      .solid)),
                          suffixIcon: Icon(
                            Icons.search,
                            color: ColorPalette.primary,
                          ),
                          labelText: "Search Country...",
                          labelStyle: TextStyle(
                              color: Colors.grey),
                          enabledBorder:
                          UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorPalette.primary,
                                  width: 1.0,
                                  style: BorderStyle
                                      .solid)))),
                  controller: mobileController,
                  disableLengthCheck: true,
                  initialCountryCode: countryCode,

                  validator: (text) {
                    if (text == null || text.toString() == "") {
                      return '* required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "eg.553536677",
                    hintStyle: GoogleFonts.inter(
                        color: ColorPalette.fillGrey, fontSize: 13),
                    contentPadding: const EdgeInsets.only(
                        left: 0, top: 10, bottom: 10),
                    border: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.borderGrey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.borderGrey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorPalette.black, width: 1.0),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red, width: 1.0),
                    ),
                  ),
                  onChanged: (phone) {
                    contactNumber = phone.number;
                    countryCode =phone.countryCode;
                    completeNumber=countryCode+contactNumber;
                    // print("compleeeeeeeeeeeeete$completeNumber");
                    mobileController =
                        TextEditingController(text: phone.number);
                    // email = TextEditingController(text: completeNumber);
                  },
                  onCountryChanged: (country) {
                    countryCode=country.dialCode;
                    completeNumber= "+${countryCode + contactNumber}";
                    mobileController =
                        TextEditingController(text: contactNumber);

                  },
                  cursorColor: Colors.black,
                  dropdownIcon: const Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  dropdownIconPosition: IconPosition.trailing,
                  flagsButtonMargin:
                  const EdgeInsets.only(left: 10, right: 0),

                  // disableLengthCheck: false,
                  showDropdownIcon: false,
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Text(
                      "Whatsapp Number",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: w / 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        " *",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // IntlPhoneField(
                //   initialCountryCode: "IN",
                //   controller: mobileController,
                //   validator: (text) {
                //     if (text == null) {
                //       return 'Text is empty';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     hintText: "eg.8606200441",
                //     hintStyle: GoogleFonts.roboto(
                //         color: Colors.grey, fontSize: w / 24),
                //     contentPadding: const EdgeInsets.only(
                //         left: 10, top: 10, bottom: 10, right: 10),
                //     border: const OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xffe6ecf0)),
                //     ),
                //     enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xffe6ecf0)),
                //     ),
                //     focusedBorder: const OutlineInputBorder(
                //       borderSide:
                //       BorderSide(color: Color(0xffe6ecf0), width: 1.0),
                //     ),
                //     errorBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black, width: 1.0),
                //     ),
                //   ),
                //   onChanged: (phone) {
                //
                //     contactNumber = phone.completeNumber.toString();
                //     mobileController =
                //         TextEditingController(text: phone.number);
                //   },
                //   onCountryChanged: (country) {},
                //   cursorColor: Colors.black,
                //   dropdownIcon: const Icon(
                //     Icons.arrow_right,
                //     color: Colors.white,
                //   ),
                //   dropdownIconPosition: IconPosition.trailing,
                //   flagsButtonMargin: const EdgeInsets.only(left: 10, right: 30),
                //   disableLengthCheck: false,
                //   showDropdownIcon: false,
                // ),
                IntlPhoneField(
                  pickerDialogStyle:
                  PickerDialogStyle(backgroundColor: Colors.white,
                      searchFieldCursorColor:
                      const Color(0xffff9900),
                      listTileDivider: const Divider(
                        height: 0,
                      ),
                      searchFieldInputDecoration:
                      const InputDecoration(
                          focusedBorder:
                          UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(
                                      0xffff9900),
                                  width: 2.0,
                                  style: BorderStyle
                                      .solid)),
                          suffixIcon: Icon(
                            Icons.search,
                            color: ColorPalette.primary,
                          ),
                          labelText: "Search Country...",
                          labelStyle: TextStyle(
                              color: Colors.grey),
                          enabledBorder:
                          UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorPalette.primary,
                                  width: 1.0,
                                  style: BorderStyle
                                      .solid)))),
                  controller: whatsappmobileController,
                  disableLengthCheck: true,
                  initialCountryCode: countryCodeWhatsapp,

                  validator: (text) {
                    if (text == null || text.toString() == "") {
                      return '* required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "eg.553536677",
                    hintStyle: GoogleFonts.inter(
                        color: ColorPalette.fillGrey, fontSize: 13),
                    contentPadding: const EdgeInsets.only(
                        left: 0, top: 10, bottom: 10),
                    border: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.borderGrey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorPalette.borderGrey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorPalette.black, width: 1.0),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red, width: 1.0),
                    ),
                  ),
                  onChanged: (phone) {
                    contactNumberWhatsapp = phone.number;
                    countryCodeWhatsapp =phone.countryCode;
                    completeNumberWhatsapp=countryCodeWhatsapp+contactNumberWhatsapp;
                    // print("compleeeeeeeeeeeeete$completeNumber");
                    whatsappmobileController =
                        TextEditingController(text: phone.number);
                    // email = TextEditingController(text: completeNumber);
                  },
                  onCountryChanged: (country) {
                    countryCodeWhatsapp=country.dialCode;
                    completeNumberWhatsapp= "+${countryCodeWhatsapp + contactNumberWhatsapp}";
                    whatsappmobileController =
                        TextEditingController(text: contactNumberWhatsapp);

                  },
                  cursorColor: Colors.black,
                  dropdownIcon: const Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                  ),
                  dropdownIconPosition: IconPosition.trailing,
                  flagsButtonMargin:
                  const EdgeInsets.only(left: 10, right: 0),

                  // disableLengthCheck: false,
                  showDropdownIcon: false,
                ),
                SizedBox(height: 16,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Gender",
                          style: GoogleFonts.roboto(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            " *",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: w1,
                      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //height: 20.0,
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xffe6ecf0), width: 1),
                      ),
                      child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          underline: Container(),
                          items: gender.map((String item) {
                            return DropdownMenuItem(
                              enabled: true,
                              value: item,
                              child: Text(item,
                                  style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          value: selectedGender,
                          onChanged: (dynamic value) {
                            print("selecteddd geneer $selectedGender");
                            setState(() {
                              print(value);
                              selectedGender = value;
                              print(selectedGender);
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
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 14),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Country",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            " *",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    ),
                    Container(
                        width: w1,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Color(0xffe6ecf0),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Color(0x7f666161)),
                          elevation: 1,
                          underline: Container(),
                          hint: Text(
                            "Country",
                            style: GoogleFonts.roboto(color: Color(0x66151522)),
                          ),
                          value: drop,
                          items: countryList?.map((CountryStateModel items) {
                            return DropdownMenuItem(
                              alignment: Alignment.centerLeft,
                              enabled: true,
                              value: items.code,
                              onTap: () {},
                              child: Text(items.name ?? "",
                                  style: GoogleFonts.poppins(
                                      color: ColorPalette.black)),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              print("inside dropdown${value}");
                              // widget.onChangeChannel!(value ?? "");
                              drop = value;
                              // context.read<SellerAdminBloc>().add( StateListEvent(value??""));
                            });
                          },
                          // hint: Text(
                          //   "Select",
                          //   style: TextStyle(
                          //     color: Color(0xbf666161),
                          //     fontSize: w / 24,
                          //   ),
                          // )
                        )),
                  ],
                ),
                widget.edit == true
                    ? Container()
                    : SizedBox(
                        height: 16,
                      ),
                widget.edit == true
                    ? Container()
                    : TextFormReusable(
                        label: "Password",
                        hint: "eg.12548RE5",
                        isMandatory: true,
                        controller: passwordController,
                      ),
                // const SizedBox(
                //   height: 16,
                // ),
                // DropDownCard(
                //   label: "Business Code",
                //   isMandatory: true,
                //   selValue: businessunitName==""?"Select":businessunitName,
                //   onTap: (){
                //     context.read<SellerAdminBloc>().add(
                //         BusinessOutletListEvent(
                //             widget.entityCode, "", "", ""));
                //     _showModalBottomBusinessCodeList(businessunitName, onCallBack: (bool val){
                //       print("clllling back hereeee");
                //       setState(() {
                //
                //       });((){});
                //     });
                //   },
                // ),
                const SizedBox(
                  height: 16,
                ),
                widget.edit == true
                    ? ReadDropDownCard(
                        label: "Department",
                        selValue:
                            departmentName == "" ? "Select" : departmentName,
                        onTap: () {
                          context
                              .read<SellerAdminBloc>()
                              .add(const DepartmentListEvent('', "", ""));
                          _showModalBottomDepartment(departmentName,
                              onCallBack: (bool val) {
                            print("clllling back hereeee");
                            setState(() {});
                            (() {});
                          });
                        },
                      )
                    : DropDownCard(
                        label: "Department",
                        isMandatory: true,
                        selValue:
                            departmentName == "" ? "Select" : departmentName,
                        onTap: () {
                          context
                              .read<SellerAdminBloc>()
                              .add(const DepartmentListEvent('', "", ""));
                          _showModalBottomDepartment(departmentName,
                              onCallBack: (bool val) {
                            print("clllling back hereeee");
                            setState(() {});
                            (() {});
                          });
                        },
                      ),
                const SizedBox(
                  height: 16,
                ),
                // widget.edit==true?ReadDropDownCard(
                //   label: "Role",
                //   selValue: officialRoleName==""?"Select":officialRoleName,
                //   onTap: (){
                //     context.read<SellerAdminBloc>()
                //         .add(const OfficialRoleListEvent('',"", ""));
                //     _showModalBottomOfficialRole(officialRoleName);
                //   },
                // ):DropDownCard(
                //   label: "Role",
                //   isMandatory: true,
                //   selValue: officialRoleName==""?"Select":officialRoleName,
                //   onTap: (){
                //     context.read<SellerAdminBloc>()
                //         .add(const OfficialRoleListEvent('',"", ""));
                //     _showModalBottomOfficialRole(officialRoleName);
                //   },
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                DropDownCard(
                  label: "Additional Role",
                  isMandatory: true,
                  selValue: passNameList.isNotEmpty
                      ? "Additional Role Selected"
                      : "Select",
                  onTap: () {
                    _showModalBottomAdditionalRole();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                widget.edit == true
                    ? ReadDropDownCard(
                        label: "Designation",
                        selValue:
                            designationName == "" ? "Select" : designationName,
                        onTap: () {
                          context.read<SellerAdminBloc>().add(
                              DesignationListEvent(
                                  authentication.authenticatedUser.legalEntity,
                                  '',
                                  "",
                                  ""));
                          _showModalBottomDesignation(designationName);
                        },
                      )
                    : DropDownCard(
                        label: "Designation",
                        isMandatory: true,
                        selValue:
                            designationName == "" ? "Select" : designationName,
                        onTap: () {
                          context.read<SellerAdminBloc>().add(
                              DesignationListEvent(
                                  authentication.authenticatedUser.legalEntity,
                                  '',
                                  "",
                                  ""));
                          _showModalBottomDesignation(designationName);
                        },
                      ),
                const SizedBox(
                  height: 30,
                ),
                widget.edit == true
                    ? GradientButton(
                        color: ColorPalette.primary,
                        onPressed: () {
                          print("mob${mobileController.text}");
                          print("mob${readEmployee?.id}");
                          context.read<EmployeeBloc>().add(UpdateEmployeeEvent(
                              contact: completeNumber,
                              whatsapp: completeNumberWhatsapp,
                              profileImg: imageId,
                              officialRole: readEmployee?.userMete?.roleId ?? 0,
                              roleName: officialRoleName,
                              nationality: drop ?? "",
                              lastName: lNameController.text,
                              gender: selGender ?? "",
                              firstName: fNameController.text,
                              emailID: emailController.text,
                              designationCode: readEmployee?.designation ?? "",
                              orgCode: authentication
                                      .authenticatedUser.organisationCode ??
                                  "",
                              additionalRole:
                                  readEmployee?.userMete?.roleListId ?? [],
                              roleNameList:
                                  readEmployee?.userMete?.roleList ?? [],
                              depatCode: readEmployee?.departmentCode ?? "",
                              userRole: userRoleName,
                              netCode: readEmployee?.netCode ?? "",
                              id: readEmployee?.id ?? 0,
                              isActive: true));
                        },
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary
                            ]),
                        child: Text(
                          "Update User",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    : GradientButton(
                        color: ColorPalette.primary,
                        onPressed: () {
                          print("mob${completeNumber}");
                          print("mob$completeNumberWhatsapp");
                          context.read<EmployeeBloc>().add(
                              RegisterEmployeeEvent(
                                whatsapp: completeNumberWhatsapp,
                                profilePic: imageId,
                                  contact: completeNumber,
                                  password: passwordController.text,
                                  officialRole: officialId,
                                  roleName: officialRoleName,
                                  nationality: drop ?? "",
                                  lastName: lNameController.text,
                                  gender: selGender ?? "",
                                  firstName: fNameController.text,
                                  emailID: emailController.text,
                                  designationCode: designationCode,
                                  orgCode: authentication
                                          .authenticatedUser.organisationCode ??
                                      "",
                                  additionalRole: passIdList,
                                  roleNameList: passNameList,
                                  depatCode: departmentCodeUser,
                                  userRole: userRoleName,
                                  netCode: authentication
                                          .authenticatedUser.legalEntity ??
                                      ""));
                        },
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.primary
                            ]),
                        child: Text(
                          "Add New User",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: w / 20,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _showModalBottomOfficialRole(String? offerPeriodNameNew) {
  //   void onselect(int index) {
  //     setState(() {
  //       selectIndex = index;
  //     });
  //   }
  //
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
  //       ),
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (context) {
  //         var h = MediaQuery.of(context).size.height;
  //         double w1 = MediaQuery.of(context).size.width;
  //         double w = w1 > 700 ? 400 : w1;
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               height: h / 1.3,
  //               width: double.infinity,
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(10),
  //                     topLeft: Radius.circular(10),
  //                   )),
  //               alignment: Alignment.center,
  //               child: Stack(
  //                 children: [
  //                   Column(
  //                     children: [
  //                       SizedBox(
  //                         height: h / 180,
  //                       ),
  //                       Container(
  //                         width: w / 5.3,
  //                         height: h / 160,
  //                         decoration: ShapeDecoration(
  //                           color: const Color(0xFFD9D9D9),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: h / 40,
  //                       ),
  //                       Text(
  //                         "Select Official Role",
  //                         style: GoogleFonts.roboto(
  //                           color: Colors.black,
  //                           fontSize: w / 22,
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: h / 40,
  //                       ),
  //                       // SizedBox(height: 10,),
  //                       SizedBox(
  //                         height: h / 1.5,
  //                         child: ScrollConfiguration(
  //                           behavior: NoGlow(),
  //                           child: SingleChildScrollView(
  //                             physics: const AlwaysScrollableScrollPhysics(),
  //                             child: Padding(
  //                               padding:
  //                                   const EdgeInsets.only(left: 15, right: 15),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   BlocBuilder<SellerAdminBloc,
  //                                       SellerAdminState>(
  //                                     builder: (context, state) {
  //                                       if (state is OfficialRoleListLoading) {
  //                                         return LottieLoader();
  //                                       }
  //                                       if (state is OfficialRoleListSuccess) {
  //                                         return Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             ListView.separated(
  //                                               primary: true,
  //                                               shrinkWrap: true,
  //                                               itemCount: state.role!.length,
  //                                               physics:
  //                                                   const NeverScrollableScrollPhysics(),
  //                                               itemBuilder: (context, index) =>
  //                                                   GestureDetector(
  //                                                 onTap: () {
  //                                                   onselect(index);
  //                                                   setState(() {});
  //                                                   officialId =
  //                                                       state.role?[index].id ??
  //                                                           0;
  //                                                   officialRoleName = state
  //                                                           .role?[index]
  //                                                           .role ??
  //                                                       "";
  //                                                   Navigator.pop(context);
  //                                                 },
  //                                                 child: Row(
  //                                                   children: [
  //                                                     Row(
  //                                                       children: [
  //                                                         GestureDetector(
  //                                                           onTap: () {
  //                                                             onselect(index);
  //                                                             setState(() {});
  //                                                             officialId = state
  //                                                                     .role?[
  //                                                                         index]
  //                                                                     .id ??
  //                                                                 0;
  //                                                             officialRoleName =
  //                                                                 state.role?[index]
  //                                                                         .role ??
  //                                                                     "";
  //                                                             Navigator.pop(
  //                                                                 context);
  //                                                           },
  //                                                           child: Container(
  //                                                             padding:
  //                                                                 const EdgeInsets
  //                                                                     .only(
  //                                                                     // left: 8,
  //                                                                     bottom: 5,
  //                                                                     top: 5,
  //                                                                     right: 8),
  //                                                             child: SvgPicture.string(state
  //                                                                         .role?[
  //                                                                             index]
  //                                                                         .role ==
  //                                                                     offerPeriodNameNew
  //                                                                 // selectIndex == index
  //                                                                 ? HomeSvg()
  //                                                                     .radioButtonActive
  //                                                                 : HomeSvg()
  //                                                                     .radioInActive),
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(
  //                                                           // padding: const EdgeInsets.only(bottom: 5),
  //                                                           width: w / 1.5,
  //                                                           child: Text(
  //                                                             state.role?[index]
  //                                                                     .role
  //                                                                     .toString()
  //                                                                     .toTitleCase() ??
  //                                                                 "",
  //                                                             style: GoogleFonts
  //                                                                 .roboto(
  //                                                               color: Colors
  //                                                                   .black,
  //                                                               fontSize:
  //                                                                   w / 24,
  //                                                               // fontWeight: FontWeight.w500,
  //                                                             ),
  //                                                             overflow:
  //                                                                 TextOverflow
  //                                                                     .ellipsis,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                     const Spacer(),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                               separatorBuilder:
  //                                                   (context, index) =>
  //                                                       Container(
  //                                                 color: ColorPalette.divider,
  //                                                 height: 1,
  //                                                 margin: const EdgeInsets.only(
  //                                                     top: 3, bottom: 3),
  //                                                 width: w,
  //                                               ),
  //                                             ),
  //                                             SizedBox(
  //                                               height: h / 40,
  //                                             ),
  //                                             // Row(
  //                                             //   mainAxisAlignment:
  //                                             //   MainAxisAlignment.spaceBetween,
  //                                             //   children: [
  //                                             //     state.prevPageUrl == null
  //                                             //         ? Text("")
  //                                             //         : GestureDetector(
  //                                             //       onTap: () {
  //                                             //         context.read<SellerAdminBloc>().add(
  //                                             //             OfficialRoleListEvent('',"",
  //                                             //                 state
  //                                             //                     .nextPageUrl ??
  //                                             //                     "",
  //                                             //                 ));
  //                                             //       },
  //                                             //       child: Text(
  //                                             //         "Previous",
  //                                             //         style: TextStyle(
  //                                             //             fontWeight: FontWeight.w500,
  //                                             //             color: ColorPalette.primary,
  //                                             //             fontSize: w / 24),
  //                                             //       ),
  //                                             //     ),
  //                                             //     state.nextPageUrl == null
  //                                             //         ? Text("")
  //                                             //         : GestureDetector(
  //                                             //       onTap: () {
  //                                             //         context.read<SellerAdminBloc>().add(
  //                                             //             OfficialRoleListEvent("",
  //                                             //                 state
  //                                             //                     .nextPageUrl ??
  //                                             //                     "",
  //                                             //                 ""));
  //                                             //       },
  //                                             //       child: Text(
  //                                             //         "Next",
  //                                             //         style: TextStyle(
  //                                             //             fontWeight: FontWeight.w500,
  //                                             //             color: ColorPalette.primary,
  //                                             //             fontSize: w / 24),
  //                                             //       ),
  //                                             //     ),
  //                                             //   ],
  //                                             // ),
  //                                             // SizedBox(
  //                                             //   height: h/10,
  //                                             // ),
  //                                             SizedBox(
  //                                               height: h / 20,
  //                                             ),
  //                                           ],
  //                                         );
  //                                       }
  //                                       return SizedBox(
  //                                           width: w,
  //                                           height: 300,
  //                                           child: customCupertinoLoading());
  //                                     },
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     left: 0,
  //                     right: 0,
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 15, right: 15, bottom: 10),
  //                       child: GradientButton(
  //                           color: ColorPalette.primary,
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           gradient: const LinearGradient(
  //                               begin: Alignment.topCenter,
  //                               end: Alignment.bottomCenter,
  //                               colors: [
  //                                 ColorPalette.primary,
  //                                 ColorPalette.primary
  //                               ]),
  //                           child: Text(
  //                             "Continue",
  //                             textAlign: TextAlign.center,
  //                             style: GoogleFonts.roboto(
  //                               color: Colors.white,
  //                               fontSize: w / 22,
  //                               fontWeight: FontWeight.w600,
  //                             ),
  //                           )),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  _showModalBottomAdditionalRole() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select Additional Roles",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        SizedBox(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.separated(
                                      primary: true,
                                      shrinkWrap: true,
                                      itemCount: roleList.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => Row(
                                        children: [
                                          widget.edit == true
                                              ? Row(
                                                children: [
                                                  Container(
                                                      child: SvgPicture.string(
                                                          OrderSvg()
                                                              .checkBoxActiveIcon)),
                                                  SizedBox(width: 10,),
                                                  Text(roleList[index].role??"",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: w / 24,
                                                      // fontWeight: FontWeight.w500,
                                                    ),)

                                                ],
                                              )
                                              : CustomCheckBox(
                                                  key: UniqueKey(),
                                                  value: passNameList.contains(
                                                      roleList[index].role),
                                                  onChange: (p0) {
                                                    if (p0) {
                                                      passIdList.add(
                                                          roleList[index].id ??
                                                              0);
                                                      passNameList.add(
                                                          roleList[index]
                                                                  .role ??
                                                              "");
                                                    } else {
                                                      passIdList.remove(
                                                          roleList[index].id ??
                                                              0);
                                                      passNameList.remove(
                                                          roleList[index]
                                                                  .role ??
                                                              "");
                                                    }
                                                    print("fsd$passNameList");
                                                    refresh();
                                                  },
                                                  text: roleList[index].role ??
                                                      "",
                                                ),

                                          // Text(
                                          //   roleList[index].role??"",
                                          //   style: GoogleFonts.roboto(
                                          //     color: Colors.black,
                                          //     fontSize: w / 24,
                                          //     // fontWeight: FontWeight.w500,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      separatorBuilder: (context, index) =>
                                          Container(
                                        color: ColorPalette.divider,
                                        height: 1,
                                        margin: const EdgeInsets.only(top: 10),
                                        width: w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              // refresh();
                              Navigator.pop(context);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomDepartment(String? offerPeriodNameNew,
      {required Function(bool val) onCallBack}) {
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select Department",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        // SizedBox(height: 10,),
                        SizedBox(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(width: w1 / 1.1,
                                    //     child: SearchCard(
                                    //       hint: "Search Department",
                                    //       onchange: (aa){
                                    //         context.read<SellerAdminBloc>()
                                    //             .add( DepartmentListEvent(aa,"", ""));
                                    //       },
                                    //     )
                                    // ),
                                    // SizedBox(height: 15,),
                                    BlocBuilder<SellerAdminBloc,
                                        SellerAdminState>(
                                      builder: (context, state) {
                                        if (state is DepartmentListLoading) {
                                          return LottieLoader();
                                        }
                                        if (state is DepartmentListSuccess) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListView.separated(
                                                primary: true,
                                                shrinkWrap: true,
                                                itemCount:
                                                    state.department!.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    GestureDetector(
                                                  onTap: () {
                                                    onselect(index);
                                                    setState(() {});
                                                    departmentCode = state
                                                            .department?[index]
                                                            .opCode ??
                                                        "";
                                                    departmentCodeUser = state
                                                            .department?[index]
                                                            .opCode ??
                                                        "";
                                                    departmentName = state
                                                            .department?[index]
                                                            .name ??
                                                        "";
                                                    onCallBack!(true);
                                                    refresh();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    // left: 8,
                                                                    bottom: 5,
                                                                    top: 5,
                                                                    right: 8),
                                                            child: SvgPicture.string(state
                                                                        .department?[
                                                                            index]
                                                                        .name ==
                                                                    offerPeriodNameNew
                                                                // selectIndex == index
                                                                ? HomeSvg()
                                                                    .radioButtonActive
                                                                : HomeSvg()
                                                                    .radioInActive),
                                                          ),
                                                          SizedBox(
                                                            // padding: const EdgeInsets.only(bottom: 5),
                                                            width: w / 1.5,
                                                            child: Text(
                                                              state
                                                                      .department?[
                                                                          index]
                                                                      .name
                                                                      .toString()
                                                                      .toTitleCase() ??
                                                                  "",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    w / 24,
                                                                // fontWeight: FontWeight.w500,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        Container(
                                                  color: ColorPalette.divider,
                                                  height: 1,
                                                  margin: const EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  width: w,
                                                ),
                                              ),
                                              SizedBox(
                                                height: h / 40,
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //   MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     state.prevPageUrl == null
                                              //         ? Text("")
                                              //         : GestureDetector(
                                              //       onTap: () {
                                              //         context.read<SellerAdminBloc>().add(
                                              //             OfficialRoleListEvent('',"",
                                              //                 state
                                              //                     .nextPageUrl ??
                                              //                     "",
                                              //                 ));
                                              //       },
                                              //       child: Text(
                                              //         "Previous",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //     state.nextPageUrl == null
                                              //         ? Text("")
                                              //         : GestureDetector(
                                              //       onTap: () {
                                              //         context.read<SellerAdminBloc>().add(
                                              //             OfficialRoleListEvent("",
                                              //                 state
                                              //                     .nextPageUrl ??
                                              //                     "",
                                              //                 ""));
                                              //       },
                                              //       child: Text(
                                              //         "Next",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              SizedBox(
                                                height: h / 10,
                                              ),
                                            ],
                                          );
                                        }
                                        return SizedBox(
                                            width: w,
                                            height: 300,
                                            child: customCupertinoLoading());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Continue",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),)
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomBusinessCodeList(String? offerPeriodNameNew,
      {required Function(bool val) onCallBack}) {
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select Business",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        // SizedBox(height: 10,),
                        SizedBox(
                          height: h / 2.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: w1 / 1.1,
                                        child: SearchCard(
                                          hint: "Search Department",
                                          onchange: (aa) {
                                            context.read<SellerAdminBloc>().add(
                                                DepartmentListEvent(
                                                    aa, "", ""));
                                          },
                                        )),
                                    BlocBuilder<SellerAdminBloc,
                                        SellerAdminState>(
                                      builder: (context, state) {
                                        if (state
                                            is BusinessOutletListLoading) {
                                          return Container(
                                              height: 200,
                                              width: w,
                                              alignment: Alignment.center,
                                              child: LoadingAnimationWidget
                                                  .threeRotatingDots(
                                                color: Colors.red,
                                                size: 30,
                                              ));
                                        }
                                        if (state
                                            is BusinessOutletListSuccess) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListView.separated(
                                                primary: true,
                                                shrinkWrap: true,
                                                itemCount:
                                                    state.category!.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    GestureDetector(
                                                  onTap: () {
                                                    onselect(index);
                                                    setState(() {});
                                                    businessunitCode = state
                                                            .category?[index]
                                                            .businessUnitCode ??
                                                        "";
                                                    businessunitName = state
                                                            .category?[index]
                                                            .name ??
                                                        "";
                                                    onCallBack!(true);
                                                    refresh();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    // left: 8,
                                                                    bottom: 5,
                                                                    top: 5,
                                                                    right: 8),
                                                            child: SvgPicture.string(state
                                                                        .category?[
                                                                            index]
                                                                        .name ==
                                                                    offerPeriodNameNew
                                                                // selectIndex == index
                                                                ? HomeSvg()
                                                                    .radioButtonActive
                                                                : HomeSvg()
                                                                    .radioInActive),
                                                          ),
                                                          SizedBox(
                                                            // padding: const EdgeInsets.only(bottom: 5),
                                                            width: w / 1.5,
                                                            child: Text(
                                                              state
                                                                      .category?[
                                                                          index]
                                                                      .name
                                                                      .toString()
                                                                      .toTitleCase() ??
                                                                  "",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    w / 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        Container(
                                                  color: ColorPalette.divider,
                                                  height: 1,
                                                  margin: const EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  width: w,
                                                ),
                                              ),
                                              SizedBox(
                                                height: h / 40,
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //   MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     state.prevPageUrl == null
                                              //         ? Text("")
                                              //         : GestureDetector(
                                              //       onTap: () {
                                              //         context.read<SellerAdminBloc>().add(
                                              //             OfficialRoleListEvent('',"",
                                              //                 state
                                              //                     .nextPageUrl ??
                                              //                     "",
                                              //                 ));
                                              //       },
                                              //       child: Text(
                                              //         "Previous",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //     state.nextPageUrl == null
                                              //         ? Text("")
                                              //         : GestureDetector(
                                              //       onTap: () {
                                              //         context.read<SellerAdminBloc>().add(
                                              //             OfficialRoleListEvent("",
                                              //                 state
                                              //                     .nextPageUrl ??
                                              //                     "",
                                              //                 ""));
                                              //       },
                                              //       child: Text(
                                              //         "Next",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              SizedBox(
                                                height: h / 10,
                                              ),
                                            ],
                                          );
                                        }
                                        return SizedBox(
                                            width: w,
                                            height: 300,
                                            child: customCupertinoLoading());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomDesignation(String? offerPeriodNameNew) {
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select Designation",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        // SizedBox(height: 10,),
                        SizedBox(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<SellerAdminBloc,
                                        SellerAdminState>(
                                      builder: (context, state) {
                                        if (state is DesignationListLoading) {
                                          return LottieLoader();
                                        }
                                        if (state is DesignationListSuccess) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListView.separated(
                                                primary: true,
                                                shrinkWrap: true,
                                                itemCount:
                                                    state.designation!.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    GestureDetector(
                                                  onTap: () {
                                                    onselect(index);
                                                    setState(() {});
                                                    designationCode = state
                                                            .designation?[index]
                                                            .code ??
                                                        "";
                                                    designationName = state
                                                            .designation?[index]
                                                            .title ??
                                                        "";
                                                    // offerperiodId =
                                                    //     state.offerPeriod.data[index].id ??
                                                    //         0;
                                                    // offerPeriodName = state.offerPeriod
                                                    //     .data[index].title ??
                                                    //     "";
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              onselect(index);
                                                              setState(() {});
                                                              // offerperiodId = state
                                                              //     .offerPeriod
                                                              //     .data[index]
                                                              //     .id ??
                                                              //     0;
                                                              // offerPeriodName = state
                                                              //     .offerPeriod
                                                              //     .data[index]
                                                              //     .title ??
                                                              //     "";
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      // left: 8,
                                                                      bottom: 5,
                                                                      top: 5,
                                                                      right: 8),
                                                              child: SvgPicture.string(state
                                                                          .designation?[
                                                                              index]
                                                                          .name ==
                                                                      offerPeriodNameNew
                                                                  // selectIndex == index
                                                                  ? HomeSvg()
                                                                      .radioButtonActive
                                                                  : HomeSvg()
                                                                      .radioInActive),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            // padding: const EdgeInsets.only(bottom: 5),
                                                            width: w / 1.5,
                                                            child: Text(
                                                              state
                                                                      .designation?[
                                                                          index]
                                                                      .title
                                                                      .toString()
                                                                      .toTitleCase() ??
                                                                  "",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    w / 24,
                                                                // fontWeight: FontWeight.w500,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        Container(
                                                  color: ColorPalette.divider,
                                                  height: 1,
                                                  margin: const EdgeInsets.only(
                                                      top: 3, bottom: 3),
                                                  width: w,
                                                ),
                                              ),
                                              SizedBox(
                                                height: h / 40,
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //   MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     state.prevPageUrl == null
                                              //         ? Text("")
                                              //         : GestureDetector(
                                              //       onTap: () {
                                              //         context.read<SellerAdminBloc>().add(
                                              //             OfficialRoleListEvent('',"",
                                              //                 state
                                              //                     .nextPageUrl ??
                                              //                     "",
                                              //                 ));
                                              //       },
                                              //       child: Text(
                                              //         "Previous",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //     state.nextPageUrl == null
                                              //         ? Text("")
                                              //         : GestureDetector(
                                              //       onTap: () {
                                              //         context.read<SellerAdminBloc>().add(
                                              //             OfficialRoleListEvent("",
                                              //                 state
                                              //                     .nextPageUrl ??
                                              //                     "",
                                              //                 ""));
                                              //       },
                                              //       child: Text(
                                              //         "Next",
                                              //         style: TextStyle(
                                              //             fontWeight: FontWeight.w500,
                                              //             color: ColorPalette.primary,
                                              //             fontSize: w / 24),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(
                                              //   height: h/10,
                                              // ),
                                            ],
                                          );
                                        }
                                        return SizedBox(
                                            width: w,
                                            height: 300,
                                            child: Center(
                                                child: Text("List Is Empty")));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           _showModalBottomCreateDesignation(departmentCode);
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Create New",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),)
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomCreateDesignation(String departMentCode) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          double w1 = MediaQuery.of(context).size.width;
          double w = w1 > 700 ? 400 : w1;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateHere) {
              print("department code here 111 $departmentCode");

              return Container(
                height: h / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Create Designation",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        // SizedBox(height: 10,),
                        SizedBox(
                          height: h / 2.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormReusable(
                                      label: "Title",
                                      hint: "",
                                      controller: designationTitle,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    TextFormReusable(
                                      label: "Description",
                                      hint: "",
                                      controller: designationDescription,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    DropDownCard(
                                      label: "Department",
                                      selValue: departmentName,
                                      onTap: () {
                                        context.read<SellerAdminBloc>().add(
                                            const DepartmentListEvent(
                                                '', "", ""));
                                        _showModalBottomDepartment(
                                            departmentName,
                                            onCallBack: (bool val) {
                                          print("clllling back hereeee");
                                          setStateHere(() {});
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              // context.read<SellerAdminBloc>()
                              //     .add( CreateDesignationEvent(
                              //     title: designationTitle.text,
                              //     legalEntity: widget.entityCode??"",
                              //     department: departmentCode,
                              //     description: designationDescription.text
                              // ));
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Create New",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Future<void> getImage(source) async {
    try {
      // final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom,
      //   allowedExtensions: ['jpg', ],);
      // // print("pickk pathhhhhhh${pickedFile?.}");
      // // Variable.imageTyp=pickedFile?.files.first.name??"";
      // Uint8List? bytes;


      final pickedFile = await picker.pickImage(
        source: source,
        // imageQuality: 20,

        // maxHeight: 2000, maxWidth: 2000,
      );

      if (pickedFile != null) {
        // Check if the image needs to be cropped
        final  croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1), // Adjust aspect ratio if needed
          compressFormat: ImageCompressFormat.png, // Adjust format if needed
          cropStyle: CropStyle
              .rectangle, // Adjust crop style as needed (e.g., rectangle, circle)
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
              statusBarColor: Colors.white,
            ),


            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.dialog,
              boundary: CroppieBoundary(
                width: 420,
                height: 420,
              ),
              viewPort: CroppieViewPort(
                  width: 420,
                  height: 420,
                  type: 'circle'
              ),
              enableExif: true,
              enableZoom: true,
              showZoomer: true,
            )



          ],

          // Adjust compress quality if needed (0 - 100)
          // iosUiSettings: IOSUiSettings(),
        );
        print("croped file$croppedFile");


        if (croppedFile != null) {
          // try {
          //   Uint8List uint8List = await croppedFileToUint8List(croppedFile);
          //   print("searching uni$uint8List");
          //   // Now you have the Uint8List representation of the cropped file.
          //   BlocProvider.of<InventoryBloc>(context).add(PicEvent(bytes: imageBytes!,));
          // } catch (error) {
          //   print('Error: $error');
          // }
          // Convert CroppedFile to File
          final File file = File(croppedFile.path);
          print("croppedFile.openRead()${file}");



          // Do something with the File, e.g., update your UI
          setState(() {
            cropImage = file;
            _cropped = true;
          });


          // Uint8List imageBytes = await croppedFile.readAsBytes();
          // Variable.imageTyp=pickedFile?.name??"";

          BlocProvider.of<EmployeeBloc>(context)
              .add(PostImageAll2Event(file!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
