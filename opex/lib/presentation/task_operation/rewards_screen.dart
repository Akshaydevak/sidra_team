import 'dart:io';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../core/color_palatte.dart';
import '../../core/common_snackBar.dart';
import 'create/add_text.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_bloc/employee_bloc.dart';


class RewardsScreen extends StatefulWidget {
  final int typeId;
  final String type;
  final bool update;
  const RewardsScreen({Key? key, required this.typeId, required this.type, required this.update}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
   TextEditingController rewardName=TextEditingController();
   TextEditingController discription=TextEditingController();
   TextEditingController notes=TextEditingController();
   final picker = ImagePicker();
   File? cropImage;
   bool _cropped = false;
   int? imageId;
   ReadRewards? rewadsRead;
  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.of(context).size.width;
    var h =MediaQuery.of(context).size.height;
    return MultiBlocListener(
  listeners: [
    BlocListener<EmployeeBloc, EmployeeState>(
  listener: (context, state) {
    if(state is PostImageLoading){

    }
    if(state is PostImageSuccess){
      print("pIC IS ID${state.id}");
      imageId=state.id;
      setState(() {

      });
    }
  },
),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if(state is GetReadRewadsLoading){

        }
        if(state is GetReadRewadsSuccess){

          rewadsRead=state.readRewards;
          rewardName.text=rewadsRead?.name??"";
          discription.text=rewadsRead?.description??"";
          notes.text=rewadsRead?.notes??"";

          setState(() {

          });
        }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        print('StateCreate$state');
        if (state is CreateRewardLoading) {
          print("loading");
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is CreateRewardFailed) {
          print("failed");
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is CreateRewardSuccess) {
          print("succss");
          Fluttertoast.showToast(
              msg: 'Reward Successfully Created',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          widget.type=="Task"?context.read<TaskBloc>().add(
              GetTaskReadListEvent(widget.typeId)):
          context.read<JobBloc>().add(
              GetJobReadListEvent(widget.typeId));
          Navigator.pop(context);


        }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        print('StateCreate$state');
        if (state is UpdateRewardLoading) {
          print("loading");
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is UpdateRewardFailed) {
          print("failed");
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is UpdateRewardSuccess) {
          print("succss");
          Fluttertoast.showToast(
              msg: 'Reward Successfully Updated',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          widget.type=="Task"?context.read<TaskBloc>().add(
              GetTaskReadListEvent(widget.typeId)):
          context.read<JobBloc>().add(
              GetJobReadListEvent(widget.typeId));
          Navigator.pop(context);


        }
      },
    ),
  ],
  child: GestureDetector(
    onTap: (){
      FocusScopeNode currentFocus = FocusScope.of(context);
    },
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
              TaskAndOperationAppBar(
                label: "Rewards",
                EndIcon: GestureDetector(
                  onTap: (){
                    widget.update?BlocProvider.of<TaskBloc>(context)
                        .add(UpdateRewardTaskEvent(
                      isActive: true,
                        id: rewadsRead?.id??0,
                        typeId: rewadsRead?.typeId,
                        type:rewadsRead?.types,
                        image: imageId??0,
                        notes: notes.text??"",
                        discription: discription.text??"",
                        name: rewardName.text??""
                    )):BlocProvider.of<TaskBloc>(context)
                        .add(CreateRewardTaskEvent(
                      typeId: widget.typeId,
                      type: widget.type,
                      image: imageId??0,
                      notes: notes.text??"",
                      discription: discription.text??"",
                      name: rewardName.text??""
                    ));
                  },
                  child: Container(
                    // width: 110,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorPalette.primary,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.update?"Update":"Create",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: w,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: w,
                      height: 185,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
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
                          Container(
                            // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                              child:TextFormField(controller: rewardName,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 16),
                                    hintText: "Reward Name",
                                    hintStyle:TextStyle(
                                      color: Color(0xff939393),
                                      fontSize: 18,
                                    ),
                                    border: InputBorder.none
                                ),
                              )
                          ),
                          Divider(indent: 16,),
                          Container(
                            // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                              child:TextFormField(controller: discription,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 16),
                                    hintText: "Enter Description",
                                    hintStyle:TextStyle(
                                      color: Color(0xff939393),
                                      fontSize: 18,
                                    ),
                                    border: InputBorder.none
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                      child: AddText(label: "Add Notes",controller: notes,hint: "Enter Notes",isActive: notes.text==""?false:true,),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xffe6ecf0),
                            width: 1,
                          ),),
                        width: w/2,
                        height: h/4,
                        child: Image.network(rewadsRead?.image??"",fit: BoxFit.cover,)),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            getCoverImage(
                                ImageSource.gallery);
                          },
                          child: Container(
                            // width: 150,
                            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                              color: Color(0xfff8f7f5),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.string(TaskSvg().attachIcon),
                                SizedBox(width: 10,),
                                Text(
                                  "Attach",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ]),
          ),
        ),
      ),
  ),
);
  }
   Future<void> getCoverImage(source) async {
     try {
       final pickedFile = await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

       cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

       if (cropImage != null) {
         BlocProvider.of<EmployeeBloc>(context)
             .add(PostImageEvent(cropImage!));


       }
       setState(() {
         _cropped = true;
       });
     } catch (e) {
       debugPrint(e.toString());
     }
   }
}
