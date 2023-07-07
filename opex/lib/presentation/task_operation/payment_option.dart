
import 'dart:io';

import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../common_widgets/loading.dart';
import '../../../../core/color_palatte.dart';
import '../../../../core/common_snackBar.dart';
import '../../core/utils/variables.dart';
import '../inventory/inventory_new_list.dart';
import '../inventory/new_list_tab/profiling_tab.dart';
import '../promotion_app/dropdown_card.dart';
import 'attachment_screen.dart';
import 'create/add_text.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_model/employee_model.dart';
import 'home/model/joblist_model.dart';

class PaymentOption extends StatefulWidget {
  final bool update;
  final bool isJob;
  final bool isTask;
  final int taskId;
  final int? jobId;
  final int paymentId;
  final GetJobList? joblist;
  final GetTaskList? taskList;
  const PaymentOption({Key? key,  this.update=false,
    this.isJob=false,  this.isTask=false,
    this.taskId=0,  this.jobId=0, required this.paymentId, this.joblist, this.taskList}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  List<String> assignTypeList = ["Individual", "Task_Group",];
  String? selCode;
  bool active=false;
  String? selectedType;
  String? selectedCode;
  GetEmployeeList? selectedEmp;
  List<GetTaskGroupList> grouplist=[];
  PaymentModel? paymentRead;
  List<GetEmployeeList> employeeList=[];
  TextEditingController expenceController=TextEditingController();
  TextEditingController budgetController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController notesController=TextEditingController();

  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl='';
  String? imageFileName;

  int indexImage=0;
  int catindexImage=0;
  bool isCatalogue=false;
  @override
  void initState() {
    catalogueList.clear();
    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("Task Id${widget.taskId}");
    var w =MediaQuery.of(context).size.width;
    return MultiBlocListener(
  listeners: [
    BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if(state is PicLoading){
          print("Inside Loading");
        }
        if(state is PicSuccess){
          print("Inside Success${state.data}\t${state.url}");
          setState(() {
            isCatalogue? catalogueList.replaceRange(indexImage, indexImage+1,
                [PicModel(data: state.data,url: state.url)]):picModel.replaceRange(indexImage, indexImage+1,
                [PicModel(data: state.data,url: state.url)]);
          });
          print("pic model length${picModel.length}");

        }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
  listener: (context, state) {
    if (state is CreatePaymentLoading) {
      showSnackBar(context,
          message: "Loading...",
          color: Colors.white,
          // icon: HomeSvg().SnackbarIcon,
          autoDismiss: true);
    }

    if (state is CreatePaymentFailed) {
      showSnackBar(
        context,
        message: state.error,
        color: Colors.red,
        // icon: Icons.admin_panel_settings_outlined
      );
    }
    if (state is CreatePaymentSuccess) {
      // createJob = state.user;

      Fluttertoast.showToast(
          msg: 'Successfully Created',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black);
      context.read<JobBloc>().add(
          GetJobReadListEvent(Variable.jobReadId));
      context.read<TaskBloc>().add(
          GetTaskReadListEvent(widget.taskId));
      Navigator.pop(context);
    }
  },
),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is UpdatePaymentLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is UpdatePaymentFailed) {
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is UpdatePaymentSuccess) {
          // createJob = state.user;

          Fluttertoast.showToast(
              msg: 'Successfully Updated',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          context.read<JobBloc>().add(
              GetJobReadListEvent(Variable.jobReadId));
          context.read<TaskBloc>().add(
              GetTaskReadListEvent(Variable.taskReadId));
          Navigator.pop(context);
        }
      },
    ),
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state is GetGroupListLoading) {
          customCupertinoLoading();
        }
        if (state is GetGroupListSuccess) {
          print("GROUPLIST${state.groupList.length}");
          grouplist=state.groupList;
          setState(() {

          });
        }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is GetPaymentReadLoading) {
          customCupertinoLoading();
        }
        if (state is GetPaymentReadSuccess) {
          paymentRead=state.paymentRead;
          budgetController.text=paymentRead?.budget.toString()??"";
          discriptionController.text=paymentRead?.description??"";
          expenceController.text=paymentRead?.expense.toString()??"";
          notesController.text=paymentRead?.notes??"";
          selectedType=paymentRead?.assigningType??"";
          selCode=paymentRead?.assigningCode??"";
          selectedCode=paymentRead?.assigningCode??"";
          picModel.setAll(0, [
            PicModel(
                url: paymentRead?.costingMeta?.image1 ??
                    "")
          ]);
          picModel.setAll(1, [
            PicModel(
                url: paymentRead?.costingMeta?.image2 ??
                    "")
          ]);
          picModel.setAll(2, [
            PicModel(
                url: paymentRead?.costingMeta?.image3 ??
                    "")
          ]);
          picModel.setAll(3, [
            PicModel(
                url: paymentRead?.costingMeta?.image4 ??
                    "")
          ]);
          picModel.setAll(4, [
            PicModel(
                url: paymentRead?.costingMeta?.image5 ??
                    "")
          ]);
          setState(() {

          });
        }
      },
    ),
    BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state is GetEmployeeListLoading) {
          customCupertinoLoading();
        }
        if (state is GetEmployeeListSuccess) {
          print("EMplot${state.employeeList.length}");
          employeeList=state.employeeList;
          setState(() {

          });
        }
      },
    ),
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:  BackAppBar(
          label: "Payment Option",
          isAction: false,
          action: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  widget.update?BlocProvider.of<TaskBloc>(context).add(
                      UpdatePaymentEvent(
                          isActive: true,
                          discription: discriptionController.text,
                          taskId: paymentRead?.taskId,
                          budget: double.tryParse(budgetController.text)??0.0,
                          expense: double.tryParse(expenceController.text)??0.0,
                          notas: notesController.text,
                          jobId: paymentRead?.jobId,
                          AssigningCode: selCode??"",
                          assigningType: selectedType??"",
                          payId: paymentRead?.id,
                          img1: picModel[0].data??picModel[0].url,
                          img5: picModel[4].data??picModel[4].url,
                          img4: picModel[3].data??picModel[3].url,
                          img3: picModel[2].data??picModel[2].url,
                          img2: picModel[1].data??picModel[1].url
                      )):
                  BlocProvider.of<TaskBloc>(context).add(
                      CreatePaymentEvent(
                          discription: discriptionController.text,
                          taskId: widget.taskId,
                          budget: double.tryParse(budgetController.text)??0.0,
                          expense: double.tryParse(expenceController.text)??0.0,
                          notas: notesController.text,
                          jobId: widget.jobId,
                          AssigningCode: selCode??"",
                          assigningType: selectedType??"",
                        img1: picModel[0].data??0,
                        img5: picModel[4].data??0,
                        img4: picModel[3].data??0,
                        img3: picModel[2].data??0,
                        img2: picModel[1].data??0


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
                      fontSize: w/22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [

            Container(
              width: w,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.isJob?Container():widget.isTask?
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.update?Container():Text(
                        "Assigning Type",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      widget.update?Container():SizedBox(height: 10,),
                      widget.update?
                      ReadDropDownCard(
                        label: "Assigning Type",
                        selValue: paymentRead?.assigningType??"",
                      ):Container(
                        width: w / 1,
                        // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        //height: 20.0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2), width: 1),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            underline: Container(),
                            items: assignTypeList.map((String items) {
                              return DropdownMenuItem(
                                enabled: true,
                                value: items,
                                child: Text(items,
                                    style: TextStyle(
                                        color: Colors.black)),
                              );
                            }).toList(),
                            value: selectedType,
                            onChanged: (dynamic value) {


                              setState(() {
                                selectedType = value;
                                selectedType=="Individual"?context.read<JobBloc>().add(GetEmployeeListEvent()):
                                selectedType=="Task_Group"?context.read<JobBloc>().add(GetGroupListEvent()):null;
                              });

                            },
                            hint: Text(
                              "Assign Type",
                              style: GoogleFonts.poppins(
                                  color:Colors.grey,fontSize: 14),
                            )),
                      ),
                      SizedBox(height: 10,),
                      widget.update?
                      ReadDropDownCard(
                        label: "Assigning Code",
                        selValue: paymentRead?.assigningCode??"",
                      ):selectedType=="Task_Group"?
                      Flex(direction: Axis.vertical,
                          children:[
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Assigning Code",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w/24,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                Container(
                                  width: w,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(color: Colors.white,
                                      border: Border.all(color: Color(0xffe6ecf0)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    underline:Container(),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                                    hint: const Text("Assigning Code"),
                                    value: selCode,
                                    onChanged: (value) {
                                      setState(() {
                                        selCode = value;
                                      });
                                    },

                                    items: grouplist
                                        .map<DropdownMenuItem<String>>((GetTaskGroupList _value) =>
                                        DropdownMenuItem<String>(
                                            value: _value.groupCode,
                                            child: Text(_value.gName??"",)
                                        )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ])
                          :
                      selectedType=="Individual"?Flex(direction: Axis.vertical,
                          children:[
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Assigning Code",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w/24,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                Container(
                                  width: w,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(color: Colors.white,
                                      border: Border.all(color: Color(0xffe6ecf0)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    underline:Container(),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                                    hint: const Text("Assigning Code"),
                                    value: selCode,
                                    onChanged: (value) {
                                      setState(() {
                                        selCode = value;
                                      });
                                    },

                                    items: employeeList
                                        .map<DropdownMenuItem<String>>((GetEmployeeList _value) =>
                                        DropdownMenuItem<String>(
                                            value: _value.code,
                                            child: Text(_value.fname??"",)
                                        )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ]):
                      Container(),
                    ],
                  ):Container(),

                  SizedBox(height: 10,),
                  Container(
                    width: w,

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
                            child:TextFormField(
                              style:GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600
                              ) ,
                              decoration:  InputDecoration(
                                contentPadding: EdgeInsets.only(left:16,right: 16 ),
                                hintText: "Enter Budget",
                                hintStyle: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w/26,
                                ),
                                border: InputBorder.none,

                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                              controller: budgetController,
                            )
                            ),
                        Divider(indent: 16,),
                        Container(
                          // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                            child:TextFormField(
                              controller: discriptionController,
                              maxLines: 4,
                              minLines: 1,
                              decoration:  InputDecoration(
                                contentPadding: EdgeInsets.only(left: 16,top: 10,right: 16,bottom: 16),
                                hintText: "Enter Description",
                                hintStyle: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w/26,
                                ),
                                border: InputBorder.none,
                              ),

                            )
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 26),
                  GestureDetector(
                    onTap: (){
                      active=!active;
                      setState(() {

                      });
                    },
                    child: Container(
                      width: w,
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
                      child: AddText(
                        label: "Add Notes",
                        hint: "Add Notes",
                        controller: notesController,
                        isActive: active==true?true:notesController.text==""?false:true,),
                    ),
                  ),
                  SizedBox(height: 26),
                  Text(
                    "Images",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(

                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 100,
                              childAspectRatio: 1.5 / 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 8),
                          itemBuilder: (context, i) {
                            // print("eeeeeeeeeeeee  ${picModel[i].url}");
                            return GestureDetector(
                              onTap: (){
                                isCatalogue=false;
                                indexImage=i;
                                setState(() {

                                });
                                getCoverImage(ImageSource.gallery);
                              },
                              // getImage(ImageSource.gallery);
                              // onTap: isAdmin?onTapListTileAdmin(i, context):onTapListTile(i, context),
                              child:
                              picModel[i].url!=""&&picModel[i].url!.isNotEmpty?
                              Container(
                                  width: 88,
                                  height: 100,
                                  decoration:BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(picModel[i].url.toString()),fit: BoxFit.fill
                                      )
                                  )
                              )
                                  :
                              Container(
                                  width: 88,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x05000000),
                                        blurRadius: 8,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: const Icon(Icons.add,color:Color(0x7f666161))
                              ),
                            );
                          })),
                ],
              ),
            )
          ]),
        ),
      ),
    ),
);
  }
  Future<void> getCoverImage(source) async {
    try {
      final pickedFile = await picker.pickImage(
          source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        // BlocProvider.of<DiscountBloc>(context)
        //     .add(PostImageDiscountEvent(cropImage!));
        BlocProvider.of<EmployeeBloc>(context).add(PostImageAllEvent(cropImage!));
        imageFileName=cropImage?.path.split("_")[1];
        print("cropppp$imageFileName");
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
