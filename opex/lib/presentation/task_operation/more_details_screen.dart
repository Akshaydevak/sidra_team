import 'dart:async';

import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/payment_option.dart';
import 'package:cluster/presentation/task_operation/rewards_screen.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:cluster/presentation/task_operation/task_title/reporting_person_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/color_palatte.dart';
import '../../../../core/utils/variables.dart';
import '../../core/common_snackBar.dart';
import 'attachment_screen.dart';
import 'create/create_svg.dart';
import 'create/map_location.dart';
import 'create/model/task_models.dart';
import 'create/single_row.dart';
import 'create/task_bloc/task_bloc.dart';


class MoreDetailsScreen extends StatefulWidget {
  final GetTaskList? taskList;
  final Function (bool val)? updateValue;
  const MoreDetailsScreen({Key? key, this.taskList, this.updateValue}) : super(key: key);

  @override
  State<MoreDetailsScreen> createState() => _MoreDetailsScreenState();
}

class _MoreDetailsScreenState extends State<MoreDetailsScreen> {
  bool isTime = false;
  bool isLocation = false;
  bool updateActived=true;
  int select=0;
  void onselct(index){
    setState(() {
      select=index;
      print("seler$select");
    });
  }
  TextEditingController controller=TextEditingController();
  TextEditingController controller1=TextEditingController();
  String startDate="";
  String ebdDate="";
  String startTime="";
  String endTime="";
  CameraPosition _initialPosition = CameraPosition(target: LatLng(26.8206, 30.8025));
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  GetTaskList? readTask;
  @override
  void initState() {
    // context.read<TaskBloc>().add(
    //     GetTaskReadListEvent(readTask?.id??0));
    super.initState();
  }
  location(){
    if(isLocation==false){
      BlocProvider.of<TaskBloc>(context).add(
          UpdateTaskEvent(
            latitude: null,
            longitude:null,
            durationOption: readTask?.duration??"",
            img5:  readTask?.metaData?.image5,
            img1: readTask?.metaData?.image1,
            img4: readTask?.metaData?.image4,
            img2: readTask?.metaData?.image2,
            img3: readTask?.metaData?.image3,
            attachmentDescription: readTask?.metaData?.description,
            attachmentNote: readTask?.metaData?.note,
            id: readTask?.id??0,
            AssigningCode: readTask?.assigningCode??"",
            AssigningType: readTask?.assigningType??"",
            createdOn: "${readTask?.createdOn?.split("T")[0]}"" ""${readTask?.createdOn?.split("T")[1].split("+")[0]}",
            jobid: readTask?.jobId,
            notas: readTask?.notes??"",
            priorityLeval: 0,
            remarks: readTask?.remarks??"",
            taskName: readTask?.taskName??"",
            taskType: readTask?.taskType??0,
            lastmodified: null,
            parant: readTask?.parent??null,
            statusStagesId: null,
            discription:readTask?.description??"",
            createdBy: readTask?.createdPersonCode??"",
            isActive: true,
            priority: readTask?.priority??"",
            reportingPerson: readTask?.reportingPersonCode??"",
            endDate: "${readTask?.endDate?.split("T")[0]}"" ""${readTask?.endDate?.split("T")[1].split("+")[0]}"??"",
            startDate: "${readTask?.startDate?.split("T")[0]}"" ""${readTask?.startDate?.split("T")[1].split("+")[0]}"??"",
          ));
    }
    else{
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: AddressPickFromMap(taskRead: readTask,),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
       Navigator.pop(context);
       Navigator.pop(context);
        return true;
      },
      child: MultiBlocListener(
  listeners: [
      BlocListener<TaskBloc, TaskState>(
  listener: (context, state) {
      if(state is GetTaskReadLoading){

      }
      if(state is GetTaskReadSuccess){
        readTask=state.getTaskRead;
        if(readTask?.latitude!=null&&readTask?.longitude!=null&&readTask?.latitude!=''&&readTask?.longitude!=''){
          isLocation=true;
        }else{
          isLocation=false;
        }
        print("readTask$readTask");
        print("readTask$isLocation");
        print("readTask${readTask?.latitude}");
        print("readTask${readTask?.longitude}");
        Variable.taskReadId=readTask?.id??0;

        setState(() {

        });
      }
  },
)
  ],
  child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white, // Navigation bar
              statusBarColor: Colors.white, // Status bar
            ),

            elevation: 0,

          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          BackAppBar(
            onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            isBack: false,
              label: "More Details",
              isAction: false,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLocation = !isLocation;
                      location();
                    });
                    // location();
                  },
                  child: Container(
                    width: w,
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
                    child: Container(
                      margin: isLocation
                          ? EdgeInsets.only(
                              left: 16, right: 16, bottom: 10, top: 20)
                          : EdgeInsets.all(16),
                      child: SingleRow(
                          color: Color(0xff3B9FFC),
                          label: "Share Location",
                          svg: CreateSvg().locationIcon,
                          onTap: () {
                            setState(() {
                              // if(isLocation==false){
                                isLocation = !isLocation;
                                location();
                                setState(() {

                                });
                              // }
                              // else{
                              //
                              // }

                              // PersistentNavBarNavigator.pushNewScreen(
                              //   context,
                              //   screen: AddressPickFromMap(taskRead: readTask),
                              //   withNavBar: true,
                              //   pageTransitionAnimation: PageTransitionAnimation.fade,
                              // );
                            });
                          },
                          endIcon: isLocation
                              ? SvgPicture.string(HomeSvg().toggleActive,height: 22)
                              : SvgPicture.string(HomeSvg().toggleInActive,height: 22)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(

                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: AttachmentScreen(readData: readTask),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    width: w,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffe6ecf0),
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
                    child:  SingleRow(
                        color: Color(0xffFFC800),
                      label: "Add Attachments",
                      svg: TaskSvg().attachmentIcon,
                      onTap: () {

                      },
                      endIcon: Icon(Icons.arrow_forward_ios_sharp)),
                  ),
                ),

              SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    readTask?.paymentId!=null?context.read<TaskBloc>().add(
                        GetPaymentReadListEvent(readTask?.id??0,true)):null;
                    Variable.taskReadId=readTask?.id??0;
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PaymentOption(
                        isJob: false,
                        isTask: true,
                        update: readTask?.paymentId==null?false:readTask?.paymentId==null?false:true,
                        paymentId: readTask?.paymentId??0,
                        taskId: readTask?.id??0,jobId: null,),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    width: w,
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
                    child:  SingleRow(
                        color: Color(0xff519BE0),
                        svg: TaskSvg().walletIcon,
                      label: "Payment Option",
                      onTap: () {


                      },
                      endIcon: Icon(Icons.arrow_forward_ios_sharp,size: 18,)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    readTask?.rewardid!=null?context.read<TaskBloc>().add(
                        GetReadRewardsEvent(readTask?.id??0,true)):null;
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: RewardsScreen(type: "Task",typeId: readTask?.id??0,
                      update: readTask?.rewardid==null?false:readTask?.rewardid==null?false:true,),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    width: w,
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
                    child:  SingleRow(
                        label: "Rewards",
                        color: Color(0xffE051B8),
                        svg: TaskSvg().rewardIcon,
                      onTap: () {

                      },
                      endIcon: Icon(Icons.arrow_forward_ios_sharp,size: 18,)),
                  ),
                ), SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ]))),
      ),
),
    );
  }

}
