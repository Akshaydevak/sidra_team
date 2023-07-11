// import 'package:cluster/presentation/inventory/attribute_pages/attribute_list_screen.dart';
// import 'package:cluster/presentation/inventory/division_list.dart';
// import 'package:cluster/presentation/inventory/segment-pages/segment_list_screen.dart';
// import 'package:cluster/presentation/inventory/static_group_pages/static_group_list_screen.dart';
// import 'package:cluster/presentation/inventory/uom_group_pages/uom_group_list_screen.dart';
// import 'package:cluster/presentation/inventory/uom_pages/uom_list_screen.dart';
// import 'package:cluster/presentation/inventory/variant_framework_pages/variant_framework_list_screen.dart';
// import 'package:cluster/presentation/inventory/warranty_pages/create_warranty_page.dart';
// import 'package:cluster/presentation/inventory/warranty_pages/products_list_for_warranty.dart';
// // import 'package:cluster/presentation/inventory/warrenty_screens/warrenty_product_list_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
// import '../product_hub/manage_data_card.dart';

// import '../product_hub/warranty/create_warranty.dart';
// import 'brand_pages/brand_list_screen.dart';
// import 'catagory_pages/catagory_list_screen.dart';
// import 'group_pages/group_list_screen.dart';
// import 'item_pages/item_list_screen.dart';
// import 'material_pages/material_list_screen.dart';


// class HierarchyScreen extends StatefulWidget {

//   const HierarchyScreen({Key? key}) : super(key: key);

//   @override
//   State<HierarchyScreen> createState() => _HierarchyScreenState();
// }

// class _HierarchyScreenState extends State<HierarchyScreen> {
//   List<String> quickData=[
//     'Division',
//     'Category',
//     'Group',
//     'Uom Group',
//     'Uom',
//     'Material',
//     'Static Group',
//     'Brand',
//     'Attribute',
//     'Item',
//     'Segment Allocation',
//     'Variant Framework',
//     'Warranty'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: BackAppBar(
//           label: "Hierarchy Screen",
//           isAction: false,
//           // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 child: ListView.separated(
//                     shrinkWrap: true,
//                     primary: false,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap:  onTapListTile(index, context),
//                         child: ManageDataCard(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   // SvgPicture.string(ProductSvg().warrantyIcon),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     quickData[index],
//                                     style: GoogleFonts.roboto(
//                                       color: Colors.black,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.black,
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) => Container(
//                       height: 10,
//                     ),
//                     itemCount: quickData.length),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   VoidCallback onTapListTile(int i, BuildContext context) {
//     // String email = Variables.emailfield;
//     VoidCallback onTap;
//     onTap = () {};
//     switch (i) {
//       case 0:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: DivisionListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;

//       case 1:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: CategoryListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//           //InsightScreen
//         };
//         break;
//       case 2:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: GroupListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;
//       case 3:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: UomGroupListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;

//       case 4:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: UomListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;
//       case 5:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: MaterialListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;
//       case 6:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: StaticGroupListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//           //Costing
//         };
//         break;

//       case 7:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: BrandListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );

//         };
//         break;

//       case 8:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: AttributeListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;

//       case 9:
//         onTap=(){
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: ItemListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;
//       case 10:
//         onTap =(){
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: SegmentListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;
//       case 11:
//         onTap = () {
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: VariantFrameworkListScreen(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );

//         };
//         break;
//       case 12:
//         onTap =(){
//           PersistentNavBarNavigator.pushNewScreen(
//             context,
//             screen: ProductListFOrWarranty(),
//             withNavBar: true,
//             // OPTIONAL VALUE. True by default.
//             pageTransitionAnimation: PageTransitionAnimation.fade,
//           );
//         };
//         break;
//     }
//     return onTap;
//   }
// }

