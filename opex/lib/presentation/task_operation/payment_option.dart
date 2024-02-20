import 'dart:io';

import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_card.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common_widgets/loading.dart';
import '../../../../core/color_palatte.dart';
import '../../../../core/common_snackBar.dart';
import '../../common_widgets/gradient_button.dart';
import '../../common_widgets/no_glow.dart';
import '../../core/utils/variables.dart';
import '../inventory/inventory_new_list.dart';
import '../inventory/new_list_tab/profiling_tab.dart';
import '../promotion_app/dropdown_card.dart';
import 'attachment_screen.dart';
import 'create/add_text.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_model/employee_model.dart';
import 'group_list.dart';
import 'home/model/joblist_model.dart';

class PaymentOption extends StatefulWidget {
  final bool update;
  final bool isJob;
  final bool isTask;
  final int taskId;
  final int? jobId;
  final int paymentId;
  final GetJobList? joblist;
  final String? currencyCode;
  final String? assignType;
  final String? assignCode;
  final GetTaskList? taskList;
  const PaymentOption(
      {Key? key,
      this.update = false,
      this.isJob = false,
      this.isTask = false,
      this.taskId = 0,
      this.jobId = 0,
      this.assignCode = '',
      this.assignType = '',
      required this.paymentId,
      this.joblist,
      this.taskList,
      this.currencyCode})
      : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  List<String> assignTypeList = [
    "Individual",
    "Task_Group",
  ];
  String? selCode;
  String? selName;
  bool active = false;
  String? selectedType;
  String? selectedCode;
  GetEmployeeList? selectedEmp;
  PaymentModel? paymentRead;
  TextEditingController expenceController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl = '';
  String? imageFileName;
  bool buttonLoad = false;

  int indexImage = 0;
  int catindexImage = 0;
  bool isCatalogue = false;
  List<PicModel> picModelPayment = [];
  @override
  void initState() {
    picModelPayment.clear();
    for (int i = 0; i < 5; i++) {
      picModelPayment.add(PicModel(data: null, url: null));
    }
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  bool? isValid = false;
  validationCheck() {
    if (budgetController.text != "" && discriptionController.text != '') {
      isValid = true;
    } else {
      isValid = false;
    }
  }

  void clearDataAtIndex(int index) {
    if (index >= 0 && index < picModelPayment.length) {
      picModelPayment[index] = PicModel(data: null, url: null);
    }
    setState(() {});
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    print("Task Id${widget.taskId}");
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        widget.isJob
            ? context
                .read<TaskBloc>()
                .add(GetTaskListEvent(widget.jobId, '', '', '', false, '', ''))
            : null;
        return true;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if (state is PicSuccess) {
                print("Inside Success${state.data}\t${state.url}");
                setState(() {
                  isCatalogue
                      ? catalogueList.replaceRange(indexImage, indexImage + 1,
                          [PicModel(data: state.data, url: state.url)])
                      : picModelPayment.replaceRange(indexImage, indexImage + 1,
                          [PicModel(data: state.data, url: state.url)]);
                });
                print("pic model length${picModelPayment.length}");
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is CreatePaymentFailed) {
                buttonLoad = false;
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
                setState(() {});
              }
              if (state is CreatePaymentSuccess) {
                buttonLoad = false;
                // createJob = state.user;

                Fluttertoast.showToast(
                    msg: 'Successfully Created',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                context
                    .read<JobBloc>()
                    .add(GetJobReadListEvent(widget.jobId ?? 0));
                context
                    .read<TaskBloc>()
                    .add(GetTaskReadListEvent(widget.taskId));
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is UpdatePaymentFailed) {
                buttonLoad = false;
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                  // icon: Icons.admin_panel_settings_outlined
                );
                setState(() {});
              }
              if (state is UpdatePaymentSuccess) {
                buttonLoad = false;
                // createJob = state.user;

                Fluttertoast.showToast(
                    msg: 'Successfully Updated',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                context
                    .read<JobBloc>()
                    .add(GetJobReadListEvent(widget.jobId ?? 0));
                context
                    .read<TaskBloc>()
                    .add(GetTaskReadListEvent(Variable.taskReadId));
                Navigator.pop(context);
                setState(() {});
              }
            },
          ),

          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is GetPaymentReadSuccess) {
                paymentRead = state.paymentRead;
                budgetController.text = paymentRead?.budget.toString() ?? "";
                discriptionController.text = paymentRead?.description ?? "";
                expenceController.text = paymentRead?.expense.toString() ?? "";
                notesController.text = paymentRead?.notes ?? "";
                selectedType = paymentRead?.assigningType ?? "";
                selCode = paymentRead?.assigningCode ?? "";
                selectedCode = paymentRead?.assigningCode ?? "";
                picModelPayment.setAll(0,
                    [PicModel(url: paymentRead?.costingMeta?.image1 ?? null)]);
                picModelPayment.setAll(1,
                    [PicModel(url: paymentRead?.costingMeta?.image2 ?? null)]);
                picModelPayment.setAll(2,
                    [PicModel(url: paymentRead?.costingMeta?.image3 ?? null)]);
                picModelPayment.setAll(3,
                    [PicModel(url: paymentRead?.costingMeta?.image4 ?? null)]);
                picModelPayment.setAll(4,
                    [PicModel(url: paymentRead?.costingMeta?.image5 ?? null)]);
                widget.update == false
                    ? count = 0
                    : count = picModelPayment.length;
                setState(() {});
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BackAppBar(
              label: "Payment Option",
              isAction: false,
              isBack: false,
              onTap: () {
                widget.isJob
                    ? context.read<TaskBloc>().add(GetTaskListEvent(
                        widget.jobId, '', '', '', false, '', ''))
                    : null;
                Navigator.pop(context);
              },
              action: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isValid == false
                      ? GestureDetector(
                          child: Container(
                            // width: 110,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffd3d3d3),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              widget.update ? "Update" : "Create",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            buttonLoad = true;
                            setState(() {});
                            widget.update
                                ? BlocProvider.of<TaskBloc>(context).add(UpdatePaymentEvent(
                                    isActive: true,
                                    discription: discriptionController.text,
                                    taskId: paymentRead?.taskId,
                                    budget: double.tryParse(budgetController.text) ??
                                        0.0,
                                    expense:
                                        double.tryParse(expenceController.text) ??
                                            0.0,
                                    notas: notesController.text,
                                    jobId: paymentRead?.jobId,
                                    AssigningCode: widget.assignCode ?? "",
                                    assigningType: widget.assignType ?? "",
                                    payId: paymentRead?.id,
                                    img1: picModelPayment[0].data ??
                                        picModelPayment[0].url,
                                    img5: picModelPayment[4].data ??
                                        picModelPayment[4].url,
                                    img4: picModelPayment[3].data ??
                                        picModelPayment[3].url,
                                    img3: picModelPayment[2].data ??
                                        picModelPayment[2].url,
                                    img2: picModelPayment[1].data ??
                                        picModelPayment[1].url))
                                : BlocProvider.of<TaskBloc>(context).add(
                                    CreatePaymentEvent(
                                        discription: discriptionController.text,
                                        taskId: widget.taskId,
                                        budget:
                                            double.tryParse(budgetController.text) ??
                                                0.0,
                                        expense: double.tryParse(expenceController.text) ?? 0.0,
                                        notas: notesController.text,
                                        jobId: widget.jobId,
                                        AssigningCode: widget.assignCode ?? "",
                                        assigningType: widget.assignType ?? "",
                                        img1: picModelPayment[0].data ?? 0,
                                        img5: picModelPayment[4].data ?? 0,
                                        img4: picModelPayment[3].data ?? 0,
                                        img3: picModelPayment[2].data ?? 0,
                                        img2: picModelPayment[1].data ?? 0));
                          },
                          child: Container(
                            // width: 110,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorPalette.primary,
                            ),
                            alignment: Alignment.center,
                            child: buttonLoad == true
                                ? SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 15.0,
                                  )
                                : Text(
                                    widget.update ? "Update" : "Create",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: w / 22,
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // widget.isJob
                      //     ? Container()
                      //     : widget.isTask
                      //         ? Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               widget.update
                      //                   ? Container()
                      //                   : Text(
                      //                       "Assigning Type",
                      //                       style: GoogleFonts.roboto(
                      //                         color: Colors.black,
                      //                         fontSize: w / 24,
                      //                         fontWeight: FontWeight.w500,
                      //                       ),
                      //                     ),
                      //               widget.update
                      //                   ? Container()
                      //                   : SizedBox(
                      //                       height: 10,
                      //                     ),
                      //               widget.update
                      //                   ? ReadDropDownCard(
                      //                       label: "Assigning Type",
                      //                       selValue:
                      //                           paymentRead?.assigningType ??
                      //                               "",
                      //                     )
                      //                   : Container(
                      //                       width: w / 1,
                      //                       // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //                       //height: 20.0,
                      //                       padding: EdgeInsets.symmetric(
                      //                           horizontal: 12.0),
                      //                       decoration: BoxDecoration(
                      //                         borderRadius:
                      //                             BorderRadius.circular(4),
                      //                         border: Border.all(
                      //                             color: Colors.grey
                      //                                 .withOpacity(0.2),
                      //                             width: 1),
                      //                       ),
                      //                       child: DropdownButton(
                      //                           isExpanded: true,
                      //                           dropdownColor: Colors.white,
                      //                           icon: Icon(Icons
                      //                               .keyboard_arrow_down_outlined),
                      //                           underline: Container(),
                      //                           items: assignTypeList
                      //                               .map((String items) {
                      //                             return DropdownMenuItem(
                      //                               enabled: true,
                      //                               value: items,
                      //                               child: Text(items,
                      //                                   style: TextStyle(
                      //                                       color:
                      //                                           Colors.black)),
                      //                             );
                      //                           }).toList(),
                      //                           value: selectedType,
                      //                           onChanged: (dynamic value) {
                      //                             setState(() {
                      //                               selectedType = value;
                      //                               selectedType == "Individual"
                      //                                   ? context
                      //                                       .read<JobBloc>()
                      //                                       .add(
                      //                                           GetEmployeeListEvent(
                      //                                               '', '', ''))
                      //                                   : selectedType ==
                      //                                           "Task_Group"
                      //                                       ? context
                      //                                           .read<JobBloc>()
                      //                                           .add(
                      //                                               GetGroupListEvent())
                      //                                       : null;
                      //                             });
                      //                           },
                      //                           hint: Text(
                      //                             "Assign Type",
                      //                             style: GoogleFonts.poppins(
                      //                                 color: Colors.grey,
                      //                                 fontSize: 14),
                      //                           )),
                      //                     ),
                      //               SizedBox(
                      //                 height: 10,
                      //               ),
                      //               widget.update
                      //                   ? ReadDropDownCard(
                      //                       label: "Assigning Code",
                      //                       selValue:
                      //                           paymentRead?.assigningName ??
                      //                               "",
                      //                     )
                      //                   : selectedType == "Task_Group"
                      //                       ? DropDownCard(
                      //                           label: "Assigning Name",
                      //                           selValue: selName,
                      //                           onTap: () {
                      //                             context
                      //                                 .read<JobBloc>()
                      //                                 .add(GetGroupListEvent());
                      //                             _showModalBottomGroupList();
                      //                           },
                      //                         )
                      //                       : selectedType == "Individual"
                      //                           ? DropDownCard(
                      //                               label: "Assigning Name",
                      //                               selValue: selName,
                      //                               onTap: () {
                      //                                 context.read<JobBloc>().add(
                      //                                     GetEmployeeListEvent(
                      //                                         '', '', ''));
                      //                                 _showModalBottomAdditionalRole();
                      //                               },
                      //                             )
                      //                           : Container(),
                      //             ],
                      //           )
                      //         : Container(),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: w,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                                // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                                child: TextFormField(
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600),
                              onChanged: (l) {
                                validationCheck();
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 16, right: 16),
                                hintText: "Enter Budget",
                                hintStyle: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none,
                                // suffixIcon: Text("INR"),
                                suffixText: widget.currencyCode ?? "",
                              ),
                              // enabled: false,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: budgetController,
                            )),
                            Divider(
                              indent: 16,
                            ),
                            Container(
                                // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                                child: TextFormField(
                              controller: discriptionController,
                              maxLines: 4,
                              minLines: 1,
                              onChanged: (l) {
                                validationCheck();
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 16, top: 10, right: 16, bottom: 16),
                                hintText: "Enter Description",
                                hintStyle: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none,
                              ),
                            )),
                            Divider(
                              indent: 16,
                            ),
                            Container(
                                // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                                child: TextFormField(
                              controller: notesController,
                              maxLines: 4,
                              minLines: 1,
                              onChanged: (l) {
                                validationCheck();
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 16, top: 10, right: 16, bottom: 16),
                                hintText: "Add Notes(Optional)",
                                hintStyle: TextStyle(
                                  color: Color(0x66151522),
                                  fontSize: w / 26,
                                ),
                                border: InputBorder.none,
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 26),
                      count >= 5
                          ? Container()
                          : TextButton(
                              child: Text(
                                " + Add Attachment",
                                style: GoogleFonts.roboto(
                                    color: ColorPalette.primary,
                                    fontSize: w / 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                getCoverImage(ImageSource.gallery);
                                isCatalogue = false;
                                isValid = true;
                                indexImage = count++;
                                setState(() {});
                              },
                            ),
                      if (picModelPayment.isNotEmpty) ...[
                        for (var i = 0; i < count; i++) ...{
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    isCatalogue = false;
                                    indexImage = i;
                                    isValid = true;
                                    setState(() {});
                                    getCoverImage(ImageSource.gallery);
                                  },
                                  child: picModelPayment[i].url == null
                                      ? Container(
                                          height: 120,
                                          width: w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            color: Color(0xffD9D9D9)
                                                .withOpacity(0.25),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                size: 30,
                                                color: ColorPalette.primary,
                                              ),
                                              Text(
                                                "Upload Image",
                                                style: GoogleFonts.roboto(
                                                    color: ColorPalette.primary,
                                                    fontSize: w / 26,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 120,
                                          width: w,
                                          color: Colors.white,
                                          child: Image.network(
                                            picModelPayment[i].url ?? "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                                picModelPayment[i].url == null
                                    ? Text("")
                                    : Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            picModelPayment[i].url == "";
                                            clearDataAtIndex(i);
                                            isValid = true;
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 40,
                                            color: Color(0xffD9D9D9),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: SvgPicture.string(
                                                  TaskSvg().deleteBox,
                                                  color: ColorPalette.primary,
                                                  height: 18,
                                                  width: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                picModelPayment[i].url == null
                                    ? Text("")
                                    : Positioned(
                                        bottom: 13,
                                        left: 10,
                                        child: SizedBox(
                                          width: w / 1.6,
                                          child: Text(
                                              picModelPayment[i]
                                                      .url
                                                      ?.split("/")[5] ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                        )),
                              ],
                            ),
                          )
                        },
                      ],
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
      final pickedFile =
          await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        // BlocProvider.of<DiscountBloc>(context)
        //     .add(PostImageDiscountEvent(cropImage!));
        BlocProvider.of<EmployeeBloc>(context)
            .add(PostImageAllEvent(cropImage!));
        imageFileName = cropImage?.path.split("_")[1];
        print("cropppp$imageFileName");
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _showModalBottomAdditionalRole() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select From List",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        SizedBox(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BlocBuilder<JobBloc, JobState>(
                                            builder: (context, state) {
                                              if (state
                                                  is GetEmployeeListLoading) {
                                                return LottieLoader();
                                              }
                                              if (state
                                                  is GetEmployeeListSuccess) {
                                                return Container(
                                                  width: w,
                                                  // height: h / 2.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x05000000),
                                                        blurRadius: 8,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: ListView.separated(
                                                      primary: true,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context,
                                                              index) =>
                                                          GestureDetector(
                                                              onTap: () {
                                                                selCode = state
                                                                        .assignMeList?[
                                                                            index]
                                                                        .userCode ??
                                                                    "";
                                                                selName = state
                                                                        .assignMeList?[
                                                                            index]
                                                                        .fname ??
                                                                    "";
                                                                refresh();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: EmployeeCard(
                                                                  employeeList:
                                                                      state.assignMeList?[
                                                                          index])),
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                      itemCount: state
                                                          .assignMeList!
                                                          .length),
                                                );
                                              }
                                              return Container();
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  _showModalBottomGroupList() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: h / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h / 180,
                        ),
                        Container(
                          width: w / 5.3,
                          height: h / 160,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        Text(
                          "Select From List",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: h / 40,
                        ),
                        SizedBox(
                          height: h / 1.5,
                          child: ScrollConfiguration(
                            behavior: NoGlow(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BlocBuilder<JobBloc, JobState>(
                                            builder: (context, state) {
                                              print("your state$state");
                                              if (state
                                                  is GetGroupListLoading) {
                                                return LottieLoader();
                                              }
                                              if (state is GetGroupListSuccess) {
                                                print("list ****${state.groupList.length}");
                                                return Container(
                                                  width: w,
                                                  // height: h / 2.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    // border: Border.all(
                                                    //   color: Color(0xffe6ecf0),
                                                    //   width: 1,
                                                    // ),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x05000000),
                                                        blurRadius: 8,
                                                        offset: Offset(1, 1),
                                                      ),
                                                    ],
                                                    color: Colors.white,
                                                  ),
                                                  child: ListView.separated(
                                                      primary: true,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              GestureDetector(
                                                                onTap: () {
                                                                  selCode =
                                                                      state.groupList?[index]
                                                                              .groupCode ??
                                                                          "";
                                                                  selName =
                                                                      state.groupList?[index]
                                                                              .gName ??
                                                                          "";
                                                                  refresh();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0xffe6ecf0),
                                                                      width: 1,
                                                                    ),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(
                                                                            0x05000000),
                                                                        blurRadius:
                                                                            8,
                                                                        offset: Offset(
                                                                            1,
                                                                            1),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            16,
                                                                        right:
                                                                            16,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            TextAvatar(
                                                                              textColor: Colors.white,
                                                                              size: 40,
                                                                              fontSize: w / 22,
                                                                              shape: Shape.Circular,
                                                                              text: "${state.groupList?[index].gName![0].toUpperCase()} ",
                                                                              numberLetters: 2,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 14,
                                                                            ),
                                                                            Text(
                                                                              state.groupList?[index].gName ?? "",
                                                                              style: TextStyle(
                                                                                color: ColorPalette.black,
                                                                                fontSize: w / 24,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        //
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                      itemCount: state.groupList.length),
                                                );
                                              }

                                              return Text("data");
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                    //     child: GradientButton(
                    //         color: ColorPalette.primary,
                    //         onPressed: () {
                    //           // refresh();
                    //           Navigator.pop(context);
                    //         },
                    //         gradient: const LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               ColorPalette.primary,
                    //               ColorPalette.primary
                    //             ]),
                    //         child: Text(
                    //           "Update List",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.roboto(
                    //             color: Colors.white,
                    //             fontSize: w / 22,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         )),
                    //   ),
                    // )
                  ],
                ),
              );
            },
          );
        });
  }
}
