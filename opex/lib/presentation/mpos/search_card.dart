import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../dashboard_screen/cart_screen/cart_svg.dart';
import 'collection_point.dart';
import 'collection_view.dart';

class SearchCard extends StatelessWidget {
  bool isCollection;
  String? hint;
  VoidCallback ?onTap;
   SearchCard({Key? key,this.isCollection=false,this.hint,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
          // (){

       // isCollection? PersistentNavBarNavigator.pushNewScreen(
       //    context,
       //    screen: CollectionView(),
       //    withNavBar: true, // OPTIONAL VALUE. True by default.
       //    pageTransitionAnimation: PageTransitionAnimation.fade,
       //  ):print("");
      // },
readOnly: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 16),
          hintText:hint?? "Search aproduct ...",
          hintStyle: TextStyle(
            color: Color(0xff666161),
            fontSize: 16,
          ),

          suffixIcon: GestureDetector(
            onTap: (){},

            child: Container(
                padding: EdgeInsets.all(16),
                child:
                SvgPicture.string(CartSvg().searchIcon,color: Colors.black,)),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color(0xffE6ECF0)
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color(0xffE6ECF0)
              )
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color(0xffE6ECF0)
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Color(0xffE6ECF0)
              )
          )
      ),
    );
  }
}
