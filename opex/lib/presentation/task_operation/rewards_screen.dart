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
import '../inventory/inventory_new_list.dart';
import '../inventory/new_list_tab/profiling_tab.dart';
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
   ReadRewards? rewadsRead;
  @override
  Widget build(BuildContext context) {
    print("Inside Loading${widget.type}");
    print("Inside Loading${widget.typeId}");

    var w =MediaQuery.of(context).size.width;
    var h =MediaQuery.of(context).size.height;
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
        if(state is GetReadRewadsLoading){

        }
        if(state is GetReadRewadsSuccess){

          rewadsRead=state.readRewards;
          rewardName.text=rewadsRead?.name??"";
          discription.text=rewadsRead?.description??"";
          notes.text=rewadsRead?.notes??"";
          picModel.setAll(0, [
            PicModel(
                url: rewadsRead?.rewardsMeta?.image1 ??
                    "")
          ]);
          picModel.setAll(1, [
            PicModel(
                url: rewadsRead?.rewardsMeta?.image2 ??
                    "")
          ]);
          picModel.setAll(2, [
            PicModel(
                url: rewadsRead?.rewardsMeta?.image3 ??
                    "")
          ]);
          picModel.setAll(3, [
            PicModel(
                url: rewadsRead?.rewardsMeta?.image4 ??
                    "")
          ]);
          picModel.setAll(4, [
            PicModel(
                url: rewadsRead?.rewardsMeta?.image5 ??
                    "")
          ]);
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
                        img1: picModel[0].data??picModel[0].url,
                        img5: picModel[4].data??picModel[4].url,
                        img4: picModel[3].data??picModel[3].url,
                        img3: picModel[2].data??picModel[2].url,
                        img2: picModel[1].data??picModel[1].url,
                        notes: notes.text??"",
                        discription: discription.text??"",
                        name: rewardName.text??""
                    )):BlocProvider.of<TaskBloc>(context)
                        .add(CreateRewardTaskEvent(
                      typeId: widget.typeId,
                      type: widget.type,
                      notes: notes.text??"",
                      discription: discription.text??"",
                      name: rewardName.text??"",
                      img2: picModel[1].data??0,
                      img3:picModel[2].data??0 ,
                      img4: picModel[3].data??0,
                      img5: picModel[4].data??0,
                      img1: picModel[0].data??0
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
                                            image: NetworkImage("${picModel[i].url.toString()}"),fit: BoxFit.fill
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
