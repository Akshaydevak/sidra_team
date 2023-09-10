// import 'package:cluster/common_widgets/no_glow.dart';
// import 'package:cluster/core/color_palatte.dart';
// import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
// import 'package:cluster/presentation/seller_admin_app/operations/new_outlet.dart';
// import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
// import 'package:cluster/presentation/seller_app/seller_svg.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// import '../../../common_widgets/gradient_button.dart';
// import '../../../common_widgets/title_app_bar.dart';
//
// class Outlet extends StatefulWidget {
//   final String? legalCode;
//    Outlet({Key? key, this.legalCode}) : super(key: key);
//
//   @override
//   State<Outlet> createState() => _OutletState();
// }
//
// class _OutletState extends State<Outlet> {
//   int? selected;
//   void onSelect(int val) {
//     selected = val;
//     setState(() {});
//   }
// @override
//   void initState() {
//   context
//       .read<SellerAdminBloc>()
//       .add( CategoryListSellerEvent("", "",''));
//     super.initState();
//   }
//   int categoryId=0;
//   @override
//   Widget build(BuildContext context) {
//     var w=MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: ()async{
//         context.read<SellerAdminBloc>().add(
//             BusinessOutletListEvent(
//                 widget.legalCode, "", "", ""));
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(70),
//           child: TitleAppBar(label: "New Outlet"),
//         ),
//         body: ScrollConfiguration(
//           behavior: NoGlow(),
//           child: SingleChildScrollView(
//             child: Container(padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Select Category",
//                     style: GoogleFonts.roboto(
//                       color: Colors.black,
//                       fontSize: w/20,
//
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   Text(
//                     "Lorem ipsum dolor sit amet, conse ctetur adipis cing elit. Bibendum vestibulum, lorem in quam.",
//                     style: TextStyle(
//                       color: Color(0xff1b1b1f),
//                       fontSize: w/24,
//                     ),
//                     textAlign: TextAlign.justify,
//                   ),
//                   SizedBox(height: 10,),
//                   BlocBuilder<SellerAdminBloc, SellerAdminState>(
//   builder: (context, state) {
//       if(state is CategoryListSellerLoading){
//
//       }
//       if(state is CategoryListSellerSuccess) {
//         return Column(
//           children: [
//             GridView.builder(
//                 padding: const EdgeInsets.all(0),
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: state.category!.length,
//                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 150,
//                     childAspectRatio: 1.7 / 2,
//                     crossAxisSpacing: 5,
//                     mainAxisSpacing: 8),
//                 itemBuilder: (context, i) {
//                   return GestureDetector(
//                     onTap: () {
//                       onSelect(i);
//                       categoryId=state.category?[i].id??0;
//                       setState(() {
//
//                       });
//                     },
//                     // onTap: onTapListTile(i, context),
//                     child: Container(
//                       width: 121,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: selected==i?ColorPalette.primary:Color(0xffe6ecf0), width: 1,),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(0x05000000),
//                             blurRadius: 8,
//                             offset: Offset(1, 1),
//                           ),
//                         ],
//                         color: selected==i?ColorPalette.primary.withOpacity(0.05):Colors.white,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SvgPicture.string(SellerSvg().pharmacyIcon),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             state.category?[i].name??"",
//                             style: TextStyle(
//                               color: Color(0xff121113),
//                               fontSize: 15,
//                             ),
//                             textAlign: TextAlign.center,
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//             SizedBox(height: 60,),
//             selected==null?
//             GradientButton(
//                 color:Color(0xffD3D3D3),
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xffD3D3D3),
//                       Color(0xffD3D3D3)
//                     ]
//                 ),
//                 onPressed: () {  },
//                 child: Text(
//                   "Continue",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 )):GradientButton(
//                 color:Color(0xfffe5762),
//                 onPressed: () {
//                   PersistentNavBarNavigator.pushNewScreen(
//                     context,
//                     screen: NewOutlet(categoryId: categoryId,
//                         legalEntity: widget.legalCode),
//                     withNavBar: true,
//                     // OPTIONAL VALUE. True by default.
//                     pageTransitionAnimation:
//                     PageTransitionAnimation.fade,
//                   );
//                 },
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xfffe5762),
//                       Color(0xfffe5762)
//                     ]
//                 ),
//                 child: Text(
//                   "Continue",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.roboto(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 )),
//           ],
//         );
//       }
//       return Container();
//   },
// ),
//
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
