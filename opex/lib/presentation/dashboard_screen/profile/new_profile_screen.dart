import 'dart:io';

import 'package:cluster/common_widgets/profile_text_field.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
import 'package:cluster/presentation/dashboard_screen/profile/widget/profile_textfield.dart';
import 'package:cluster/presentation/dashboard_screen/profile/widgets/profile_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class NewProfileScreen extends StatefulWidget {
  const NewProfileScreen({super.key});

  @override
  State<NewProfileScreen> createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  List<bool> readOnly = [true,true,true];
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }

  final picker = ImagePicker();
  File? cropImage;
  List<String> nationalityList = [];
  bool _cropped = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfilePicSuccess) {
          context.read<ProfileBloc>().add(GetProfileEvent());
        }
        if (state is UpdateProfileSuccess) {
          readOnly = [true,true,true];
          context.read<ProfileBloc>().add(GetProfileEvent());
        }
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
        backgroundColor: ColorPalette.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         context.read<ProfileBloc>().add(UpdateProfileEvent(
                                      mobile: mobileController.text,
                                      lname: "",
                                      fname: nameController.text,
                                      dob: "",
                                      email: emailController.text,
                                   
                                  ));
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.roboto(
                          color: Color(0xFF2871AF),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.56,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 1,
                width: w,
                color: Colors.grey.shade200,
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileSuccess) {
                    nameController =
                        TextEditingController(text: state.user.fname);
                    mobileController =
                        TextEditingController(text: state.user.mobile);
                    emailController =
                        TextEditingController(text: state.user.email);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          // color: Colors.yellow,
                          child: Stack(
                            children: [
                              Container(
                                width: 80,
                                // height: 181,
                                decoration: BoxDecoration(
                                  // color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          state.user.prflImage ?? ""),
                                      fit: BoxFit.fill),
                                  // border: Border.all(
                                  //   color: Colors.white,
                                  //   width: 3,
                                  // ),
                                ),
                              ),
                              // Image.asset("asset/newprofile.png"),
        
                              Positioned(
                                  bottom: 7,
                                  right: 0,
                                  // left: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                    },
                                    child: SvgPicture.string(
                                      ProfileSvg().editProfileIcon,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              ProfileTextFormField(
                                onTap: () {
                                  readOnly[0] = !readOnly[0];
                                  setState(() {});
                                },
                                readOnly: readOnly[0],
                                controller: nameController,
                              ),
                              // SizedBox(
                              //   height: 4,
                              // ),
                              ProfileTextFormField(
                                onTap: () {
                                  readOnly[1] = !readOnly[1];
                                  setState(() {});
                                },
                                readOnly: readOnly[1],
                                controller: mobileController,
                              ),
                              // SizedBox(
                              //   height: 4,
                              // ),
                              ProfileTextFormField(
                                onTap: () {
                                  readOnly[2] = !readOnly[2];
                                  setState(() {});
                                },
                                readOnly: readOnly[2],
                                controller: emailController,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                // color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "More About",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileMenuCard(
                        iconSvg: AppsSvg().languageSvgIcon, title: "Language"),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: w,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileMenuCard(
                        iconSvg: AppsSvg().taskProfileIcon,
                        title: "Task and Activities"),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: w,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileMenuCard(
                        iconSvg: AppsSvg().notificationProfileIcon,
                        title: "Notification Alert"),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: w,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileMenuCard(
                        iconSvg: AppsSvg().logoutProfileIcon, title: "Logout"),
                           SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: w,
                      color: Colors.grey.shade200,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileMenuCard(
                        iconSvg: AppsSvg().helpandsupportIconProfile, title: "Help & Support"),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> getImage(source) async {
    try {
      final pickedFile =
          await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;
      print(cropImage);
      if (cropImage != null) {
        context
            .read<ProfileBloc>()
            .add(UpdateProfilePicEvent(profilePic: cropImage!));
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
