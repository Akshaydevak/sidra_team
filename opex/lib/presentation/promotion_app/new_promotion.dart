import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:cluster/presentation/promotion_app/promotion_sale.dart';
import 'package:cluster/presentation/promotion_app/promotion_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/no_glow.dart';
import '../../core/color_palatte.dart';
import '../dashboard_screen/home_screen/home_svg.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../order_app/order_svg.dart';
import 'coupons_form.dart';
import 'dropdown_card.dart';
import 'multibuy.dart';
import 'new_promotion2.dart';

class NewPromotion extends StatefulWidget {
  String type;
  final String? restorationId;
  NewPromotion({Key? key, this.type = "",this.restorationId}) : super(key: key);

  @override
  State<NewPromotion> createState() => _NewPromotionState();
}

class _NewPromotionState extends State<NewPromotion> with RestorationMixin {
  bool isAvailable = false;
  bool isPriority = false;
  bool isActive = false;
  List<String> dates = [
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50",
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50",
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50",
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50",
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50",
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50",
    "07 Apr 2023 15:30  -  14 Jun 2024 22:50"
  ];
  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }


//date
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.white, // <-- SEE HERE
              onPrimary: Colors.green, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: DatePickerDialog(

            restorationId: 'date_picker_dialog',
            initialEntryMode: DatePickerEntryMode.calendar,

            initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022),
          ),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(

      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
      print(_time);
    }
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: BackAppBar(label: "New Promotion"),
      ),
      body: ScrollConfiguration(
        behavior: NoGlow(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.string(PromotionSvg().progressDesign),
                SizedBox(
                  height: 30,
                ),
                DropDownCard(
                  onTap: () {
                    _showModalBottomSheet();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Promotion Title",
                  hint: "Eg. SEM",
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Description",
                  hint: "Eg. Lorem ipsum dolar sit amet.",
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Customer Group",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: isAvailable
                            ? const EdgeInsets.only(
                                left: 10, top: 10, bottom: 0, right: 10)
                            : const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Is Available for All",
                              style: GoogleFonts.roboto(
                                color: const Color(0xff151522),
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAvailable = !isAvailable;
                                });
                              },
                              child: isAvailable
                                  ? SvgPicture.string(HomeSvg().toggleActive)
                                  : SvgPicture.string(HomeSvg().toggleInActive),
                            )
                          ],
                        ),
                      ),
                      isAvailable
                          ? Column(
                              children: [
                                const Divider(
                                  indent: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 0, bottom: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Eg. Lorem ipsum dolar sit amet.",
                                        style: TextStyle(
                                          color: const Color(0x7f666161),
                                          fontSize: w / 24,
                                        ),
                                      ),
                                      const Icon(
                                          Icons.keyboard_arrow_down_outlined)
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Customer Group",
                  style: GoogleFonts.roboto(
                    color: ColorPalette.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    int? select;
                    void onSelect(index) {
                      setState(() {
                        select = index;
                      });
                    }

                    showDialog(
                        context: context,
                        builder: (BuildContext context)
                    {
                      return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    width: w,
                                    // height: 30,
                                    color: ColorPalette.primary,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Choose Date",
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: w / 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                            _showModalBottomSheetNew();
                                          },
                                          child: Container(
                                            width: 112,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                              color: Color(0xfffe5762),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Create New",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: w / 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.yellow,
                                    // padding: EdgeInsets.all(16),
                                    height: h / 2,
                                    child: ListView.separated(
                                      itemCount: dates.length,
                                      primary: true,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(16),
                                      physics: ScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () {
                                              setState((){
                                                select = index;
                                              });

                                              onSelect(index);
                                            },
                                            child: Container(
                                              width: w,
                                              padding:
                                              EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                color: select == index
                                                    ? Color(0xffF1F1F1)
                                                    : Colors.white,
                                              ),
                                              child: Text(dates[index],
                                                  style: TextStyle(
                                                    fontSize: w/28,
                                                    color: select == index
                                                        ?  ColorPalette.black:Color(0xff6A6A6A),
                                                  )),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) => SizedBox(),
                                    ),
                                  ),
                                  Container(
                                      width: w,
                                      height: 1,
                                      color: Color(0xffE6ECF0)),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap:(){
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: w / 3,
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Color(0xffc5c5c5),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: w / 22,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              width: w / 3,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: Color(0xfffe5762),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: w / 22,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 10,)
                                ],
                              ),
                            );
                          });
                    });
                  },
                  child: Container(
                    width: w,
                    padding: const EdgeInsets.all(14),
                    //height: 20.0,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xffe6ecf0),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 8,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Choose Date",
                          style: GoogleFonts.roboto(
                            color: const Color(0xfffe5762),
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Text(
                        //   "Due Date",
                        //   style: GoogleFonts.roboto(
                        //     color: const Color(0xfffe5762),
                        //     fontSize: w / 22,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DropDownCard(
                  label: "Offer Group",
                ),
                const SizedBox(
                  height: 16,
                ),
                DropDownCard(
                  label: "Offer Applying Type",
                ),
                const SizedBox(
                  height: 16,
                ),
                DropDownCard(
                  label: "Offer Applying To",
                ),
                const SizedBox(
                  height: 16,
                ),
                DropDownCard(
                  label: "Based on",
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormReusable(
                  label: "Discount Percentage / Price",
                  hint: "Eg. Lorem ipsum dollar sit amet.",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Upload Image",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: w / 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  padding: const EdgeInsets.all(8),
                  //height: 20.0,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 8,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: const Color(0xfffe5762),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Choose File",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: w / 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "No file chosen",
                        style: TextStyle(
                          color: Color(0xfffe5762),
                          fontSize: w / 24,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: w,
                  padding: const EdgeInsets.all(14),
                  //height: 20.0,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Override Priority",
                        style: GoogleFonts.roboto(
                          color: Color(0xff151522),
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPriority = !isPriority;
                          });
                        },
                        child: isPriority
                            ? SvgPicture.string(HomeSvg().toggleActive)
                            : SvgPicture.string(HomeSvg().toggleInActive),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: w,
                  padding: const EdgeInsets.all(14),
                  //height: 20.0,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xffe6ecf0),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 8,
                        offset: Offset(1, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is_Active",
                        style: GoogleFonts.roboto(
                          color: const Color(0xff151522),
                          fontSize: w / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                        child: isActive
                            ? SvgPicture.string(HomeSvg().toggleActive)
                            : SvgPicture.string(HomeSvg().toggleInActive),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GradientButton(
                    color: ColorPalette.primary,
                    onPressed: () {
                      //  widget.ismulti?
                      print(widget.type);
                      widget.type == "MultiBuy"
                          ? PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: MultiBuyForm(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            )
                          : widget.type=="Promotion Sale"?PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: PromotionSaleForm(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            ):widget.type=="Discount"?PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: CouponsForm(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            ):PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: NewPromotion2(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                    },
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ColorPalette.primary, ColorPalette.primary]),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: w / 22,
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
    int select = 0;
    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 450,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Segments",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              primary: true,
                              shrinkWrap: true,
                              itemCount: 5,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      onselect(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 8,
                                          bottom: 10,
                                          top: 5,
                                          right: 8),
                                      child: select == index
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  bottom: 10,
                                                  top: 5,
                                                  right: 8),
                                              child: SvgPicture.string(
                                                  OrderSvg()
                                                      .checkBoxActiveIcon),
                                            )
                                          : SvgPicture.string(
                                              OrderSvg().checkBoxIcon,
                                              height: 35,
                                              width: 35,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Market",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w / 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              separatorBuilder: (context, index) => Container(
                                color: ColorPalette.divider,
                                height: 1,
                                width: w,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  Navigator.pop(context);
                                  // PersistentNavBarNavigator.pushNewScreen(
                                  //   context,
                                  //   screen: const NewPromotion(),
                                  //   withNavBar: true, // OPTIONAL VALUE. True by default.
                                  //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                  // );  da
                                },
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorPalette.primary,
                                      ColorPalette.primary
                                    ]),
                                child: Text(
                                  "Select and Continue",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetNew() {
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
              return Container(
padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Create new time zone",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16,),
                    TextFormReusable(
                      label: "Name",
                      hint: "Enter name",
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(PromotionSvg().calenderIcon),
                            SizedBox(width: 10,),
                            Text(
                              "Start Date",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "12-Jun-2022",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            color: Color(0xff797979),
                            fontSize: w/22,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: ColorPalette.divider,
                      thickness: 1.1,
                    ),
                    GestureDetector(
                      onTap:
                        _selectTime,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.string(PromotionSvg().clockIcon),
                              SizedBox(width: 10,),
                              Text(
                                "Start Time",
                                style: GoogleFonts.roboto(
                                  color: Color(0xff151522),
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "9:10 AM",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.roboto(
                              color: Color(0xff797979),
                              fontSize: w/22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),Divider(
                      color: ColorPalette.divider,
                      thickness: 1.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(PromotionSvg().calenderIcon),
                            SizedBox(width: 10,),
                            Text(
                              "End Date",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "18-jun-2022",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            color: Color(0xff797979),
                            fontSize: w/22,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),Divider(
                      color: ColorPalette.divider,
                      thickness: 1.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.string(PromotionSvg().clockIcon),
                            SizedBox(width: 10,),
                            Text(
                              "End Time",
                              style: GoogleFonts.roboto(
                                color: Color(0xff151522),
                                fontSize: w/22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "10:10 PM",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            color: Color(0xff797979),
                            fontSize: w/22,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    GradientButton(
                        color:ColorPalette.primary ,
                        onPressed: () {

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SfDateRangePicker(
                                        onSelectionChanged: _onSelectionChanged,
                                        selectionColor: ColorPalette.primary,
                                        rangeSelectionColor: ColorPalette.primary.withOpacity(0.1),
                                        startRangeSelectionColor: ColorPalette.primary,
                                        endRangeSelectionColor: ColorPalette.primary,
                                        selectionMode: DateRangePickerSelectionMode.range,
                                        initialSelectedRange: PickerDateRange(
                                            DateTime.now().subtract(const Duration(days: 4)),
                                            DateTime.now().add(const Duration(days: 3))),
                                      ),
                                    ],
                                  ),
                                );
                              });

                        },
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ColorPalette.primary, ColorPalette.primary]),
                        child: Text(
                          "Create New",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        });
  }


}
