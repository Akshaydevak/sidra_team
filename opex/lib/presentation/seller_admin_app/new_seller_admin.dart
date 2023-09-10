// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/common_widgets/string_extensions.dart';
// import 'package:cluster/presentation/seller_admin_app/model_seller_admin/seller_admin_models.dart';
// import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
// import 'package:cluster/presentation/seller_admin_app/seller_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// import '../../common_widgets/gradient_button.dart';
// import '../../common_widgets/reusable_textfield.dart';
// import '../../common_widgets/title_app_bar.dart';
// import '../../core/color_palatte.dart';
// import '../../core/common_snackBar.dart';
// import '../dashboard_screen/home_screen/home_svg.dart';
// import '../mpos/search_card.dart';
// import '../promotion_app/dropdown_card.dart';
//
// class NewSellerAdmin extends StatefulWidget {
//   final bool? editSeller;
//   const NewSellerAdmin({Key? key, this.editSeller}) : super(key: key);
//
//   @override
//   State<NewSellerAdmin> createState() => _NewSellerAdminState();
// }
//
// class _NewSellerAdminState extends State<NewSellerAdmin> {
//   int selectIndex = 0;
//   String nextUrl = "";
//   String prevUrl = "";
//   int? categoryId;
//   String? categoryName;
//   String? drop;
//   String? dropState;
//   TextEditingController nameController=TextEditingController();
//   TextEditingController searchNameController=TextEditingController();
//   TextEditingController displayNameController=TextEditingController();
//   TextEditingController descriptionController=TextEditingController();
//   TextEditingController addressController=TextEditingController();
//   TextEditingController locationController=TextEditingController();
//   TextEditingController countryController=TextEditingController();
//   TextEditingController stateController=TextEditingController();
//   TextEditingController cityController=TextEditingController();
//   TextEditingController landmarkController=TextEditingController();
//   TextEditingController postelCodeController=TextEditingController();
//   TextEditingController emailController=TextEditingController();
//   TextEditingController mobileController=TextEditingController();
//   String contactNumber='';
//   List<CountryStateModel>? countryList=[];
//   List<StateModel>? stateList=[];
//   SellerListAdmin? sellerRead;
//   @override
//   void initState() {
//     context.read<SellerAdminBloc>().add(const CountryListEvent());
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     double w1 = MediaQuery.of(context).size.width ;
//     double w = w1> 700
//         ? 400
//         : w1;
//     return MultiBlocListener(
//   listeners: [
//     BlocListener<SellerAdminBloc, SellerAdminState>(
//   listener: (context, state) {
//     if(state is CreateSellerLoading){
//       showSnackBar(context,
//           message: "Seller Creation Loading",
//           color: ColorPalette.green);
//     }
//     if(state is CreateSellerSuccess){
//       showSnackBar(context,
//           message:"Seller Created Successfully",
//           color: ColorPalette.green);
//       context
//           .read<SellerAdminBloc>()
//           .add( GetSellerRead(int.tryParse(state.successMessage??"")??0));
//       PersistentNavBarNavigator.pushNewScreen(
//         context,
//         screen: SellerView(),
//         withNavBar: false, // OPTIONAL VALUE. True by default.
//         pageTransitionAnimation: PageTransitionAnimation.fade,
//       );
//     }
//     if(state is CreateSellerFailed){
//
//         showSnackBar(context,
//             message: state.error??"",
//             color: ColorPalette.green);
//
//     }
//     // TODO: implement listener
//   },
// ),
//     BlocListener<SellerAdminBloc, SellerAdminState>(
//       listener: (context, state) {
//         if(state is UpdateSellerLoading){
//           showSnackBar(context,
//               message: "Seller Creation Loading",
//               color: ColorPalette.green);
//         }
//         if(state is UpdateSellerSuccess){
//           showSnackBar(context,
//               message:"Seller Updated Successfully",
//               color: ColorPalette.green);
//           context
//               .read<SellerAdminBloc>()
//               .add( GetSellerRead(sellerRead?.id??0));
//           Navigator.pop(context);
//           Navigator.pop(context);
//
//         }
//         if(state is UpdateSellerFailed){
//
//           showSnackBar(context,
//               message: state.error??"",
//               color: ColorPalette.green);
//
//         }
//         // TODO: implement listener
//       },
//     ),
//     BlocListener<SellerAdminBloc, SellerAdminState>(
//       listener: (context, state) {
//        if(state is GetCountryListLoading){
//
//        }
//        if(state is GetCountryListSuccess){
//          countryList=state.country;
//          setState(() {
//
//          });
//        }
//       },
//     ),
//     BlocListener<SellerAdminBloc, SellerAdminState>(
//       listener: (context, state) {
//         if(state is GetStateListLoading){
//
//         }
//         if(state is GetStateListSuccess){
//           stateList=state.state;
//           setState(() {
//
//           });
//         }
//       },
//     ),
//     BlocListener<SellerAdminBloc, SellerAdminState>(
//       listener: (context, state) {
//         if (state is GetSellerReadLoading) {}
//         if (state is GetSellerReadSuccess) {
//           sellerRead = state.seller;
//           nameController.text=sellerRead?.name??"";
//           searchNameController.text=sellerRead?.searchname??"";
//           displayNameController.text=sellerRead?.displayname??"";
//           descriptionController.text=sellerRead?.description??"";
//           categoryName=sellerRead?.categoryName??"";
//           addressController.text=sellerRead?.addressOne??"";
//           locationController.text=sellerRead?.location??"";
//           drop ?? (drop=sellerRead?.country?.toUpperCase());
//           context.read<SellerAdminBloc>().add( StateListEvent(sellerRead?.country?.toUpperCase()??""));
//           dropState ?? (dropState=sellerRead?.state.toString().toTitleCase());
//           cityController.text=sellerRead?.cityortown??"";
//           landmarkController.text=sellerRead?.landmark??"";
//           postelCodeController.text=sellerRead?.pin??"";
//           emailController.text=sellerRead?.email??"";
//           mobileController.text=sellerRead?.contact?.primary??"";
//
//           print("readSeller${sellerRead?.country}");
//           print("readSeller$drop");
//           print("readSeller$dropState");
//           setState(() {});
//         }
//       },
//     ),
//   ],
//   child: Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70),
//         child: TitleAppBar(label: widget.editSeller==true?"Edit Seller":"New Seller"),
//       ),
//       body: ScrollConfiguration(
//         behavior: NoGlow(),
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormReusable(
//                   label: "Business Name",
//                   hint: "eg.rawabi market",
//                   controller: nameController,
//                   isMandatory: true,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Search Name",
//                   hint: "eg.rawabi market",
//                   controller: searchNameController,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Display Name",
//                   hint: "eg.rawabi market",
//                   controller: displayNameController,
//                   isMandatory: true,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Description",
//                   hint: "eg.rawabi market",
//                   controller: descriptionController,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 DropDownCard(
//                   selValue: categoryName==""?"Select":categoryName,
//                   isMandatory: true,
//                   label: "Industry",
//                   onTap: () {
//                     context
//                         .read<SellerAdminBloc>()
//                         .add(const CategoryListSellerEvent("", "",''));
//                     _showModalBottomSheetCategory(categoryName);
//                   },
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Address",
//                   hint: "eg.McKenzie Glens(Ho)",
//                   controller: addressController,
//                   isMandatory: true,
//                 ),
//
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Location",
//                   hint: "eg.Ajman",
//                   controller: locationController,
//                   isMandatory: true,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "Country",
//                           style: GoogleFonts.roboto(
//                             color: ColorPalette.black,
//                             fontSize: w / 24,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 2),
//                           child: Text(
//                             " *",
//                             style: TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w900),
//                           ),
//                         )
//                       ],
//                     ),
//                     Container(
//                         width: w1 ,
//                         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Color(0xffe6ecf0),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x05000000),
//                               blurRadius: 8,
//                               offset: Offset(1, 1),
//                             ),
//                           ],
//                           color: Colors.white,
//                         ),
//                         child: DropdownButton(
//                           isExpanded: true,
//                           icon: Icon(Icons.keyboard_arrow_down,
//                               color: Color(0x7f666161)),
//                           elevation: 1,
//                           underline: Container(),
//                           hint: Text("UAE"),
//                           value: drop,
//                           items: countryList?.map((CountryStateModel items) {
//                             return DropdownMenuItem(
//
//                               alignment: Alignment.centerLeft,
//                               enabled: true,
//                               value: items.code,
//                               onTap: (){
//
//                               },
//                               child: Text(items.name??"",
//                                   style: GoogleFonts.poppins(
//                                       color: ColorPalette.black)),
//                             );
//                           }).toList(),
//                           onChanged: (dynamic value) {
//                             setState(() {
//                               print("inside dropdown${value}");
//                               // widget.onChangeChannel!(value ?? "");
//                               drop = value;
//                               context.read<SellerAdminBloc>().add( StateListEvent(value??""));
//                             });
//                           },
//                           // hint: Text(
//                           //   "Select",
//                           //   style: TextStyle(
//                           //     color: Color(0xbf666161),
//                           //     fontSize: w / 24,
//                           //   ),
//                           // )
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "State",
//                           style: GoogleFonts.roboto(
//                             color: ColorPalette.black,
//                             fontSize: w / 24,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 2),
//                           child: Text(
//                             " *",
//                             style: TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.w900),
//                           ),
//                         )
//                       ],
//                     ),
//                     Container(
//                         width: w1 ,
//                         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Color(0xffe6ecf0),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x05000000),
//                               blurRadius: 8,
//                               offset: Offset(1, 1),
//                             ),
//                           ],
//                           color: Colors.white,
//                         ),
//                         child: DropdownButton(
//                           isExpanded: true,
//                           icon: Icon(Icons.keyboard_arrow_down,
//                               color: Color(0x7f666161)),
//                           elevation: 1,
//                           underline: Container(),
//                           hint: Text("Ajman"),
//                           value: dropState,
//                           items: stateList?.map((StateModel items) {
//                             return DropdownMenuItem(
//
//                               alignment: Alignment.centerLeft,
//                               enabled: true,
//                               value: items.name,
//                               onTap: (){
//
//                               },
//                               child: Text(items.name??"",
//                                   style: GoogleFonts.poppins(
//                                       color: ColorPalette.black)),
//                             );
//                           }).toList(),
//                           onChanged: (dynamic value) {
//                             setState(() {
//                               print("inside dropdown${value}");
//                               // widget.onChangeChannel!(value ?? "");
//                               dropState = value;
//                             });
//                           },
//                           // hint: Text(
//                           //   "Select",
//                           //   style: TextStyle(
//                           //     color: Color(0xbf666161),
//                           //     fontSize: w / 24,
//                           //   ),
//                           // )
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "City",
//                   hint: "eg.Ajman",
//                   controller: cityController,
//                   isMandatory: true,
//                 ),
//
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Landmark",
//                   hint: "eg.Dubai mall",
//                   controller: landmarkController,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Postal Code",
//                   hint: "eg.65456",
//                   controller: postelCodeController,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 TextFormReusable(
//                   label: "Business Email",
//                   hint: "eg.example@email.com",
//                   controller: emailController,
//                   isMandatory: true,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Business Phone Number",
//                       style: GoogleFonts.roboto(
//                         color: Colors.black,
//                         fontSize: w / 24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 2),
//                       child: Text(
//                         " *",
//                         style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.w900),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 IntlPhoneField(
//                   initialCountryCode: "IN",
//                   controller: mobileController,
//                   validator: (text) {
//                     if (text == null) {
//                       return 'Text is empty';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     // suffixIcon:TextButton(
//                     //   onPressed: (){},
//                     //   child: Text(
//                     //     "Update",
//                     //     style: GoogleFonts.roboto(
//                     //       color: Color(0xfffe5762),
//                     //       fontSize: w/22,
//                     //       fontWeight: FontWeight.w500,
//                     //     ),
//                     //   ),
//                     // ),
//                     hintText: "eg.8606200441",
//                     hintStyle:
//                         GoogleFonts.roboto(color: Colors.grey, fontSize: 14),
//                     contentPadding: const EdgeInsets.only(
//                         left: 10, top: 10, bottom: 10, right: 10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Color(0xffe6ecf0)),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Color(0xffe6ecf0)),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Color(0xffe6ecf0), width: 1.0),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 1.0),
//                     ),
//                   ),
//                   onChanged: (phone) {
//                     contactNumber = phone.completeNumber.toString();
//                     mobileController =
//                         TextEditingController(text: phone.number);
//                   },
//                   onCountryChanged: (country) {},
//                   cursorColor: Colors.black,
//                   dropdownIcon: const Icon(
//                     Icons.arrow_right,
//                     color: Colors.white,
//                   ),
//                   dropdownIconPosition: IconPosition.trailing,
//                   flagsButtonMargin: const EdgeInsets.only(left: 10, right: 30),
//                   disableLengthCheck: false,
//                   showDropdownIcon: false,
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 GradientButton(
//                     color: Color(0xfffe5762),
//                     onPressed: () {
//                       print("mob${mobileController.text}");
//                       print("mob$contactNumber");
//                       widget.editSeller==true?
//                       context.read<SellerAdminBloc>().add(NewSellerUpdateEvent(
//                           name: nameController.text,
//                           userId: null,
//                           state: dropState??"",
//                           searchName: searchNameController.text,
//                           phone: contactNumber,
//                           location: locationController.text,
//                           landmark: landmarkController.text,
//                           email: emailController.text,
//                           displayName: displayNameController.text,
//                           country: drop??"",
//                           category: categoryId??0,
//                           address: addressController.text,
//                           isActive: true,
//                           cityorTown: cityController.text,
//                           discription: descriptionController.text,
//                           postalCode: postelCodeController.text,
//                         id: sellerRead?.id??0
//
//
//                       )):
//                       context.read<SellerAdminBloc>().add(NewSellerCreateEvent(
//                         name: nameController.text,
//                         userId: null,
//                         state: dropState??"",
//                         searchName: searchNameController.text,
//                         phone: contactNumber,
//                         location: locationController.text,
//                         landmark: landmarkController.text,
//                         email: emailController.text,
//                         displayName: displayNameController.text,
//                         country: drop??"",
//                         category: categoryId??0,
//                         address: addressController.text,
//                         isActive: true,
//                         cityorTown: cityController.text,
//                         discription: descriptionController.text,
//                         postalCode: postelCodeController.text
//
//
//                       ));
//                     },
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Color(0xfffe5762), Color(0xfffe5762)]),
//                     child: widget.editSeller==true?
//                     Text(
//                       "Update Seller",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.roboto(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ):Text(
//                       "Add New Seller",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.roboto(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
// );
//   }
//
//   _showModalBottomSheetCategory(String? offerPeriodNameNew) {
//     void onselect(int index) {
//       setState(() {
//         selectIndex = index;
//       });
//     }
//
//     showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(18), topRight: Radius.circular(18)),
//         ),
//         context: context,
//         builder: (context) {
//           var h = MediaQuery.of(context).size.height;
//           double w1 = MediaQuery.of(context).size.width ;
//           double w = w1> 700
//               ? 400
//               : w1;
//           return StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       topLeft: Radius.circular(10),
//                     )),
//                 alignment: Alignment.center,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Select Industry",
//                         style: GoogleFonts.roboto(
//                           color: Colors.black,
//                           fontSize: w / 20,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//
//                         width: w / 1.1,
//                           child: SearchCard(
//                             onchange: (val) {
//                               context
//                                   .read<SellerAdminBloc>()
//                                   .add( CategoryListSellerEvent(val, "",''));
//                               setState(() {});
//                             },
//                           )),
//                       BlocBuilder<SellerAdminBloc, SellerAdminState>(
//                         builder: (context, state) {
//                           if (state is CategoryListSellerLoading) {
//                             return Container(
//                                 height: 200,
//                                 width: w,
//                                 alignment: Alignment.center,
//                                 child: LoadingAnimationWidget.threeRotatingDots(
//                                   color: Colors.red,
//                                   size: 30,
//                                 ));
//                           }
//                           if (state is CategoryListSellerSuccess) {
//                             nextUrl=state.nextPageUrl??"";
//                              prevUrl=state.prevPageUrl??"";
//                             return Container(
//                               padding: EdgeInsets.all(16),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ListView.separated(
//                                     primary: true,
//                                     shrinkWrap: true,
//                                     itemCount: state.category!.length,
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     itemBuilder: (context, index) =>
//                                         GestureDetector(
//                                       onTap: () {
//                                         onselect(index);
//                                         setState(() {});
//                                         categoryId = state
//                                             .category?[index]
//                                             .id ??
//                                             0;
//                                         categoryName = state
//                                             .category?[index]
//                                             .name ??
//                                             "";
//                                         Navigator.pop(context);
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   onselect(index);
//                                                   setState(() {});
//                                                   categoryId = state
//                                                       .category?[index]
//                                                       .id ??
//                                                       0;
//                                                   categoryName = state
//                                                       .category?[index]
//                                                       .name ??
//                                                       "";
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Container(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 8,
//                                                           bottom: 10,
//                                                           top: 5,
//                                                           right: 8),
//                                                   child: SvgPicture.string(
//                                                       state.category?[index].name ==
//                                                               offerPeriodNameNew
//                                                           // selectIndex == index
//                                                           ? HomeSvg()
//                                                               .radioButtonActive
//                                                           : HomeSvg()
//                                                               .radioInActive),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               Text(
//                                                 state.category?[index].name??"",
//                                                 style: GoogleFonts.roboto(
//                                                   color: Colors.black,
//                                                   fontSize: w / 22,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     separatorBuilder: (context, index) =>
//                                         Container(
//                                       color: ColorPalette.divider,
//                                       height: 1,
//                                       width: w,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 30,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 15,bottom: 25,right: 16,left: 16
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         prevUrl != ""
//                                             ? GestureDetector(
//                                           onTap: () {
//                                             context
//                                                 .read<SellerAdminBloc>()
//                                                 .add(
//                                                 CategoryListSellerEvent(
//                                                     '',
//                                                     '',
//                                                     prevUrl));
//                                             // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
//                                           },
//                                           child: Text(
//                                             "Previous",
//                                             style: TextStyle(
//                                                 fontWeight:
//                                                 FontWeight.w500,
//                                                 color: ColorPalette
//                                                     .primary,
//                                                 fontSize: w / 22),
//                                           ),
//                                         )
//                                             : Container(),
//                                         nextUrl != ""
//                                             ? GestureDetector(
//                                           onTap: () {
//                                             // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
//                                             setState(() {
//                                               context
//                                                   .read<SellerAdminBloc>()
//                                                   .add(
//                                                   CategoryListSellerEvent(
//                                                       '',
//                                                       nextUrl,
//                                                       ""));
//                                             });
//                                           },
//                                           child: Text(
//                                             "Next",
//                                             style: TextStyle(
//                                                 fontWeight:
//                                                 FontWeight.w500,
//                                                 color: ColorPalette
//                                                     .primary,
//                                                 fontSize: w / 22),
//                                           ),
//                                         )
//                                             : Text("")
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           }
//                           return Container();
//                         },
//                       )
//
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         });
//   }
// }
