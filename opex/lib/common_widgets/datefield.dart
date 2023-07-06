import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DateInputField extends StatefulWidget {
  final Function(String)? onChangeDate;
  final Function(String)? onChangeMonth;
  final Function(String)? onChangeYear;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputFormatter? formatter;
  final String? dateTitle;
  final String? monthTitle;
  final String? yearTitle;
  final TextEditingController? dateController;
  final TextEditingController? monthController;
  final TextEditingController? yearController;
  const DateInputField(
      {super.key,
        this.keyboardType,
        this.formatter,
        this.onEditingComplete,
        this.onFieldSubmitted,
        this.dateController,
        this.monthController,
        this.yearController,
        this.onChangeDate,
        this.onChangeMonth,
        this.onChangeYear, this.dateTitle, this.monthTitle, this.yearTitle});

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  @override
  Widget build(BuildContext context) {
    // var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
      width: w / 3,
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              style:GoogleFonts.readexPro(
                  height: 1.5,
                  color: Color(0xfffd5762),
                  fontWeight: FontWeight.w300,
                  fontSize: w / 26) ,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              onFieldSubmitted: widget.onFieldSubmitted,
              onEditingComplete: widget.onEditingComplete,
              onChanged: widget.onChangeDate,
              keyboardType: widget.keyboardType,
              // TextInputType.number,
              // inputFormatters: widget.formatter??    [T]
              //             <TextInputFormatter>[
              //     FilteringTextInputFormatter.digitsOnly
              // ],
              controller: widget.dateController,
              // cursorColor: Palette.PRIMARY,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hintText: widget.dateTitle,
                hintStyle: GoogleFonts.readexPro(
                    height: 1.5,
                    color: Color(0xfffd5762),
                    fontWeight: FontWeight.w300,
                    fontSize: w / 26),
                border: InputBorder.none,

              ),
            ),
          ),
          Text("/",style: TextStyle(
            color: Color(0xfffd5762),

          ),),
          Expanded(
            flex: 1,
            child: TextFormField(
              style:GoogleFonts.readexPro(
                  height: 1.5,
                  color: Color(0xfffd5762),
                  fontWeight: FontWeight.w300,
                  fontSize: w / 26) ,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              onFieldSubmitted: widget.onFieldSubmitted,
              onEditingComplete: widget.onEditingComplete,
              onChanged: widget.onChangeMonth,
              keyboardType: widget.keyboardType,
              // TextInputType.number,
              // inputFormatters: widget.formatter??    [T]
              //             <TextInputFormatter>[
              //     FilteringTextInputFormatter.digitsOnly
              // ],
              controller: widget.monthController,
              // cursorColor: Palette.PRIMARY,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hintText: widget.monthTitle,
                hintStyle: GoogleFonts.readexPro(
                    height: 1.5,
                    color: Color(0xfffd5762),
                    fontWeight: FontWeight.w300,
                    fontSize: w / 26),
                border: InputBorder.none,
              ),
            ),
          ),
          Text("/",style: TextStyle(
            color: Color(0xfffd5762),
          ),),
          Expanded(
            flex: 2,
            child: TextFormField(
              style:GoogleFonts.readexPro(
                  height: 1.5,
                  color: Color(0xfffd5762),
                  fontWeight: FontWeight.w300,
                  fontSize: w / 26) ,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              onFieldSubmitted: widget.onFieldSubmitted,
              onEditingComplete: widget.onEditingComplete,
              onChanged: widget.onChangeYear,
              keyboardType: widget.keyboardType,
              // TextInputType.number,
              // inputFormatters: widget.formatter??    [T]
              //             <TextInputFormatter>[
              //     FilteringTextInputFormatter.digitsOnly
              // ],
              controller: widget.yearController,
              // cursorColor: Palette.PRIMARY,
              decoration: InputDecoration(
                focusColor: Colors.white,
                hintText: widget.yearTitle,
                hintStyle: GoogleFonts.readexPro(
                    height: 1.5,
                    color: Color(0xfffd5762),
                    fontWeight: FontWeight.w300,
                    fontSize: w / 26),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
