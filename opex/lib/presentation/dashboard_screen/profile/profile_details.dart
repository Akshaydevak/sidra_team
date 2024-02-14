import 'dart:io';

import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
import 'package:cluster/presentation/dashboard_screen/profile/widget/profile_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common_widgets/gradient_button.dart';
import '../home_screen/homescreen_widget/appbar.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  String? selectedGender;
  List<String> gender = ["Male", "Female", "Other"];
  String? selectedNationality;
  String? selGender;
  List<String> nationality = ["IN", "AE", "US"];
  File? cropImage;
  List<String> nationalityList = [];
  bool _cropped = false;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfilePicEvent());
    context.read<ProfileBloc>().add(GetProfileEvent());
    // nameController.text=authentication.authenticatedUser.fname??"";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(
          label: "Profile Details",
          isAction: false,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child:  MultiBlocListener(
              listeners: [
            BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileLoading){
                    print("Loading...............");
                  } if (state is UpdateProfileFailed){
                    Fluttertoast.showToast(
                        msg: state.msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorPalette.primary,
                        textColor: Colors.white);
                    print("Loading...............");
                  }
                  if (state is UpdateProfileSuccess){
                    print("success...............");
                    Fluttertoast.showToast(
                        msg: state.msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorPalette.primary,
                        textColor: Colors.white);
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  }
                  if (state is UpdateProfilePicSuccess){
                    print("success...............");
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorPalette.primary,
                        textColor: Colors.white);
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  }
                  if (state is UpdateProfilePicFailed){
                    print("failed...............");
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorPalette.primary,
                        textColor: Colors.white);
                    context.read<ProfileBloc>().add(GetProfileEvent());
                  }

    }),],

                 child: Container(
                  // padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        height: 1.50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xb2e6e6e6),
                            width: 0.50,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [

                            BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                              if (state is ProfileLoading) {
                                return Text("");
                              }if (state is ProfileFailed) {
                                return Text("Failed..........");
                              }
                              if (state is ProfileSuccess) {
                                nameController =
                                    TextEditingController(text: state.user.fname);
                                // mobileController =
                                //     TextEditingController(text: state.user.mobile);
                                emailController =
                                    TextEditingController(text: state.user.email);

                                selectedGender=selectedGender==null?state.user.gender=="M"?"Male":state.user.gender=="F"?"Female":"Other"??"":selectedGender;
                                selectedNationality=selectedNationality==null?state.user.country:selectedNationality;
                                print(selectedGender);
                                // emailController =
                                //     TextEditingController(text: state.user.email);
                                return Container(
                                  width: w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 170,
                                          height: 190,
                                          // color: Colors.yellow,
                                          child: Stack(
                                            children: [

                                            Container(
                                            width: 160,
                                            height: 181,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(state.user.userMete?.profile??""),
                                                  fit: BoxFit.fill),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3,
                                              ),
                                            ),
                                          ),
                                          // Image.asset("asset/newprofile.png"),


                                          Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              getImage(ImageSource.gallery);
                                            },
                                            child: Container(
                                              width: 58,
                                              height: 58,
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                color: Color(0xfffe5762),
                                              ),
                                              child: SvgPicture.string(
                                                  ProfileSvg().editProfileIcon),
                                            ),
                                          ))
                                    ],
                                  ),
                                    ),
                                    SizedBox(
                                    height: 30,
                                    ),
                                      Container(
                                        // height: 80,
                                        width: w,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
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
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 16, bottom: 0, right: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorPalette.primary
                                                          .withOpacity(0.1),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.string(
                                                        ProfileSvg().personIcon,
                                                        color: ColorPalette.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    width: w / 1.5,
                                                    child: ProfileTextField(
                                                      readOnly: false,
                                                      controller: nameController,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Divider(
                                              indent: 70,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 16, bottom: 0, right: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorPalette.primary
                                                          .withOpacity(0.1),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.string(
                                                          ProfileSvg().contactIcon),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    width: w / 1.5,
                                                    child: ProfileTextField(
                                                      readOnly: true,
                                                      controller: mobileController,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Divider(
                                              indent: 70,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 16, bottom: 20, right: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorPalette.primary
                                                          .withOpacity(0.1),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.string(
                                                          ProfileSvg().emailIcon),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    width: w / 1.5,
                                                    child: ProfileTextField(
                                                      readOnly: true,
                                                      controller: emailController,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Tap to change first name, Phone number and E-Mail address accordingly.",
                                        style: TextStyle(
                                            color: Color(0xff7d7d7d),
                                            fontSize: w / 27,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Gender",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: w / 2.3,
                                                // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                //height: 20.0,
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border:
                                                  Border.all(color: Colors.grey, width: 1),
                                                ),
                                                child: DropdownButton(
                                                    isExpanded: true,
                                                    icon: Icon(
                                                        Icons.keyboard_arrow_down_outlined),
                                                    underline: Container(),
                                                    items: gender.map((String item) {
                                                      return DropdownMenuItem(
                                                        enabled: true,
                                                        value: item,
                                                        child: Text(item,
                                                            style:
                                                            TextStyle(color: Colors.black)),
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
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nationality",
                                                style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: w / 2.3,
                                                // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                //height: 20.0,
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border:
                                                  Border.all(color: Colors.grey, width: 1),
                                                ),
                                                child:    DropdownButton(
                                                    isExpanded: true,
                                                    icon: Icon(
                                                        Icons.keyboard_arrow_down_outlined),
                                                    underline: Container(),
                                                    items: nationality.map((String items) {
                                                      return DropdownMenuItem(
                                                        enabled: true,
                                                        value: items,
                                                        child: Text(items,
                                                            style:
                                                            TextStyle(color: Colors.black)),
                                                      );
                                                    }).toList(),
                                                    value: selectedNationality,
                                                    onChanged: (dynamic values) {
                                                      setState(() {
                                                        selectedNationality = values;


                                                      });
                                                    },
                                                    hint: Text(
                                                      "UAE",
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.grey, fontSize: 14),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            }),

                            SizedBox(
                              height: 30,
                            ),
                            GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  print(selGender);
                                  context.read<ProfileBloc>().add(UpdateProfileEvent(
                                      mobile: mobileController.text,
                                      lname: "",
                                      fname: nameController.text,
                                      dob: "",
                                      email: emailController.text,
                                    gender:selGender,
                                    country: selectedNationality
                                  ));
                                  //  updateProfile
                                },
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: const [
                                      ColorPalette.primary,
                                      ColorPalette.primary,
                                      // Color(0xffd3d3d3),
                                      // Color(0xffd3d3d3)
                                    ]),
                                child: Text(
                                  "Update",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )


          ),
        ),
      ),
    );
  }

  Future<void> getImage(source) async {
    try {
      final pickedFile =
          await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;
      print(cropImage);
      if (cropImage != null) {
        context.read<ProfileBloc>().add(UpdateProfilePicEvent(profilePic:cropImage! ));
        // BlocProvider.of<ProfilePicBloc>(context)
        //     .add(UpdatePictureEvent(cropImage!));
      }
      setState(() {
        _cropped = true;
      });

      //Navigator.pop(context);
    } catch (e) {}
  }
}
