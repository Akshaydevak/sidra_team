import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../../../common_widgets/cluster_card.dart';
import '../../../common_widgets/datefield.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';

import '../../task_operation/create/create_svg.dart';
import '../contract_svg.dart';

class FirstScreen extends StatefulWidget {
  final String? restorationId;
  const FirstScreen({Key? key,this.restorationId}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with RestorationMixin {
  String? finalDate;

  final TextEditingController dateController = TextEditingController();

  final TextEditingController monthController = TextEditingController();

  final TextEditingController yearController = TextEditingController();
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
            colorScheme: ColorScheme.light(
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

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
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

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.string(ContractSvg().contractOneIcon),
          SizedBox(
            height: 10,
          ),
          TextFormReusable(
            label: "Contract Tite",
            hint: "eg.rawabi market",
          ),
          SizedBox(
            height: 10,
          ),
          TextFormReusable(
            label: "Description",
            hint: "eg.lorem ipsum dolar sit",
          ),
          SizedBox(
            height: 10,
          ),
          TextFormReusable(
            label: "Requester Department (Optional) ",
            hint: "eg.HR Management",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Contract Party",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ClusterCard(
              child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorPalette.inactiveGrey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Afthabu Rahman P P",
                    style: TextStyle(
                      color: Color(0xff151522),
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Divider(
                indent: 50,
              ),
              GestureDetector(
                onTap: () {
                  _showModalBottomSheet();
                },
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorPalette.primary,
                        child: Text(
                          "+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add New Party",
                      style: GoogleFonts.roboto(
                        color: Color(0xfffe5762),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),

          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contract Effective On",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
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
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 40,
                        width: w/2.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0x190a0a0a), width: 1, ),
                          color: Color(0x7fffffff),
                        ),
                        alignment: Alignment.centerLeft,
                       child:  Text(
                         "--/--/----",
                         style: GoogleFonts.roboto(
                           color: ColorPalette.subtextGrey,
                           fontSize: w/18,
                           fontWeight: FontWeight.w300,
                         ),
                       ),
                    ),
                  ),
                ],
              ), Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contract End On",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w/24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 40,
                    width: w/2.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0x190a0a0a), width: 1, ),
                      color: Color(0x7fffffff),
                    ),
                    alignment: Alignment.centerLeft,
                    child:  Text(
                      "--/--/----",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.subtextGrey,
                        fontSize: w/18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Text(
            "Profile related info placed here.  Whishlist is used to save your favourite items for later.",
            style: TextStyle(
              color: Color(0xff3c3b3b),
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ]);
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
              return Container(
                height: h/1.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child:
                ScrollConfiguration(
                  behavior: NoGlow(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Contract Party",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Divider(
                          color: ColorPalette.divider,
                          thickness: 1.1,
                        ),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(16),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Row(
                              children: [
                                CircleAvatar(),
                                SizedBox(width: 10,),
                                Text(
                                  "Afthimal1254@gmail.com",
                                  style: TextStyle(
                                    color: ColorPalette.black,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            separatorBuilder: (context, index) => Divider(
                              indent: 50,
                              color: ColorPalette.divider,
                            ),
                            itemCount: 5),
                        Divider(
                          color: ColorPalette.divider,
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Row(
                                    children: [

                                      Container(
                                        width: 32,
                                        height: 32,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xff1ec9bf),
                                        ),

                                        child: SvgPicture.string(CreateSvg().calenderIcon),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Invite from device contacts",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Divider(indent: 30,),
                                GestureDetector(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          var w=MediaQuery.of(context).size.width;
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                        },
                                                        child: Icon(Icons.close))],
                                                ),
                                                // SizedBox(height: 5,),
                                                TextFormReusable(
                                                  label: "Enter Email",
                                                  hint: "Enter email Address",
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),

                                                GradientButton(
                                                    color:Color(0xfffe5762) ,
                                                    onPressed: () {
                                                      // PersistentNavBarNavigator.pushNewScreen(
                                                      //   context,
                                                      //   screen: const NewContract(),
                                                      //   withNavBar: false, // OPTIONAL VALUE. True by default.
                                                      //   pageTransitionAnimation: PageTransitionAnimation.fade,
                                                      // );

                                                    },
                                                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:const [ Color(0xfffe5762),  Color(0xfffe5762)]),
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
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [

                                      Container(
                                        width: 32,
                                        height: 32,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xfffc3a97),
                                        ),

                                        child: SvgPicture.string(CreateSvg().clockIcon),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Enter Email Address",
                                        style: GoogleFonts.roboto(
                                          color: ColorPalette.primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )

                        )
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
