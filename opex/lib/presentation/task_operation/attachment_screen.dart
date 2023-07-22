

import 'dart:io';
import 'package:cluster/presentation/task_operation/task_operation_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/color_palatte.dart';
import '../../core/common_snackBar.dart';
import '../inventory/inventory_new_list.dart';
import '../inventory/new_list_tab/profiling_tab.dart';
import 'create/add_text.dart';
import 'create/model/task_models.dart';
import 'create/task_bloc/task_bloc.dart';
import 'employee_bloc/employee_bloc.dart';


class AttachmentScreen extends StatefulWidget {
  final GetTaskList? readData;
  const AttachmentScreen({Key? key, this.readData}) : super(key: key);

  @override
  State<AttachmentScreen> createState() => _AttachmentScreenState();
}

class _AttachmentScreenState extends State<AttachmentScreen> {
  TextEditingController discription=TextEditingController();
  TextEditingController notes=TextEditingController();
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl='';
  String? imageFileName;

  int indexImage=0;
  int catindexImage=0;
  bool isCatalogue=false;
  List<PicModel> picModelAttachment = [];
  @override
  void initState() {
    picModelAttachment.clear();
    for(int i=0;i<5;i++) {
      picModelAttachment.add(PicModel(data: null,url: ""));
    }
    readAttach();
    super.initState();
  }
  bool? isValid=false;
  validationCheck(){
    if(discription.text!=""&&notes.text!=''){
      isValid=true;
    }
    else{
      isValid=false;
    }
  }
  readAttach(){
    print("vvvvv${widget.readData?.metaData?.description}");
    discription.text=widget.readData?.metaData?.description??"";
    notes.text=widget.readData?.metaData?.note??"";
    picModelAttachment.setAll(0, [
      PicModel(
          url: widget.readData?.metaData?.image1 ??
              "")
    ]);
    picModelAttachment.setAll(1, [
      PicModel(
          url: widget.readData?.metaData?.image2 ??
              "")
    ]);
    picModelAttachment.setAll(2, [
      PicModel(
          url: widget.readData?.metaData?.image3 ??
              "")
    ]);
    picModelAttachment.setAll(3, [
      PicModel(
          url: widget.readData?.metaData?.image4 ??
              "")
    ]);
    picModelAttachment.setAll(4, [
      PicModel(
          url: widget.readData?.metaData?.image5 ??
              "")
    ]);
    setState(() {

    });
  }



  List<String>fileType=["Open Camera","Image","Document","Video File"];
  @override
  Widget build(BuildContext context) {

    var w=MediaQuery.of(context).size.width;
    return Scaffold(
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
        body:MultiBlocListener(
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
                [PicModel(data: state.data,url: state.url)]):picModelAttachment.replaceRange(indexImage, indexImage+1,
                [PicModel(data: state.data,url: state.url)]);
          });
          print("pic model length${picModelAttachment.length}");

        }
      },
    ),
    BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is UpdateReportingTaskLoading) {
          print("task loading");
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
        }

        if (state is UpdateReportingFailed) {
          showSnackBar(
            context,
            message: state.error,
            color: Colors.red,
            // icon: Icons.admin_panel_settings_outlined
          );
        }
        if (state is UpdateReportingSuccess) {
          print("attachment success ");
          Fluttertoast.showToast(
              msg: state.taskId,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.black);
          context.read<TaskBloc>().add(
              GetTaskReadListEvent(widget.readData?.id??0));
          Navigator.pop(context);
        }
      },
    ),
  ],
  child: SingleChildScrollView(
          child: SafeArea(child:
          Column(
            children: [
              TaskAndOperationAppBar(
                label: "Attachment",
                EndIcon: isValid==false?GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    // width: 110,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffd3d3d3),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Add",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ):GestureDetector(
                  onTap: (){
                    BlocProvider.of<TaskBloc>(context).add(
                        UpdateReportingTaskEvent(
                          latitude: widget?.readData?.latitude??"",
                          longitude: widget?.readData?.longitude??"",
                          img5: picModelAttachment[4].url,
                          img1: picModelAttachment[0].url,
                          img4: picModelAttachment[3].url,
                          img2: picModelAttachment[1].url,
                          img3: picModelAttachment[2].url,
                          attachmentDescription: discription.text,
                          attachmentNote: notes.text,
                          id: widget.readData?.id??0,
                          AssigningCode: widget.readData?.assigningCode??"",
                          AssigningType: widget.readData?.assigningType??"",
                          createdOn: "${widget.readData?.createdOn?.split("T")[0]}"" ""${widget.readData?.createdOn?.split("T")[1].split("+")[0]}",
                          jobid: widget.readData?.jobId,
                          notas: widget.readData?.notes??"",
                          priorityLeval: "1",
                          remarks: widget.readData?.remarks??"",
                          taskName: widget.readData?.taskName??"",
                          taskType: widget.readData?.taskType??0,
                          lastmodified: null,
                          parant: widget.readData?.parent??null,
                          statusStagesId: null,
                          discription:widget.readData?.description??"",
                          createdBy: widget.readData?.createdPersonCode??"",
                          isActive: true,
                          priority: widget.readData?.priority??"",
                          reportingPerson: widget.readData?.reportingPersonCode??"",
                          endDate: "${widget.readData?.endDate?.split("T")[0]}"" ""${widget.readData?.endDate?.split("T")[1].split("+")[0]}"??"",
                          startDate: "${widget.readData?.startDate?.split("T")[0]}"" ""${widget.readData?.startDate?.split("T")[1].split("+")[0]}"??"",
                        ));
                    // Navigator.pop(context);
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
                      "Add",
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

                    Container(
                      width: w,
                      height: 145,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      child: TextFormField(
                        controller: discription,
                        onChanged: (l){
                          validationCheck();
                          setState(() {

                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: "Description",
                          hintStyle:  TextStyle(
                            color: Color(0xff939393),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
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
                      child: AddText(label: "Add Notes",controller: notes,isActive: true,
                      onchange:  (l){
                        validationCheck();
                        setState(() {

                        });
                      },),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                                  isValid=true;
                                  setState(() {

                                  });
                                  getCoverImage(ImageSource.gallery);
                                },
                                child:
                                picModelAttachment[i].url!=""&&picModelAttachment[i].url!.isNotEmpty?
                                Container(
                                    width: 88,
                                    height: 100,
                                    decoration:BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(picModelAttachment[i].url.toString()),fit: BoxFit.fill
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
                    SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          )),
        ),
)
    );
  }

  // _showModalBottomSheet() {
  //   final TextEditingController groupName = TextEditingController();
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
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
  //               width: double.infinity,
  //               decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(10),
  //                     topLeft: Radius.circular(10),
  //                   )),
  //               alignment: Alignment.center,
  //               child: Column(
  //                 children: [
  //               // Padding(
  //               // padding: const EdgeInsets.only(top: 20.0),
  //               // child: DropdownButton<FileType>(
  //               //     hint: const Text('LOAD PATH FROM'),
  //               //     value: _pickingType,
  //               //     items: FileType.values
  //               //         .map((fileType) => DropdownMenuItem<FileType>(
  //               //       child: Text(fileType.toString()),
  //               //       value: fileType,
  //               //     ))
  //               //         .toList(),
  //               //     onChanged: (value) => setState(() {
  //               //       value!;
  //               //       if (_pickingType != FileType.custom) {
  //               //         _controller.text = _extension = '';
  //               //       }
  //               //     }))),
  //                   Text(
  //                     "Select File Type",
  //                     style: GoogleFonts.roboto(
  //                       color: Colors.black,
  //                       fontSize: w/18,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   SizedBox(height: 10,),
  //                   ListView.separated(
  //                       physics: NeverScrollableScrollPhysics(),
  //                       shrinkWrap: true,
  //                       itemBuilder: (context, index) => Container(
  //                         padding: EdgeInsets.all(10),
  //                         child: InkWell(
  //
  //                             onTap: () => _pickFiles(),
  //
  //                           child: Row(
  //                             children: [
  //                               Container(
  //                                 width: 32,
  //                                 height: 32,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(22),
  //                                   color: Color(0xff33c658),
  //                                 ),
  //                               ),
  //                               SizedBox(width: 10,),
  //                               GestureDetector(
  //                                 onTap: (){
  //                                   print("SHIFAS");
  //                                   fileType[index]=="Open Camera"?
  //                                   getImage(
  //                                       ImageSource.camera):
  //                                   fileType[index]=="Image"?
  //                                   getImage(
  //                                       ImageSource.gallery):
  //                                   fileType[index]=="Document"?
  //                                   _pickingType= FileType.media:
  //                                   fileType[index]=="Video File"?
  //                                   _pickingType= FileType.video:
  //                                       Container();
  //                                   fileType[index]=="Open Camera"?null:_pickFiles();
  //
  //                                 },
  //                                 child: Text(
  //                                   fileType[index],
  //                                   style: GoogleFonts.roboto(
  //                                     color: Colors.black,
  //                                     fontSize: 18,
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       separatorBuilder: (context, index) => Divider(),
  //                       itemCount: fileType.length)
  //
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }

  Future<void> getCoverImage(source) async {
    try {
      final pickedFile = await picker.pickImage(
          source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {

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