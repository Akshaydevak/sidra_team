import 'dart:io';

import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_svg.dart';
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
  final picker = ImagePicker();
  File? cropImage;
  List<String> nationalityList = [];
  bool _cropped = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Column(
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
                Text(
                  "Style",
                  style: GoogleFonts.roboto(
                    color: Color(0xFF2871AF),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.56,
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
            height: 30,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccess) {
                return Container(
                  width: 100,
                  height: 110,
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
                              image: NetworkImage(state.user.prflImage ?? ""),
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
                                color:Colors.grey.shade200,
                              ),
                              child: SvgPicture.string(
                                  ProfileSvg().editProfileIcon,),
                            ),
                          ))
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    ));
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
