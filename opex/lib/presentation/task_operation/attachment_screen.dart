import 'dart:io';
import 'package:animated_icon/animated_icon.dart';
import 'package:cluster/presentation/task_operation/lottieLoader.dart';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:cluster/presentation/task_operation/task_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/color_palatte.dart';
import '../../core/common_snackBar.dart';
import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../inventory/inventory_new_list.dart';
import '../inventory/new_list_tab/profiling_tab.dart';
import 'create/add_text.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_bloc/employee_bloc.dart';

class AttachmentScreen extends StatefulWidget {
  GetTaskList? readData;
   AttachmentScreen({Key? key, this.readData}) : super(key: key);

  @override
  State<AttachmentScreen> createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController discription = TextEditingController();
  TextEditingController notes = TextEditingController();
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl = '';
  String? imageFileName;

  int indexImage = 0;
  int catindexImage = 0;
  bool isCatalogue = false;
  List<PicModel> picModelAttachment = [];
  int count = 0;
  bool loader = true;
  @override
  void initState() {
    context
        .read<TaskBloc>()
        .add(GetTaskReadListEvent(widget.readData?.id ?? 0));
    // Duration delayDuration = Duration(seconds: 2);
    // Future.delayed(delayDuration, () {
    //   // Change the boolean value after the delay
    //   loader = false;
    //
    //   // Print the updated value
    //   print('Updated bool value: $loader');
    //   setState(() {});
    // });
    picModelAttachment.clear();
    for (int i = 0; i < 5; i++) {
      picModelAttachment.add(PicModel(data: null, url: null));
    }
    readAttach();
    print("that count$count");
    super.initState();
  }



  bool? isValid = false;
  validationCheck() {
    if (discription.text != "" && notes.text != '') {
      isValid = true;
    } else {
      isValid = false;
    }
  }

  void handleSave(int tabIndex, dynamic data) {
    print('Saving data for tab $tabIndex with data: $data');
    // Implement your save logic here
  }

  readAttach() {
    print("vvvvv${widget.readData?.metaData?.description}");
    discription.text = widget.readData?.metaData?.description ?? "";
    notes.text = widget.readData?.metaData?.note ?? "";
    picModelAttachment
        .setAll(0, [PicModel(url: widget.readData?.metaData?.image1 ?? null)]);
    picModelAttachment
        .setAll(1, [PicModel(url: widget.readData?.metaData?.image2 ?? null)]);
    picModelAttachment
        .setAll(2, [PicModel(url: widget.readData?.metaData?.image3 ?? null)]);
    picModelAttachment
        .setAll(3, [PicModel(url: widget.readData?.metaData?.image4 ?? null)]);
    picModelAttachment
        .setAll(4, [PicModel(url: widget.readData?.metaData?.image5 ?? null)]);
    widget.readData?.imgCount == 0
        ? count = 0
        : count = picModelAttachment.length;
    // loader = false;
    setState(() {});
  }

  void clearDataAtIndex(int index) {
    if (index >= 0 && index < picModelAttachment.length) {
      picModelAttachment[index] = PicModel(data: null, url: null);
    }
    setState(() {});
  }

  bool buttonLoad = false;
  List<String> fileType = ["Open Camera", "Image", "Document", "Video File"];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(60),
        //   child:  BackAppBar(
        //     label: "Notes & Attachments",
        //     isAction: false,
        //     isBack: false,
        //     onTap: (){
        //
        //       Navigator.pop(context);
        //     },
        //     action: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         isValid == false
        //             ? GestureDetector(
        //           onTap: () {},
        //           child: Container(
        //             // width: 110,
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: 16, vertical: 8),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               color: Color(0xffd3d3d3),
        //             ),
        //             alignment: Alignment.center,
        //             child: Text(
        //               "Add",
        //               textAlign: TextAlign.center,
        //               style: GoogleFonts.roboto(
        //                 color: Colors.white,
        //                 fontSize: w/22,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         )
        //             : GestureDetector(
        //           onTap: () {
        //             HapticFeedback.heavyImpact();
        //             buttonLoad=true;
        //             setState(() {
        //
        //             });
        //             BlocProvider.of<TaskBloc>(context)
        //                 .add(UpdateReportingTaskEvent(
        //               durationOption: widget.readData?.duration??"",
        //               latitude: widget.readData?.latitude ?? "",
        //               longitude: widget.readData?.longitude ?? "",
        //               img5: picModelAttachment[4].url,
        //               img1: picModelAttachment[0].url,
        //               img4: picModelAttachment[3].url,
        //               img2: picModelAttachment[1].url,
        //               img3: picModelAttachment[2].url,
        //               attachmentDescription: discription.text,
        //               attachmentNote: notes.text,
        //               id: widget.readData?.id ?? 0,
        //               AssigningCode:
        //               widget.readData?.assigningCode ?? "",
        //               AssigningType:
        //               widget.readData?.assigningType ?? "",
        //               createdOn:
        //               "${widget.readData?.createdOn?.split("T")[0]}"
        //                   " "
        //                   "${widget.readData?.createdOn?.split("T")[1].split("+")[0]}",
        //               jobid: widget.readData?.jobId,
        //               notas: widget.readData?.notes ?? "",
        //               priorityLeval: 0,
        //               remarks: widget.readData?.remarks ?? "",
        //               taskName: widget.readData?.taskName ?? "",
        //               taskType: widget.readData?.taskType ?? 0,
        //               lastmodified: null,
        //               parant: widget.readData?.parent ?? null,
        //               statusStagesId: widget.readData?.statusStagesId,
        //               discription: widget.readData?.description ?? "",
        //               createdBy:
        //               widget.readData?.createdPersonCode ?? "",
        //               isActive: true,
        //               priority: widget.readData?.priority ?? "",
        //               reportingPerson:
        //               widget.readData?.reportingPersonCode ?? "",
        //               endDate: "${widget.readData?.endDate?.split("T")[0]}",
        //               endTime: "${widget.readData?.endDate?.split("T")[1].split("+")[0]}",
        //               startDate:
        //               "${widget.readData?.startDate?.split("T")[0]}",
        //               startTime:  "${widget.readData?.startDate?.split("T")[1].split("+")[0]}"
        //             ));
        //           },
        //           child: Container(
        //             // width: 110,
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: 16, vertical: 8),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               color: ColorPalette.primary,
        //             ),
        //             alignment: Alignment.center,
        //             child: buttonLoad==true?SpinKitThreeBounce(
        //               color: Colors.white,
        //               size: 15.0,
        //             ):Text(
        //               "Add",
        //               textAlign: TextAlign.center,
        //               style: GoogleFonts.roboto(
        //                 color: Colors.white,
        //                 fontSize: w/22,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        floatingActionButton: isValid == false
            ? GestureDetector(
                onTap: () {},
                child: Container(
                  height: 45,
                  width: w1,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffd3d3d3),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
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
                  BlocProvider.of<TaskBloc>(context).add(
                      UpdateReportingTaskEvent(
                          durationOption: widget.readData?.duration ?? "",
                          latitude: widget.readData?.latitude ?? "",
                          longitude: widget.readData?.longitude ?? "",
                          img5: picModelAttachment[4].url,
                          img1: picModelAttachment[0].url,
                          img4: picModelAttachment[3].url,
                          img2: picModelAttachment[1].url,
                          img3: picModelAttachment[2].url,
                          attachmentDescription: discription.text,
                          attachmentNote: notes.text,
                          id: widget.readData?.id ?? 0,
                          AssigningCode: widget.readData?.assigningCode ?? "",
                          AssigningType: widget.readData?.assigningType ?? "",
                          createdOn:
                              "${widget.readData?.createdOn?.split("T")[0]}"
                              " "
                              "${widget.readData?.createdOn?.split("T")[1].split("+")[0]}",
                          jobid: widget.readData?.jobId,
                          notas: widget.readData?.notes ?? "",
                          priorityLeval: 0,
                          remarks: widget.readData?.remarks ?? "",
                          taskName: widget.readData?.taskName ?? "",
                          taskType: widget.readData?.taskType ?? 0,
                          lastmodified: null,
                          parant: widget.readData?.parent ?? null,
                          statusStagesId: widget.readData?.statusStagesId,
                          discription: widget.readData?.description ?? "",
                          createdBy: widget.readData?.createdPersonCode ?? "",
                          isActive: true,
                          priority: widget.readData?.priority ?? "",
                          reportingPerson:
                              widget.readData?.reportingPersonCode ?? "",
                          endDate:
                              "${widget.readData?.endDate?.split("T")[0]}",
                          endTime:
                              "${widget.readData?.endDate?.split("T")[1].split("+")[0]}",
                          startDate:
                              "${widget.readData?.startDate?.split("T")[0]}",
                          startTime:
                              "${widget.readData?.startDate?.split("T")[1].split("+")[0]}"));
                },
                child: Container(
                  height: 45,
                  width: w1,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorPalette.primary,
                  ),
                  alignment: Alignment.center,
                  child: buttonLoad == true
                      ? SpinKitThreeBounce(
                          color: Colors.white,
                          size: 15.0,
                        )
                      : Text(
                          "Save",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: w / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: MultiBlocListener(
          listeners: [
            BlocListener<EmployeeBloc, EmployeeState>(
              listener: (context, state) {
                if (state is PicSuccess) {
                  print("Inside Success${state.data}\t${state.url}");
                  setState(() {
                    isCatalogue
                        ? catalogueList.replaceRange(indexImage, indexImage + 1,
                            [PicModel(data: state.data, url: state.url)])
                        : picModelAttachment.replaceRange(
                            indexImage,
                            indexImage + 1,
                            [PicModel(data: state.data, url: state.url)]);
                  });
                  print("pic model length${picModelAttachment.length}");
                }
              },
            ),
            BlocListener<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is GetTaskReadSuccess) {
                widget.readData=state.getTaskRead;
                readAttach();
                loader = false;
                setState(() {

                });
                }
              },
            ),
            BlocListener<TaskBloc, TaskState>(
              listener: (context, state) {

                if (state is UpdateReportingFailed) {
                  buttonLoad = false;
                  showSnackBar(
                    context,
                    message: state.error,
                    color: Colors.red,
                    // icon: Icons.admin_panel_settings_outlined
                  );
                  setState(() {});
                }
                if (state is UpdateReportingSuccess) {
                  buttonLoad = false;
                  isValid=false;
                  print("attachment success ");
                  Fluttertoast.showToast(
                      msg: state.taskId,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white);
                  // context
                  //     .read<TaskBloc>()
                  //     .add(GetTaskReadListEvent(widget.readData?.id ?? 0));
                  setState(() {

                  });
                  // Navigator.pop(context);
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: SafeArea(
                child: loader == true
                    ? LottieLoader()
                    : Column(
                        children: [
                          Container(
                            width: w,
                            margin: EdgeInsets.all(15),
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
                                    hintText: "Enter Remarks",
                                    hintStyle: TextStyle(
                                      color: Color(0x66151522),
                                      fontSize: w / 26,
                                    ),
                                    border: InputBorder.none,
                                    // suffixIcon: Text("INR"),
                                  ),
                                  // enabled: false,
                                  // keyboardType: TextInputType.number,
                                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                                  controller: discription,
                                )),
                                Divider(
                                  indent: 16,
                                ),
                                Container(
                                    // padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 10),
                                    child: TextFormField(
                                  controller: notes,
                                  maxLines: 4,
                                  minLines: 1,
                                  onChanged: (l) {
                                    validationCheck();
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 16,
                                        top: 10,
                                        right: 16,
                                        bottom: 16),
                                    hintText: "Add Notes",
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
                          Container(
                            width: w,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                count >= 5
                                    ? Container()
                                    : TextButton(
                                        child: Text(
                                          " + Add Attachment",
                                          style: GoogleFonts.roboto(
                                              color: ColorPalette.primary,
                                              fontSize: w / 26,
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
                                if (picModelAttachment.isNotEmpty) ...[
                                  for (var i = 0; i < count; i++) ...{
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              isCatalogue = false;
                                              indexImage = i;
                                              isValid = true;
                                              setState(() {});
                                              getCoverImage(
                                                  ImageSource.gallery);
                                            },
                                            child: picModelAttachment[i].url ==
                                                    null
                                                ? Container(
                                                    height: 120,
                                                    width: w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xffe6ecf0),
                                                        width: 1,
                                                      ),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x05000000),
                                                          blurRadius: 8,
                                                          offset: Offset(1, 1),
                                                        ),
                                                      ],
                                                      color: Color(0xffD9D9D9)
                                                          .withOpacity(0.25),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: ColorPalette
                                                              .primary,
                                                        ),
                                                        Text(
                                                          "Upload Image",
                                                          style: GoogleFonts.roboto(
                                                              color:
                                                                  ColorPalette
                                                                      .primary,
                                                              fontSize: w / 26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    height: 120,
                                                    width: w,
                                                    color: Colors.white,
                                                    child: Image.network(
                                                      picModelAttachment[i]
                                                              .url ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                          ),
                                          picModelAttachment[i].url == null
                                              ? Text("")
                                              : Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      picModelAttachment[i]
                                                              .url ==
                                                          "";
                                                      clearDataAtIndex(i);
                                                      isValid = true;
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      color: Color(0xffD9D9D9),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child:
                                                              SvgPicture.string(
                                                            TaskSvg().deleteBox,
                                                            color: ColorPalette
                                                                .primary,
                                                            height: 18,
                                                            width: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                          picModelAttachment[i].url == null
                                              ? Text("")
                                              : Positioned(
                                                  bottom: 13,
                                                  left: 10,
                                                  child: SizedBox(
                                                    width: w / 1.6,
                                                    child: Text(
                                                        picModelAttachment[i]
                                                                .url
                                                                ?.split(
                                                                    "/")[5] ??
                                                            "",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )),
                                        ],
                                      ),
                                    )

                                    // GestureDetector(
                                    //   onTap: () {
                                    //     isCatalogue = false;
                                    //     indexImage = i;
                                    //     isValid = true;
                                    //     setState(() {});
                                    //     getCoverImage(ImageSource.gallery);
                                    //   },
                                    //   child: Container(
                                    //       width: 88,
                                    //       height: 100,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(5),
                                    //         border: Border.all(
                                    //           color: Color(0xffe6ecf0),
                                    //           width: 1,
                                    //         ),
                                    //         boxShadow: const [
                                    //           BoxShadow(
                                    //             color: Color(0x05000000),
                                    //             blurRadius: 8,
                                    //             offset: Offset(1, 1),
                                    //           ),
                                    //         ],
                                    //         color: Colors.white,
                                    //       ),
                                    //       child: const Icon(Icons.add,
                                    //           color: Color(0x7f666161))),
                                    // ),
                                  },
                                ],
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      )),
          ),
        ));
  }

  Future<void> getCoverImage(source) async {
    try {
      final pickedFile =
          await picker.pickImage(source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
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
}
