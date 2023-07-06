
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'create_svg.dart';

class OfficeScreen extends StatefulWidget {
  final String? restorationId;

  const OfficeScreen({Key? key,this.restorationId}) : super(key: key);

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> with RestorationMixin {
  bool isDate = false;
  bool isTime = false;


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
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
      print("searjjj${_range.split(" - ")[1]}");

    });
  }
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _time2 = TimeOfDay(hour: 8, minute: 15);

  TextEditingController jobtitle=TextEditingController();
  TextEditingController jobdiscription=TextEditingController();
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
    print("TYM${_time.hour}"":""${_time.minute}");
  }
  void _endTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime != null) {
      setState(() {
        _time2 = newTime;
      });
    }
    print("TYM${_time2.hour}"":""${_time2.minute}");
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: w,
          height: 185,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xffe6ecf0),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 8,
                offset: Offset(1, 1),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Job Title"),
                controller: jobtitle,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: w,
                height: 1.50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xb2e6e6e6),
                    width: 0.50,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: jobdiscription,
                decoration: InputDecoration(hintText: "Enter Discription"),),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: w,
          // height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xffe6ecf0),
              width: 1,
            ),
            boxShadow: [
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
              Container(
                margin:
                isTime? EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 16):EdgeInsets.all(16),
                child: SingleRow(
                    color: Color(0xfffc3a97),
                    label: "Date & Time",
                    svg: CreateSvg().clockIcon,
                    onTap: () {
                      setState(() {
                        isTime = !isTime;
                      });
                    },
                    endIcon: isTime
                        ? SvgPicture.string(HomeSvg().toggleActive)
                        : SvgPicture.string(HomeSvg().toggleInActive)),
              ),
              isTime?  Column(
                children: [
                  Divider(
                    indent: 50,
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            _restorableDatePickerRouteFuture.present();
                          },
                          child: const Text(
                            "Start Date :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){


                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 300,
                                      child: Scaffold(
                                        body: SfDateRangePicker(

                                          onSelectionChanged: _onSelectionChanged,
                                          selectionMode: DateRangePickerSelectionMode.range,
                                          initialSelectedRange: PickerDateRange(
                                              DateTime.now().subtract(const Duration(days: 4)),
                                              DateTime.now().add(const Duration(days: 3))),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                         _range.isNotEmpty? _range.split(" - ")[0]:"2022-11-10",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap:
                          _selectTime,

                          child: Text(
                            "${_time.hour}"":""${_time.minute} ${_time.period.name}"??"",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 50,
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "End Date :",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          _range.isNotEmpty?_range.split(" - ")[1]:"2022-12-10",
                          style: GoogleFonts.roboto(
                            color: Color(0xfffe5762),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        GestureDetector(
                          onTap:_endTime,

                          child: Text(
                            "${_time2.hour}"":""${_time2.minute} ${_time2.period.name}"??"",
                            style: GoogleFonts.roboto(
                              color: Color(0xfffe5762),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ):Container(),

            ],
          ),
        ),


        SizedBox(
          height: 16,
        ),


      ],
    );
  }
}