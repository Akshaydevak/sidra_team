// import 'dart:io';
// import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../core/common_snackBar.dart';
// import '../base/icon_constants.dart';
// import '../dashboard_screen/profile/profile_bloc/profile_bloc.dart';
//
// class ProfilePic extends StatefulWidget {
//   final String? image;
//   final int? idSeller;
//
//   const ProfilePic({Key? key, this.image, this.idSeller}) : super(key: key);
//
//   @override
//   _ProfilePicState createState() => _ProfilePicState();
// }
//
// class _ProfilePicState extends State<ProfilePic> {
//   File? cropImage;
//   final picker = ImagePicker();
//   bool _cropped = false;
//   String? avatar =
//       'https://www.bing.com/images/search?view=detailV2&ccid=IhLi5SNo&id=BEEDA4DA01CF756BAD8ABFA5407A37F8F5FCA08C&thid=OIP.IhLi5SNoTJG7at5pDZ4_wAHaHa&mediaurl=https%3a%2f%2fvectorified.com%2fimages%2ffacebook-no-profile-picture-icon-26.jpg&exph=600&expw=600&q=Facebook+Profile+Icon&simid=607990988042866562&FORM=IRPRST&ck=50494423ADCE2245A10AF52DAF3DF57E&selectedIndex=3';
//   // String? iMG;
//   @override
//   Widget build(BuildContext context) {
//     // String str = widget.image ?? "";
//     // String result =
//     // str.replaceAll("/static/", "https://api-uat-user.sidrabazar.com/media/");
//
//     return BlocListener<SellerAdminBloc, SellerAdminState>(
//       listener: (context, state) {
//         if (state is UpdatePictureLoading) {
//           showSnackBar(context, message: "success", color: Colors.green);
//           print("check new picture upload loading");
//         }
//         if (state is UpdatePictureSuccess) {
//           // BlocProvider.of<ProfileBloc>(context).add(FetchProfilePictureEvent());
//
//           // Navigator.pop(context);
//
//           showSnackBar(context, message: "Profile Updated successfully", color:Colors.green);
//           // Navigator.pop(context);
//         }
//         if (state is UpdatePictureFailed) {
//           print("check new Picture upload failed");
//         }
//       },
//       child: Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),),
//           width: 68,
//           height: 68,
//           child: GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//
//                   builder: (context) {
//                     Future.delayed(const Duration(seconds: 3), () {
//                       Navigator.of(context).pop(true);
//                     });
//                     return AlertDialog(
//                       content: Row(
//                         children: [
//                           Expanded(
//                             child: IconButton(
//                               iconSize: 50,
//                               icon: const Icon(
//                                 Icons.perm_media,
//                               ),
//                               onPressed: () {
//
//                                 getImage(ImageSource.gallery);
//                               },
//                               tooltip: "Gallery",
//                             ),
//                           ),
//                           Expanded(
//                             child: IconButton(
//                               iconSize: 50,
//                               icon: const Icon(Icons.camera_alt),
//                               onPressed: () {
//                                 getImage(ImageSource.camera);
//                               },
//                               tooltip: "use camera",
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                   child: _cropped
//                       ? Container(
//                     width: 68,
//                     height: 68,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(17),
//                         image: DecorationImage(
//                             image: FileImage(cropImage!),
//                             fit: BoxFit.cover)),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//
//                                   builder: (context) {
//                                     Future.delayed(const Duration(seconds: 3), () {
//                                       Navigator.of(context).pop(true);
//                                     });
//                                     return AlertDialog(
//                                       content: Row(
//                                         children: [
//                                           Expanded(
//                                             child: IconButton(
//                                               iconSize: 50,
//                                               icon: const Icon(
//                                                 Icons.perm_media,
//                                               ),
//                                               onPressed: () {
//
//                                                 getImage(ImageSource.gallery);
//                                               },
//                                               tooltip: "Gallery",
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: IconButton(
//                                               iconSize: 50,
//                                               icon: const Icon(Icons.camera_alt),
//                                               onPressed: () {
//                                                 getImage(ImageSource.camera);
//                                               },
//                                               tooltip: "use camera",
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               child:Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                     BorderRadius.circular(5),
//                                     color: Colors.white,
//                                   ),
//                                   child: SvgPicture.string(
//                                       IconConstants().penIcon)),
//                             ))
//                       ],
//                     ),
//                   )
//                       : SizedBox(
//                     width: 68,
//                     height: 68,
//
//                     child: Stack(
//                       children: [
//                         Container(
//                           width: 68,
//                           height: 68,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(17),
//                               image: DecorationImage(
//                                   image: NetworkImage(widget.image??""),
//                                   fit: BoxFit.cover)),
//                         ),
//                         Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//
//                                   builder: (context) {
//                                     Future.delayed(const Duration(seconds: 3), () {
//                                       Navigator.of(context).pop(true);
//                                     });
//                                     return AlertDialog(
//                                       content: Row(
//                                         children: [
//                                           Expanded(
//                                             child: IconButton(
//                                               iconSize: 50,
//                                               icon: const Icon(
//                                                 Icons.perm_media,
//                                               ),
//                                               onPressed: () {
//
//                                                 getImage(ImageSource.gallery);
//                                               },
//                                               tooltip: "Gallery",
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: IconButton(
//                                               iconSize: 50,
//                                               icon: const Icon(Icons.camera_alt),
//                                               onPressed: () {
//                                                 getImage(ImageSource.camera);
//                                               },
//                                               tooltip: "use camera",
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                   padding: EdgeInsets.all(5),
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                     BorderRadius.circular(5),
//                                     color: Colors.white,
//                                   ),
//                                   child: SvgPicture.string(
//                                       IconConstants().penIcon)),
//                             ))
//                       ],
//                     ),
//                   )))
//       ),
//     );
//   }
//   Future<void> getImage(source) async {
//     try {
//       final pickedFile =
//       await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);
//
//       cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;
//
//       if (cropImage != null) {
//         BlocProvider.of<SellerAdminBloc>(context)
//             .add(UpdateSellerPictureEvent(cropImage!,widget.idSeller));
//         // Navigator.pop(context);
//       }
//       setState(() {
//         _cropped = true;
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
