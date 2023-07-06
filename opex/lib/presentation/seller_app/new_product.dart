import 'package:cluster/presentation/seller_app/product_hierarchy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common_widgets/checkbox_widget.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/title_app_bar.dart';
import 'add_new_list.dart';

class AddNewProduct extends StatefulWidget {
  AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  List<String> hierarchies = [
    'Choose Segment',
    'Choose Master Category',
    'Choose Sub Category',
    'Choose Product Group',
    'Select Material',
    'Select Brand'
  ];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: TitleAppBar(label: "Add new Product"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose product hierarchy",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia cons eq uat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: w / 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: hierarchies.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        _showModalBottomSheet();
                      },
                      child: ProductHierarchyCard(
                        label: hierarchies[index],
                      )),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GradientButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AddNewList(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    gradient: LinearGradient(
                      colors: [
                        Color(0xfffe5762),
                        Color(0xfffe5762),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: Color(0xfffe5762),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
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

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Expanded(
                child: Container(
                  // height: 350,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 30, left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose a category",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: w,
                          height: 1,
                          color: const Color(0xfff8f7f5),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => checkBox(
                                  label: "xchjkl",
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 5,
                                ),
                            itemCount: 5)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
