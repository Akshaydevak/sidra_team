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
  final TextEditingController? controller;
  VoidCallback? onTap;
  VoidCallback? onTap1;
  void Function(String)? onchange;

  SearchCard(
      {Key? key,
        this.isCollection = false,
        this.hint,
        this.onTap,
        this.onTap1,
        this.controller,
        this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,

      readOnly: false,
      controller: controller,
      onChanged: onchange,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 16),
          hintText: hint ?? "Search aproduct ...",
          hintStyle: TextStyle(
            color: Color(0xff666161),
            fontSize: 16,
          ),
          suffixIcon:
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.all(16),
                child:isCollection==false? SvgPicture.string(
                  CartSvg().searchIcon,
                  color: Colors.black,
                ):GestureDetector(
                    onTap: onTap1,
                    child:controller!.text.isNotEmpty? Icon(Icons.close,size: 20,):SizedBox())),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color(0xffE6ECF0))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color(0xffE6ECF0))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color(0xffE6ECF0))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color(0xffE6ECF0)))),
    );
  }
}
