import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class PhoneWidget extends StatefulWidget {
  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  String _selectedCountryCode="+91";
  List<String> _countryCodes = ['+91', '+23'];

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        color: Colors.white,

      ),
      // height: 45.0,
      margin: const EdgeInsets.all(3.0),
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            icon: SvgPicture.string(HomeSvg().arrowDownIcon),
            items: _countryCodes.map((String value) {
              return  DropdownMenuItem<String>(
                  value: value,
                  child:  Text(
                    "$value ",
                    style:  const TextStyle(
                      color: ColorPalette.black,
                      fontSize: 18,
                    ),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCountryCode = value.toString();
              });
            },
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
    return Container(
      width: double.infinity,
      margin:  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),

      decoration: BoxDecoration(
        color: Colors.white,

      ),
      child:  TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
        },
        keyboardType: TextInputType.number,
        decoration:  InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            border:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                 BorderSide(color:  Color(0x190a0a0a), width: 1)),
            enabledBorder:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                 BorderSide(color:  Color(0x190a0a0a), width: 1)),
            focusedBorder:   OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                 BorderSide(color:  Color(0x7f0a0a0a), width: 1)),
            fillColor:const Color(0x7fffffff),
            prefixIcon: countryDropDown,
            hintText: 'Phone Number',

          labelStyle: TextStyle(
            color: ColorPalette.black,
            fontSize: 18,
          ), hintStyle: TextStyle(
            color: ColorPalette.inactiveGrey,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
