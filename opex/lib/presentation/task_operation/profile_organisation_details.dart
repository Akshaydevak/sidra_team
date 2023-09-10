import 'dart:io';

import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/loading.dart';
import '../../common_widgets/no_glow.dart';
import '../../common_widgets/reusable_textfield.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/profile/profile_bloc/profile_bloc.dart';
import '../dashboard_screen/profile/profile_svg.dart';
import '../seller_admin_app/model_seller_admin/seller_admin_models.dart';
import '../seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';

class ProfileOrganisation extends StatefulWidget {
  const ProfileOrganisation({super.key});

  @override
  State<ProfileOrganisation> createState() => _ProfileOrganisationState();
}

class _ProfileOrganisationState extends State<ProfileOrganisation> {
  String profilePic='';
  @override
  void initState() {
    context.read<SellerAdminBloc>().add(GetBusinessDetailsRead());
    super.initState();
  }
  TextEditingController organisationName=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController emailId=TextEditingController();
  TextEditingController conatact=TextEditingController();
  TextEditingController addressOne=TextEditingController();
  TextEditingController location=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController statein=TextEditingController();
  TextEditingController country=TextEditingController();
  bool _isLoading = true;
  SellerListAdmin? readBusiness;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  bool onChange=false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UpdateOrgProfilePicLoading) {
              context.read<SellerAdminBloc>().add(GetBusinessDetailsRead());
            }
            if (state is UpdateOrgProfilePicSuccess) {
              context.read<SellerAdminBloc>().add(GetBusinessDetailsRead());
            }
          },
        ),
      BlocListener<SellerAdminBloc, SellerAdminState>(
          listener: (context, state) {
            if(state is GetBusinessDetailsReadLoading){

            }
            if(state is GetBusinessDetailsReadSuccess){
              readBusiness=state.seller;
              print("ffffff$readBusiness");
              organisationName.text=readBusiness?.name??"";
              description.text=readBusiness?.description??"";
              emailId.text=readBusiness?.email??"";
              conatact.text=readBusiness?.contact?.primary??"";
              profilePic=readBusiness?.logo??"";

              addressOne.text=readBusiness?.addressOne??"";
              location.text=readBusiness?.location??"";
              city.text=readBusiness?.cityortown??"";
              statein.text=readBusiness?.state??"";
              country.text=readBusiness?.country??"";
              address.text="${addressOne.text}, ${location.text}, ${city.text}, ${statein.text}, ${country.text}";
              _isLoading=false;
              setState(() {

              });
            }
          },),
        BlocListener<SellerAdminBloc, SellerAdminState>(
          listener: (context, state) {
            if(state is UpdateOrganisationLoading){
              customCupertinoLoading();
            }
            if (state is UpdateOrganisationSuccess) {

              showSnackBar(context, message: state.successMessage??"", color: Colors.black);

            }
          },
        ),
      ],
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorPalette.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: BackAppBar(
                  label: "Your Organization",
                isAction: false,
                action: onChange==true?Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: (){

                      context.read<SellerAdminBloc>().add(OrgUpdateEvent(
                        cityorTown: city.text,
                        id: readBusiness?.id??0,
                        userId: authentication.authenticatedUser.code,
                        categoryId: readBusiness?.categoryId??0,
                        email: emailId.text,
                        phone: conatact.text,
                        address: addressOne.text,
                        country: country.text,
                        discription: description.text,
                        displayName: readBusiness?.displayname??"",
                        landmark: readBusiness?.landmark??"",
                        location: location.text,
                        name: organisationName.text,
                        parentId: null,
                        phoneTwo: null,
                        postalCode: readBusiness?.pin??"",
                        searchName: readBusiness?.searchname??"",
                        state: statein.text
                      ));
                    },
                    child: Text(
                      "Update",
                      style: GoogleFonts.roboto(
                        color: Color(0xFF2871AF),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                        // height: 1.56,
                      ),
                    ),
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: (){

                    },
                    child: Text(
                      "Update",
                      style: GoogleFonts.roboto(
                        color: Color(0xFFD3D3D3),
                        fontSize: w/24,
                        fontWeight: FontWeight.w500,
                        // height: 1.56,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(_isLoading)...[
                  LottieLoader()
              ]
              else...[
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),

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
                                            profilePic ?? ""),
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
                                    )),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormReusable(
                            label: "Organisation Name",
                            hint: "eg.Tom",
                            controller: organisationName,
                            // controller: fNameController,
                            isMandatory: false,
                            onchange: (f){
                              onChange=true;
                              setState(() {

                              });
                            },

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormReusable(
                            label: "Description",
                            hint: "eg.Tom",
                            controller: description,
                            // controller: fNameController,
                            isMandatory: false,
                            onchange: (f){
                              onChange=true;
                              setState(() {

                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormReusable(
                            label: "Address",
                            hint: "eg.Tom",
                            controller: address,
                            readOnly: true,
                            error: "Edit Address",
                            onTap: (){

                              _showModalBottomAdditionalRole();
                            },
                            isError: true,
                            isMandatory: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormReusable(
                            label: "Email",
                            hint: "eg.Tom",
                            controller: emailId,
                            readOnly: true,
                            error: "Change Request",
                            onTap: ()async{

                              String email = Uri.encodeComponent("care@sidrateams.com");
                              String subject = Uri.encodeComponent("Change E-Mail Address");
                              String body = Uri.encodeComponent("Hi,");
                              print(subject); //output: Hello%20Flutter
                              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                              if (await launchUrl(mail)) {

                              }else{

                              }
                            },
                            isError: true,
                            isMandatory: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormReusable(
                            label: "Contact Number",
                            hint: "eg.Tom",
                            controller: conatact,
                            readOnly: true,
                            error: "Change Request",
                            onTap: ()async{

                              String email = Uri.encodeComponent("care@sidrateams.com");
                              String subject = Uri.encodeComponent("Change Contact Number");
                              String body = Uri.encodeComponent("Hi,");
                              print(subject); //output: Hello%20Flutter
                              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                              if (await launchUrl(mail)) {

                              }else{

                              }
                            },
                            isError: true,
                            isMandatory: false,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                 ]

                  ],
                ),
              ),
            ),
          )),
    );
  }
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
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.5,
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
                          "Edit Address",
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
                          height: h/2,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormReusable(
                                      label: "Address",
                                      hint: "eg.Tom",
                                      controller: addressOne,
                                      isMandatory: false,
                                      onchange: (f){
                                        onChange=true;
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormReusable(
                                      label: "Location",
                                      hint: "eg.Tom",
                                      controller: location,
                                      isMandatory: false,
                                      onchange: (f){
                                        onChange=true;
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormReusable(
                                      label: "City",
                                      hint: "eg.Tom",
                                      controller: city,
                                      isMandatory: false,
                                      onchange: (f){
                                        onChange=true;
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormReusable(
                                      label: "State",
                                      hint: "eg.Tom",
                                      controller: statein,
                                      isMandatory: false,
                                      onchange: (f){
                                        onChange=true;
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormReusable(
                                      label: "Country",
                                      hint: "eg.Tom",
                                      controller: country,
                                      isMandatory: false,
                                      onchange: (f){
                                        onChange=true;
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
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
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
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
                              "Update",
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
      final pickedFile =
      await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;
      print(cropImage);
      if (cropImage != null) {
        context
            .read<ProfileBloc>()
            .add(UpdateOrgProfilePicEvent(profilePic: cropImage!,id: readBusiness?.id));
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
