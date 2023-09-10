// import 'package:cluster/presentation/seller_admin_app/operations/users_list.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// import '../../../core/color_palatte.dart';
// import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
// import 'create_user_seller.dart';
// import 'dir_user_list.dart';
//
// class UserListTabBar extends StatefulWidget {
//   final String? entityCode;
//   const UserListTabBar({super.key, this.entityCode});
//
//   @override
//   State<UserListTabBar> createState() => _UserListTabBarState();
// }
//
// class _UserListTabBarState extends State<UserListTabBar> {
//   @override
//   Widget build(BuildContext context) {
//     double w1 = MediaQuery.of(context).size.width ;
//     double w = w1> 700
//         ? 400
//         : w1;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: BackAppBar(
//           label: "User List",
//           isAction: false,
//           action: GestureDetector(
//             onTap: () {
//               // PersistentNavBarNavigator.pushNewScreen(
//               //   context,
//               //   screen: CreateUser(entityCode: widget.entityCode),
//               //   withNavBar: true,
//               //   // OPTIONAL VALUE. True by default.
//               //   pageTransitionAnimation: PageTransitionAnimation.fade,
//               // );
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(top: 15),
//               child: Text(
//                 "Create",
//                 style: GoogleFonts.poppins(
//                     color: ColorPalette.primary,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       body: DefaultTabController(
//         length: 2,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 alignment: Alignment.center,
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(top: 10),
//                 child: SizedBox(
//                   width: w1 / 1,
//                   child:  TabBar(
//                       labelColor: Colors.black,
//                       indicatorColor: ColorPalette.primary,
//                       unselectedLabelColor: Colors.black,
//                       labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w500,color: Colors.black,fontSize: w/24),
//                       unselectedLabelStyle:GoogleFonts.roboto(fontWeight: FontWeight.normal,color: Colors.black,fontSize: w/24) ,
//                       tabs: const [
//                         Tab(text: "Employee User"),
//                         Tab(text: "Director User"),
//                       ]),
//                 )),
//             Expanded(
//               child: Container(
//                 color: Colors.white,
//                 child:
//                  TabBarView(
//                     children: [
//                       // MyTasks(),
//                       // UserListInSellerAdmin(entityCode: widget.entityCode??""),
//                       DirectorUserList(entityCode: widget.entityCode??"")
//                     ]),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
