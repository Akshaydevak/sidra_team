import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/create/single_row.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/home/model/joblist_model.dart';
import 'package:cluster/presentation/task_operation/job_title.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../common_widgets/loading.dart';
import '../../../../core/common_snackBar.dart';
import '../../../../core/utils/variables.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../lottieLoader.dart';
import 'create_svg.dart';


class CreateJob extends StatefulWidget {
  final bool edit;
  const CreateJob({Key? key,  this.edit=false}) : super(key: key);

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  bool isSelect=false;
  bool isOffice=true;
  bool isHome=false;
  bool isInstant=false;
  int select=0;
  bool isDate = false;
  bool isTime = false;
  GetJobList? createJob;

  int? selectInstat;
  void onSelect(int val) {
    selectInstat = val;
    setState(() {});
  }
  GetJobList? JobRead;

  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _range2 = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
        _range2 = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
      startDate=_range.split(" - ")[0];
      startDate2=_range2.split(" - ")[0];
      ebdDate=_range.split(" - ")[1];
      ebdDate2=_range2.split(" - ")[1];

      validationCheck();
    });
  }
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _time2 = const TimeOfDay(hour: 8, minute: 15);

  TextEditingController jobtitle=TextEditingController();
  TextEditingController jobdiscription=TextEditingController();
  int? relatedJobId;
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        startTime="${newTime.hour}"":""${newTime.minute}"":""00 ";
      });
    }
    final timeOfDay = TimeOfDay(hour: newTime?.hour??3, minute: newTime?.minute??30);

    final twentyFourHourFormat = DateFormat('HH:mm:00');
    final twelveHourFormat = DateFormat('h:mm a');

    final dateTime = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
     startTime = twelveHourFormat.format(dateTime);
     startTime2 = twentyFourHourFormat.format(dateTime);
    validationCheck();
    print(startTime);
  }
  void _endTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime != null) {
      setState(() {
        _time2 = newTime;
        endTime="${newTime.hour}"":""${newTime.minute}"":""00 ";
      });
    }
    print("TYM${_time2.hour}"":""${_time2.minute}");
    final timeOfDay = TimeOfDay(hour: newTime?.hour??3, minute: newTime?.minute??30); // Example time of day (3:30 PM)

    final twentyFourHourFormat = DateFormat('HH:mm:00');
    final twelveHourFormat = DateFormat('h:mm a');

    final dateTime = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
    endTime = twelveHourFormat.format(dateTime);
    endTime2 = twentyFourHourFormat.format(dateTime);

    print(endTime);
    validationCheck();
  }

  void onselct(index){
    setState(() {
      select=index;
      print("seler$select");
    });
  }

  int? jobtype;
  String startDate="";
  String startDate2="";
  String ebdDate="";
  String ebdDate2="";
  String startTime="Start Time";
  String startTime2="00:00";
  String endTime="End Time";
  String endTime2="00:00";
  List<GetJobList>? joblist=[];
  String PriorityLeval="Low";

  void refreah(){
    setState(() {

    });
  }
  @override
  void initState() {
    context.read<JobBloc>().add(const GetJobTypeListEvent());
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }
  FocusNode focusNode=FocusNode();
  FocusNode descriptionfocusNode=FocusNode();
  bool? isValid=false;
  validationCheck(){
    if(jobtitle.text!=""&&jobdiscription.text!=""&&_range!=""&&startTime!="Select Time"&&endTime!="Select Time"){
      isValid=true;
    }
    else{
      isValid=false;
    }
  }
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: widget.edit==true? "Edit Job" : "Create New Job",
            isAction: false,action: Container(), ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<JobBloc, JobState>(
              listener: (context, state) {
                print('StateCreate$state');
                if (state is CreateJobLoading) {
                  // showSnackBar(context,
                  //     message: "Loading...",
                  //     color: Colors.white,
                  //     autoDismiss: true);
                }
                if (state is CreateJobFailed) {
                  showSnackBar(
                    context,
                    message: state.error,
                    color: Colors.red,
                  );
                }
                if (state is CreateJobSuccess) {
                  print("JOBID${state.jobId}");
                  Fluttertoast.showToast(
                      msg: 'Successfully Created',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white);
                  Navigator.pop(context);

                  context.read<JobBloc>().add(
                      GetJobReadListEvent(int.tryParse(state.jobId)??0));
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: JobTitle(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );

                }
              },
            ),
            BlocListener<JobBloc, JobState>(
              listener: (context, state) {
                if (state is UpdateJobLoading) {
                  // showSnackBar(context,
                  //     message: "Loading...",
                  //     color: Colors.white,
                  //     // icon: HomeSvg().SnackbarIcon,
                  //     autoDismiss: true);
                }

                if (state is UpdateJobFailed) {
                  showSnackBar(
                    context,
                    message: state.error,
                    color: Colors.red,
                    // icon: Icons.admin_panel_settings_outlined
                  );
                }
                if (state is UpdateJobSuccess) {

                  Fluttertoast.showToast(
                      msg: 'Job Updated Successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white);
                  Navigator.pop(context);

                  // context.read<JobBloc>().add(
                  //     GetJobReadListEvent(int.tryParse(Variable.jobReadId.toString())??0));
                  // PersistentNavBarNavigator.pushNewScreen(
                  //   context,
                  //   screen: JobTitle(),
                  //   withNavBar: true, // OPTIONAL VALUE. True by default.
                  //   pageTransitionAnimation: PageTransitionAnimation.fade,
                  // );
                }
              },
            ),
            BlocListener<JobBloc, JobState>(
              listener: (context, state) {
                if(state is GetJobReadLoading){

                }
                if(state is GetJobReadSuccess){
                  JobRead=state.getjobRead;

                  jobtitle.text=JobRead?.name??"";
                  jobdiscription.text=JobRead?.description??"";
                  select=JobRead?.jobType??0;
                  JobRead?.jobType==1?select=0:JobRead?.jobType==2?select=1:JobRead?.jobType==3?select=2:0;
                  print("Read${JobRead?.startDate}");
                  print("Read${JobRead?.endDate}");
                  startDate=JobRead?.startDate?.split("T")[0]??"";
                  ebdDate=JobRead?.endDate?.split("T")[0]??"";
                  startTime=JobRead?.startDate?.split("T")[1].split("+")[0]??"";
                  endTime=JobRead?.endDate?.split("T")[1].split("+")[0]??"";
                  final timeOfDay = TimeOfDay(hour: int.tryParse(startTime.split(":")[0])??0, minute: int.tryParse(startTime.split(":")[1])??0); // Example time of day (3:30 PM)
                  final timeOfDayEnd = TimeOfDay(hour: int.tryParse(endTime.split(":")[0])??0, minute: int.tryParse(endTime.split(":")[1])??0); // Example time of day (3:30 PM)

                  final twentyFourHourFormat = DateFormat('HH:mm:00');
                  final twelveHourFormat = DateFormat('h:mm a');

                  final dateTimet = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
                  final dateTimett = DateTime(1, 1, 1, timeOfDayEnd.hour, timeOfDayEnd.minute);
                  startTime = twelveHourFormat.format(dateTimet);
                  startTime2 = twentyFourHourFormat.format(dateTimet);
                  endTime=twelveHourFormat.format(dateTimett);
                  endTime2=twentyFourHourFormat.format(dateTimett);
                  jobtype=JobRead?.jobType??0;
                  PriorityLeval=JobRead?.priority??"";
                  var date = ebdDate;
                  var date2 = startDate;
                  var dateTime =  DateTime.parse("$date");
                  var dateTime2 =  DateTime.parse("$date2");
                  ebdDate2 =  DateFormat('dd-MM-yyyy').format(dateTime).toString();
                  startDate2 =  DateFormat('dd-MM-yyyy').format(dateTime2).toString();
                  _range2 = '${DateFormat('dd-MM-yyyy').format(DateTime.parse("$date"))} -'
                      ' ${DateFormat('dd-MM-yyyy').format(DateTime.parse("$date2"))}';
                  _range = '${DateFormat('yyyy-MM-dd').format(DateTime.parse("$date"))} -'
                      ' ${DateFormat('yyyy-MM-dd').format(DateTime.parse("$date2"))}';
                  print("JOB COME${startTime}");
                  print("JOB COME${startDate2}");
                  print("JOB COME${ebdDate2}");
                  print("JOB COME${endTime}");
                  setState(() {

                  });
                }
              },
            ),
            BlocListener<JobBloc, JobState>(
              listener: (context, state) {
                if(state is GetInstantJobListLoading){

                }
                if(state is GetInstantJobListSuccess){
                  joblist=state.jobList;
                  setState(() {

                  });
                }
              },
            ),
          ],
          child: ScrollConfiguration(
            behavior: NoGlow(),
            child: SingleChildScrollView(
              child: Container(

                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(_isLoading)...[
                      LottieLoader()
                    ]
                    else...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.edit==true?Container():Text(
                          "Choose Job Tag",
                          style: GoogleFonts.roboto(
                            color: ColorPalette.black,
                            fontSize: w/24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        widget.edit==true?Container():SizedBox(height: 10,),
                        widget.edit==true?Container():BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            print("DASS${state}");
                            if (state is GetJobTypeListLoading) {
                              return customCupertinoLoading();
                            }
                            if (state is GetJobTypeListSuccess) {

                              return SizedBox(
                                  width: w,
                                  height: 36,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(right: 0, left: 0),
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.jobTypeList.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return GestureDetector(
                                          onTap: () {
                                            onselct(i);
                                            jobtype=state.jobTypeList[i].id;
                                            select==2?context.read<JobBloc>().add(GetInstantJobListEvent()):null;
                                            context.read<JobBloc>().add(GetJobTypeListEvent());
                                          },
                                          child: Container(
                                            width: w/3.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              // border:
                                              // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x05000000),
                                                  blurRadius: 8,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                              color: select==i?Colors.black:Color(0xffF4F4F4),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              state.jobTypeList[i].typeName.toString().toTitleCase()??"",
                                              style: select == i
                                                  ? GoogleFonts.roboto(
                                                color: select==i?Colors.white:ColorPalette.black,
                                                fontSize: w/23,
                                                fontWeight:
                                                FontWeight.w500,
                                              )
                                                  : GoogleFonts.roboto(
                                                color: ColorPalette.black,
                                                fontSize: w/23,
                                              ),
                                            ),
                                          ));
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(
                                        width: 5,
                                      );
                                    },
                                  ));
                            }
                            return SizedBox();
                          },
                        ),

                        SizedBox(height: h/80,),
                        select==0||select==1?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w,
                              // height: 185,
                              // padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    style:GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600
                                    ) ,
                                    onChanged: (n){
                                      validationCheck();
                                      setState(() {

                                      });
                                    },
                                    focusNode: focusNode,
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left:16,right: 16 ),
                                      hintText: "Job Title",
                                      hintStyle: TextStyle(
                                        color: Color(0x66151522),
                                        fontSize: w/26,
                                      ),
                                      border: InputBorder.none,

                                    ),
                                    controller: jobtitle,

                                    maxLines: 1,
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left:16),
                                    width: w,
                                    height: 1.50,
                                    color: ColorPalette.divider,
                                  ),

                                  TextFormField(
                                    style:GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600
                                    ),
                                    controller: jobdiscription,
                                    maxLines: 4,
                                    minLines: 1,
                                    onChanged: (n){
                                      validationCheck();
                                      setState(() {

                                      });
                                    },
                                    focusNode: descriptionfocusNode,
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 16,top: 10,right: 16,bottom: 16),
                                      hintText: "Enter Description",
                                      hintStyle: TextStyle(
                                        color: Color(0x66151522),
                                        fontSize: w/26,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
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
                                borderRadius: BorderRadius.circular(4),
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
                                    margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 10,
                                        top: 10),
                                    child: SingleRow(
                                        color: Color(0xfffc3a97),
                                        label: "Date & Time",
                                        svg: CreateSvg().clockIcon,
                                        onTap: () {
                                          setState(() {
                                            // isTime = !isTime;
                                          });
                                        },
                                        endIcon: GestureDetector(

                                          onTap: () {
                                            focusNode.unfocus();
                                            descriptionfocusNode.unfocus();
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                      MainAxisSize
                                                          .min,
                                                      children: [
                                                        Container(
                                                          height: 300,
                                                          child:
                                                          Scaffold(
                                                            body:
                                                            SfDateRangePicker(
                                                              backgroundColor:
                                                              Colors.white,
                                                              endRangeSelectionColor:
                                                              ColorPalette.primary,
                                                              startRangeSelectionColor:
                                                              ColorPalette.primary,
                                                              rangeSelectionColor:
                                                              ColorPalette.primary
                                                                  .withOpacity(0.1),
                                                              selectionColor:
                                                              Colors.grey,
                                                              todayHighlightColor:
                                                              ColorPalette.primary,
                                                              onSelectionChanged:
                                                              _onSelectionChanged,
                                                              selectionMode:
                                                              DateRangePickerSelectionMode
                                                                  .range,
                                                              initialSelectedRange: widget.edit?PickerDateRange(
                                                                  DateTime.parse(startDate),
                                                                  DateTime.parse(ebdDate)):
                                                              startDate!=""?PickerDateRange(
                                                                  DateTime.parse(startDate),
                                                                  DateTime.parse(ebdDate)):
                                                              PickerDateRange(
                                                                  DateTime.now(),
                                                                  DateTime.now()),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if(_range.isEmpty)
                                                            setState(() {
                                                              // if (DateTime.now() is PickerDateRange) {
                                                                _range = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
                                                                _range2 = '${DateFormat('dd-MM-yyyy').format(DateTime.now())}';
                                                                print("range is here$_range");

                                                              startDate=_range;
                                                              startDate2=_range2;
                                                              ebdDate=_range;
                                                              ebdDate2=_range2;

                                                              // validationCheck();
                                                            });

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                          Container(
                                                            height: 25,
                                                            width: 75,
                                                            color: ColorPalette
                                                                .primary,
                                                            child: Center(
                                                                child: Text(
                                                                    "Ok",
                                                                style: GoogleFonts.roboto(
                                                                  color: Colors.white
                                                                ),)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },

                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child:  Text("Choose Date",
                                              style: GoogleFonts.roboto(
                                                fontSize: w/24,
                                                color: ColorPalette.primary,
                                                 fontWeight: FontWeight.w500
                                              ),)),
                                        )),
                                  ),
                                  Column(
                                    children: [
                                      Divider(
                                        indent: 10,
                                        height: 2,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 10,
                                            top: 10),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "From :",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                  ),
                                                ),
                                                SizedBox(width: w/40,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    // border:
                                                    // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x05000000),
                                                        blurRadius: 8,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    color: Color(0xffF4F4F4),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    _range2.isNotEmpty? startDate2:"           ",
                                                    style: GoogleFonts.roboto(
                                                      color: ColorPalette.black,
                                                      fontSize: w/24,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                           Row(
                                             children: [
                                               Text(
                                                 "To :",
                                                 style: TextStyle(
                                                   color: Colors.black,
                                                   fontSize: w/24,
                                                 ),
                                               ),
                                               SizedBox(width: w/40,),
                                               Container(
                                                 padding: EdgeInsets.all(5),
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(4),
                                                   // border:
                                                   // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                                   boxShadow: [
                                                     BoxShadow(
                                                       color: Color(0x05000000),
                                                       blurRadius: 8,
                                                       offset: Offset(1, 1),
                                                     ),
                                                   ],
                                                   color: Color(0xffF4F4F4),
                                                 ),
                                                 alignment: Alignment.center,
                                                 child: Text(
                                                   _range2.isNotEmpty?ebdDate2:"           ",
                                                   style: GoogleFonts.roboto(
                                                     color: ColorPalette.black,
                                                     fontSize: w/24,
                                                     fontWeight: FontWeight.w500,
                                                   ),
                                                 ),
                                               ),

                                             ],
                                           )
                                          ],
                                        ),
                                      ),

                                      Divider(
                                        indent: 10,
                                        height: 2,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 12,
                                            top: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: _selectTime,
                                              child: Text(
                                                startTime,
                                                style: GoogleFonts.roboto(
                                                  color: const Color(0xff2871AF),
                                                  fontSize: w/24,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: _endTime,
                                              child: Text(
                                                endTime,
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xff2871AF),
                                                  fontSize: w/24,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            ,
                            SizedBox(
                              height: 16,
                            ),


                          ],
                        ):
                        select==2?
                        Column(
                          children: [
                            widget.edit==true?Container():
                            SizedBox(
                                height: h / 12,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(right: 16, bottom: 10),
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: joblist!.length,
                                  itemBuilder: (BuildContext context, int i) {

                                    return GestureDetector(
                                        onTap: (){
                                          onSelect(i);
                                          jobtitle.text=joblist?[i].name??"";
                                          jobdiscription.text=joblist?[i].description??"";
                                          relatedJobId=joblist?[i].id??0;
                                        },
                                        child:Container(
                                          width: w/3,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            border: selectInstat==i?Border.all(color: ColorPalette.primary, width: 1, ):
                                            Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x05000000),
                                                blurRadius: 8,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            joblist?[i].name.toString().toTitleCase()??"",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: w/24,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ));
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 5,
                                    );
                                  },
                                )),
                            Container(
                              width: w,
                              // height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
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
                                    margin: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 10,
                                        top: 10),
                                    child: SingleRow(
                                        color: Color(0xfffc3a97),
                                        label: "Date & Time",
                                        svg: CreateSvg().clockIcon,
                                        onTap: () {
                                          setState(() {
                                            // isTime = !isTime;
                                          });
                                        },
                                        endIcon: GestureDetector(

                                          onTap: () {
                                            focusNode.unfocus();
                                            descriptionfocusNode.unfocus();
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                      MainAxisSize
                                                          .min,
                                                      children: [
                                                        Container(
                                                          height: 300,
                                                          child:
                                                          Scaffold(
                                                            body:
                                                            SfDateRangePicker(
                                                              backgroundColor:
                                                              Colors.white,
                                                              endRangeSelectionColor:
                                                              ColorPalette.primary,
                                                              startRangeSelectionColor:
                                                              ColorPalette.primary,
                                                              rangeSelectionColor:
                                                              ColorPalette.primary
                                                                  .withOpacity(0.1),
                                                              selectionColor:
                                                              Colors.grey,
                                                              todayHighlightColor:
                                                              ColorPalette.primary,
                                                              onSelectionChanged:
                                                              _onSelectionChanged,
                                                              selectionMode:
                                                              DateRangePickerSelectionMode
                                                                  .range,
                                                              initialSelectedRange: widget.edit?PickerDateRange(
                                                                  DateTime.parse(startDate),
                                                                  DateTime.parse(ebdDate)):
                                                              startDate!=""?PickerDateRange(
                                                                  DateTime.parse(startDate),
                                                                  DateTime.parse(ebdDate)):
                                                              PickerDateRange(
                                                                  DateTime.now(),
                                                                  DateTime.now()),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if(_range.isEmpty)
                                                              setState(() {
                                                                // if (DateTime.now() is PickerDateRange) {
                                                                _range = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
                                                                _range2 = '${DateFormat('dd-MM-yyyy').format(DateTime.now())}';
                                                                print("range is here$_range");

                                                                startDate=_range;
                                                                startDate2=_range2;
                                                                ebdDate=_range;
                                                                ebdDate2=_range2;

                                                                // validationCheck();
                                                              });

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                          Container(
                                                            height: 25,
                                                            width: 75,
                                                            color: ColorPalette
                                                                .primary,
                                                            child: Center(
                                                                child: Text(
                                                                  "Ok",
                                                                  style: GoogleFonts.roboto(
                                                                      color: Colors.white
                                                                  ),)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },

                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child:  Text("Choose Date",
                                                style: GoogleFonts.roboto(
                                                    fontSize: w/24,
                                                    color: ColorPalette.primary,
                                                    fontWeight: FontWeight.w500
                                                ),)),
                                        )),
                                  ),
                                  Column(
                                    children: [
                                      Divider(
                                        indent: 10,
                                        height: 2,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 10,
                                            top: 10),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "From :",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                  ),
                                                ),
                                                SizedBox(width: w/40,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    // border:
                                                    // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x05000000),
                                                        blurRadius: 8,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    color: Color(0xffF4F4F4),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    _range2.isNotEmpty? startDate2:"           ",
                                                    style: GoogleFonts.roboto(
                                                      color: ColorPalette.black,
                                                      fontSize: w/24,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "To :",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: w/24,
                                                  ),
                                                ),
                                                SizedBox(width: w/40,),
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    // border:
                                                    // Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(0x05000000),
                                                        blurRadius: 8,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    color: Color(0xffF4F4F4),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    _range2.isNotEmpty?ebdDate2:"           ",
                                                    style: GoogleFonts.roboto(
                                                      color: ColorPalette.black,
                                                      fontSize: w/24,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      Divider(
                                        indent: 10,
                                        height: 2,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 12,
                                            top: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: _selectTime,
                                              child: Text(
                                                startTime,
                                                style: GoogleFonts.roboto(
                                                  color: const Color(0xff2871AF),
                                                  fontSize: w/24,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: _endTime,
                                              child: Text(
                                                endTime,
                                                style: GoogleFonts.roboto(
                                                  color: Color(0xff2871AF),
                                                  fontSize: w/24,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ):
                        Container(),

                        GestureDetector(
                          onTap: (){
                            validationCheck();
                            focusNode.unfocus();
                            descriptionfocusNode.unfocus();
                            _showModalBottomSheet(PriorityLeval);
                            setState(() {

                            });
                          },
                          child: Container(
                            width: w,
                            padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
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
                            child: SingleRow(
                                color: const Color(0xff33c658),
                                label: "Set Priority",
                                svg: CreateSvg().priorityIcon,
                                onTap: () {
                                  validationCheck();
                                  focusNode.unfocus();
                                  descriptionfocusNode.unfocus();
                                  _showModalBottomSheet(PriorityLeval);

                                  setState(() {

                                  });
                                },
                                endIcon: Row(
                                  children: [
                                    Container(
                                      // color:Colors.red,
                                        width: w/4.5,
                                        child: PriorityLeval==""?Container():Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SvgPicture.string(
                                              TaskSvg().priorityIcon,
                                              color: PriorityLeval=="Low"?Color(0xff50D166):
                                              PriorityLeval=="Medium"?Color(0xffF18F1C):
                                              null,
                                            ),
                                            Text(PriorityLeval,style: TextStyle(fontSize: w/24,fontWeight: FontWeight.w500),),
                                          ],
                                        )),
                                    PriorityLeval==""?Icon(Icons.arrow_forward_ios_sharp,size: 18,):Container()
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text("* Please fill in all the fields listed  above",style: GoogleFonts.roboto(
                            fontSize: w/30
                        ),),

                        SizedBox(height: h/40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isValid==true?GestureDetector(
                              onTap: (){
                                jobtitle.text==""||jobdiscription.text==""||_range==""?Fluttertoast.showToast(
                                    msg: 'Please Fill Fields',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black):
                                widget.edit?BlocProvider.of<JobBloc>(context)
                                    .add(UpdateJobEvent(
                                  id: JobRead?.id,
                                  startDate: "$startDate $startTime2",
                                  endDate: "$ebdDate $endTime2",
                                  originFrom: "Suggestions",
                                  reportingPerson: JobRead?.reportingCode??"",
                                  priority: PriorityLeval,
                                  name: jobtitle.text,
                                  jobType: jobtype??0,
                                  isActive: true,
                                  assignedBy: authentication.authenticatedUser.code??"",
                                  createdBy: authentication.authenticatedUser.code??"",
                                  discription: jobdiscription.text,

                                )):select==2?BlocProvider.of<JobBloc>(context).add(
                                    CreateJobEvent(
                                        discription: jobdiscription.text??"",
                                        createdBy: authentication.authenticatedUser.code??"",
                                        assignedBy: authentication.authenticatedUser.code??"",
                                        isActive: true,
                                        jobType: jobtype??0,
                                        name: jobtitle.text??"",
                                        priority: PriorityLeval,
                                        relatedJob: relatedJobId,
                                        reportingPerson: authentication.authenticatedUser.code??"",
                                        endDate: "${_range.split(" - ")[1]} $endTime2",
                                        originFrom: "Suggestions",
                                        startDate: "${_range.split(" - ")[0]} $startTime2"
                                    )):
                                BlocProvider.of<JobBloc>(context).add(
                                    CreateJobEvent(
                                        discription: jobdiscription.text??"",
                                        createdBy: authentication.authenticatedUser.code??"",
                                        assignedBy: authentication.authenticatedUser.code??"",
                                        isActive: true,
                                        jobType: jobtype??0,
                                        name: jobtitle.text??"",
                                        priority: PriorityLeval,
                                        relatedJob: null,
                                        reportingPerson: authentication.authenticatedUser.code??"",
                                        endDate: "${_range.split(" - ")[1]} $endTime2",
                                        originFrom: "Suggestions",
                                        startDate: "${_range.split(" - ")[0]} $startTime2"
                                    ));
                                // Navigator.pop(context);
                              },
                              child: Container(
                                width: w / 2.6,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff2871AF),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.edit?"Update":"Create",

                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ):GestureDetector(
                              child: Container(
                                width: w / 2.6,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffD3D3D3),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  widget.edit?"Update":"Create",

                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    )
                    ]
                  ],
                ),
              ),
            ),
          ),
        )

    );
  }
  _showModalBottomSheet(String priorityread) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        useRootNavigator: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                // height: 350,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [

                        Text(
                          "Set Priority ",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20,),
                         Container(
                          // thickness: 1,
                          // indent: 10,
                          height: 1,
                          width: w,
                          color: Color(0xfff8f7f5),
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            Variable.prioritys="High";
                            PriorityLeval="High";
                            setState((){});
                            refreah();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: priorityread=="High"?EdgeInsets.all(10):null,
                            color: priorityread=="High"?Color(0xffF4F4F4):Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xffe6ecf0),
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.string(TaskSvg().priorityIcon),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "High Priority",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/22,
                                    fontWeight: priorityread=="High"?FontWeight.w500:FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          // thickness: 1,
                          // indent: 10,
                          height: 1,
                          width: w,
                          color: Color(0xfff8f7f5),
                        ),
                        SizedBox(height: 10,),
                        InkWell(onTap: (){
                          Variable.prioritys="Medium";
                          PriorityLeval="Medium";
                          setState((){});
                          refreah();
                          print("TASK PRIORITY${Variable.prioritys}");
                          Navigator.pop(context);

                        },
                          child: Container(
                            padding: priorityread=="Medium"?EdgeInsets.all(10):null,
                            color: priorityread=="Medium"?Color(0xffF4F4F4):Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xffe6ecf0),
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.string(
                                    TaskSvg().priorityIcon,
                                    color: Color(0xffF18F1C),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Medium Priority",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/22,
                                    fontWeight: priorityread=="Medium"?FontWeight.w500:FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          // thickness: 1,
                          // indent: 10,
                          height: 1,
                          width: w,
                          color: Color(0xfff8f7f5),
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            Variable.prioritys="Low";
                            PriorityLeval="Low";
                            setState((){});
                            refreah();
                            print("TASK PRIORITY${Variable.prioritys}");
                            Navigator.pop(context);
                            setState((){});


                          },
                          child: Container(
                            padding: priorityread=="Low"?EdgeInsets.all(10):null,
                            color: priorityread=="Low"?Color(0xffF4F4F4):Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xffe6ecf0),
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.string(
                                    TaskSvg().priorityIcon,
                                    color: Color(0xff50D166),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Low Priority",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w/22,
                                    fontWeight: priorityread=="Low"?FontWeight.w500:FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25,)

                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(left: 16),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xfffd5762),
                        //       ),
                        //       child: SvgPicture.string(HomeSvg().imgFeedIcon),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Video / Image Feed ",
                        //       style: GoogleFonts.roboto(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   indent: 70,
                        //   color: Color(0xffE6ECF0),
                        // ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(left: 16),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xfffd5762),
                        //       ),
                        //       child: SvgPicture.string(HomeSvg().analyticIcon),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Updation / Analytics",
                        //       style: GoogleFonts.roboto(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const Divider(
                        //   indent: 70,
                        //   color: Color(0xffE6ECF0),
                        // ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(left: 16),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xfffd5762),
                        //       ),
                        //       child: SvgPicture.string(HomeSvg().chatGroupIcon),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       "Chat or Group",
                        //       style: GoogleFonts.roboto(
                        //         color: Colors.black,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 50,
                        // )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
  // _showModalBottomSheet(String priorityread) {
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(18), topRight: Radius.circular(18)),
  //       ),
  //       context: context,
  //       builder: (context) {
  //         var h = MediaQuery.of(context).size.height;
  //         var w = MediaQuery.of(context).size.width;
  //         return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               padding: EdgeInsets.all(16),
  //               height: 350,
  //               width: double.infinity,
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(10),
  //                     topLeft: Radius.circular(10),
  //                   )),
  //               alignment: Alignment.center,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Container(
  //                     width: w,
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       "Priority",
  //                       style: GoogleFonts.poppins(
  //                         color: Colors.black,
  //                         fontSize: w/20,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Divider(
  //                     color: Color(0xffA9A8A8).withOpacity(0.3),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   InkWell(
  //                     onTap: (){
  //                       Variable.prioritys="High";
  //                       PriorityLeval="High";
  //                       setState((){});
  //                       refreah();
  //                       Navigator.pop(context);
  //                     },
  //                     child: Container(
  //                       padding: priorityread=="High"?EdgeInsets.all(10):null,
  //                       color: priorityread=="High"?Colors.red.withOpacity(0.1):Colors.white,
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             width: 40,
  //                             height: 40,
  //                             padding: EdgeInsets.all(8),
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(5),
  //                               border: Border.all(
  //                                 color: Color(0xffe6ecf0),
  //                                 width: 1,
  //                               ),
  //                               color: Colors.white,
  //                             ),
  //                             child: SvgPicture.string(TaskSvg().priorityIcon),
  //                           ),
  //                           SizedBox(
  //                             width: 16,
  //                           ),
  //                           Text(
  //                             "High Priority",
  //                             style: GoogleFonts.roboto(
  //                               color: Colors.black,
  //                               fontSize: w/22,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Divider(
  //                     indent: 50,
  //                     color: Color(0xffA9A8A8).withOpacity(0.3),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   InkWell(onTap: (){
  //                     Variable.prioritys="Medium";
  //                     PriorityLeval="Medium";
  //                     setState((){});
  //                     refreah();
  //                     print("TASK PRIORITY${Variable.prioritys}");
  //                     Navigator.pop(context);
  //
  //                   },
  //                     child: Container(
  //                       padding: priorityread=="Medium"?EdgeInsets.all(10):null,
  //                       color: priorityread=="Medium"?Colors.red.withOpacity(0.1):Colors.white,
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             width: 40,
  //                             height: 40,
  //                             padding: EdgeInsets.all(8),
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(5),
  //                               border: Border.all(
  //                                 color: Color(0xffe6ecf0),
  //                                 width: 1,
  //                               ),
  //                               color: Colors.white,
  //                             ),
  //                             child: SvgPicture.string(
  //                               TaskSvg().priorityIcon,
  //                               color: Color(0xffF18F1C),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 16,
  //                           ),
  //                           Text(
  //                             "Medium Priority",
  //                             style: GoogleFonts.roboto(
  //                               color: Colors.black,
  //                               fontSize: w/22,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Divider(
  //                     indent: 50,
  //                     color: const Color(0xffA9A8A8).withOpacity(0.3),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   InkWell(
  //                     onTap: (){
  //                       Variable.prioritys="Low";
  //                       PriorityLeval="Low";
  //                       setState((){});
  //                       refreah();
  //                       print("TASK PRIORITY${Variable.prioritys}");
  //                       Navigator.pop(context);
  //                       setState((){});
  //
  //
  //                     },
  //                     child: Container(
  //                       padding: priorityread=="Low"?EdgeInsets.all(10):null,
  //                       color: priorityread=="Low"?Colors.red.withOpacity(0.1):Colors.white,
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             width: 40,
  //                             height: 40,
  //                             padding: EdgeInsets.all(8),
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(5),
  //                               border: Border.all(
  //                                 color: Color(0xffe6ecf0),
  //                                 width: 1,
  //                               ),
  //                               color: Colors.white,
  //                             ),
  //                             child: SvgPicture.string(
  //                               TaskSvg().priorityIcon,
  //                               color: Color(0xff50D166),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: 16,
  //                           ),
  //                           Text(
  //                             "Low Priority",
  //                             style: GoogleFonts.roboto(
  //                               color: Colors.black,
  //                               fontSize: w/22,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }
}
