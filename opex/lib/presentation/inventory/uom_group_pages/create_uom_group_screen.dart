import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../../promotion_app/blocs/discount_bloc/discount_bloc.dart';
import '../../promotion_app/dropdown_card.dart';
import '../../promotion_app/widget/file_upload_card.dart';
import '../bloc/inventory_bloc.dart';
import '../model/division_model.dart';

class CreateUomGroupScreen extends StatefulWidget {
  final bool? edit;
  const CreateUomGroupScreen({Key? key, this.edit}) : super(key: key);

  @override
  State<CreateUomGroupScreen> createState() => _CreateUomGroupScreenState();
}

class _CreateUomGroupScreenState extends State<CreateUomGroupScreen> {
  bool isActive = true;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic? imageId;
  String imgUrl='';
  String? imageFileName;
  TextEditingController nameController=TextEditingController();
  TextEditingController altNameController=TextEditingController();
  TextEditingController searchNameController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController priorityController=TextEditingController();
  DivisionModels? modelData;
  String? divisionCode;
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is PicLoading) {

            }
            if (state is PicSuccess) {
              print("pIC IS ID${state.data}");

              imageId = state.data;
              imgUrl=state.url;

              print("pIC IS ID$imageId");
              setState(() {

              });
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is CreateUomGroupLoading) {
              showSnackBar(context,
                  message: "UOM Group Creation Loading",
                  color: ColorPalette.green);
            } else if (state is CreateUomGroupSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetUomGroupListEvent('','',''));
              Navigator.pop(context);
            } else if (state is CreateUomGroupFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is UomGroupReadLoading) {

            } else if (state is UomGroupReadSuccess) {

              modelData=state.divisionModel;
              print("mod$modelData");
              nameController.text=modelData?.name??"";
              altNameController.text=modelData?.shortName??"";
              discriptionController.text=modelData?.description??"";

              isActive=modelData?.isActive??false;

            } else if (state is UomGroupReadFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is UomGroupUpdateLoading) {
              showSnackBar(context,
                  message: "Uom Group Updation Loading",
                  color: ColorPalette.green);
            } else if (state is UomGroupUpdateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetUomGroupListEvent('','',''));
              Navigator.pop(context);
            } else if (state is UomGroupUpdateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xffF7F7F7),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(
            label: widget.edit==true?"Update Uom Group":"Create Uom Group", isAction: false,
            // action: SvgPicture.string(HomeSvg().searchIcon,height: 17,width: 17,color: Colors.black,),
          ),
        ),
        body: ScrollConfiguration(
          behavior: NoGlow(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormReusable(
                    label: "Name",
                    hint: "Eg. SEM",
                    controller: nameController,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Short Name",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: altNameController,
                  ),
                  SizedBox(height: 5,),
                  TextFormReusable(
                    label: "Description",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: discriptionController,
                  ),   SizedBox(height: 5,),
                  // Text(
                  //   "Image",
                  //   style: GoogleFonts.roboto(
                  //     color: Colors.black,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: 88,
                  //   height: 103,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     border: Border.all(color: Color(0xffe6ecf0), width: 1, ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Color(0x05000000),
                  //         blurRadius: 8,
                  //         offset: Offset(1, 1),
                  //       ),
                  //     ],
                  //     color: Color(0xfff7f7f7),
                  //   ),
                  //   child: imgUrl==""?GestureDetector(
                  //     onTap: (){
                  //       getCoverImage(
                  //           ImageSource.gallery);
                  //     },
                  //       child: Icon(Icons.add)):
                  //   Image.network(imgUrl),
                  // ),
                  Container(
                    width: w,
                    padding: EdgeInsets.all(16),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Is_Active",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              // isActive=!isActive;
                            });
                          },
                          child: isActive
                              ? SvgPicture.string(HomeSvg().toggleActive)
                              : SvgPicture.string(HomeSvg().toggleInActive),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  widget.edit==true?GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );

                        context.read<InventoryBloc>().add(UpdateUomGroupEvent(
                            id: modelData?.id??0,
                            isActive: isActive,
                            name: nameController.text,
                            description: discriptionController.text,
                           shortName: altNameController.text

                        ));
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xfffe5762),
                          Color(0xfffe5762),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )):GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );

                        context.read<InventoryBloc>().add(UomGroupCreateEvent(
                            name: nameController.text,
                            description: discriptionController.text,
                           shortName: altNameController.text

                        ));
                      },
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xfffe5762),
                          Color(0xfffe5762),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: const Color(0xfffe5762),
                      child: Text(
                        "Create",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
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
        BlocProvider.of<InventoryBloc>(context).add(PicEvent(image: cropImage!));
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
