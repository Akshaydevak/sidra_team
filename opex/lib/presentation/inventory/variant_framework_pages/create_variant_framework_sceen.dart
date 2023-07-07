import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../mpos/search_card.dart';
import '../../promotion_app/dropdown_card.dart';
import '../bloc/inventory_bloc.dart';
import '../model/division_model.dart';

class CreateVariantFrameworkScreen extends StatefulWidget {
  final bool? edit;
  const CreateVariantFrameworkScreen({Key? key, this.edit}) : super(key: key);

  @override
  State<CreateVariantFrameworkScreen> createState() => _CreateVariantFrameworkScreenState();
}

class _CreateVariantFrameworkScreenState extends State<CreateVariantFrameworkScreen> {
  List<List<String>> termsListTwo=[];
  List<String> termsList=List.from([]);
  List<AttributeLines> lines=[];
  List<TextEditingController> listController=[];

  bool? onChangeVal=false;
  bool isActive = true;
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic imageId;
  String imgUrl='';
  String? imageFileName;
  TextEditingController nameController=TextEditingController();
  TextEditingController altNameController=TextEditingController();
  TextEditingController searchNameController=TextEditingController();
  TextEditingController discriptionController=TextEditingController();
  TextEditingController valuesController=TextEditingController();
  TextEditingController priorityController=TextEditingController();
  List<int> valuesList=[];
  AttributeDataModel? modelData;
  String? divisionCode;
  int? attributeId;
  List<int> idList=[];
  List<bool> activelist=[];
  List<int> readListId=[];
  List<List<String>> values=[];
  List<TextEditingController>controllerList=[];
  String conValue='';
  void grpVal(List<int> idListCome,List<TextEditingController>controllerListCome,List<bool> boolList,bool edit){
    lines.clear();
    idList=idListCome;
    controllerList=controllerListCome;
    activelist=boolList;
    for(var i=0;i<idList.length;i++) {
      values.add([]);
    }
    setState((){});
    print("back Again$controllerList");
    print("back Again$idList");
    for(var i=0;i<idList.length;i++){
      values[i].clear();
      for(var j=0;j<controllerList[i].text.split(',').length;j++){
        values[i].add(controllerList[i].text.split(',')[j]);
        print("valuesssssss before adding lines $values");
      }
      print("iddddddddd ${idList[i]}");
      print("valuesssssss ${values}");
      if(edit==false){
        lines.add(AttributeLines(attributeId: idList[i],values: values[i]));
      }
      else{
        lines.add(AttributeLines(attributeId: idList[i],values: values[i],isActive: activelist[i],id: readListId[i]));

      }
      print("attrbitues and values lines before ${lines[i].attributeId}");
      print("attrbitues and values line befores ${lines[i].values}");
    }
    for(var i=0;i<lines.length;i++){
      print("attrbitues and values lines ${lines[i].attributeId}");
      print("attrbitues and values lines ${lines[i].values}");
    }


  }
  bool frameworkRead=false;
  List<String> attributeNameList=[];
  List<bool> boolList=[];
  List<int> attributeIdList=[];
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
            if (state is CreateVarientFrameWorkLoading) {
              showSnackBar(context,
                  message: "Category Creation Loading",
                  color: ColorPalette.green);
            } else if (state is CreateVarientFrameWorkSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetVarientFrameworkListEvent('','',''));
              Navigator.pop(context);
            } else if (state is CreateVarientFrameWorkFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is VarientFrameWorkReadLoading) {

            } else if (state is VarientFrameWorkReadSuccess) {

              frameworkRead=true;
              modelData=state.divisionModel;
              nameController.text=modelData?.name??"";
              discriptionController.text=modelData?.description??"";
              lines=modelData?.lines??[];
              print("linessss length ${lines.length}");

                for(var i=0;i<lines.length;i++){
                  conValue="";
                  for(var j=0;j<lines[i].values!.length;j++){
                    conValue=  conValue+ "${lines[i].values?[j]},";
                  }

                  listController.add(TextEditingController(text: conValue));
                  attributeNameList.add(lines[i].attributeDataModel?.attributeName??"");
                  boolList.add(lines[i].isActive??false);
                  readListId.add(lines[i].id??0);
                  attributeIdList.add(lines[i].attributeDataModel?.attributeId??0);

                  }
              print("KKKKKKAAASS$conValue");
              print("KKKKKKAAASS$boolList");
              print("KKKKKKAAASS$listController");
              print("KKKKKKAAASS$attributeNameList");
              print("KKKKKKAAASS$attributeIdList");
              isActive=modelData?.isActive??false;
              setState(() {

              });

            } else if (state is VarientFrameWorkReadFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<InventoryBloc, InventoryState>(
          listener: (context, state) {
            if (state is VarientFrameWorkUpdateLoading) {
              showSnackBar(context,
                  message: "Division Updation Loading",
                  color: ColorPalette.green);
            } else if (state is VarientFrameWorkUpdateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<InventoryBloc>().add(const GetVarientFrameworkListEvent('','',''));
              Navigator.pop(context);
            } else if (state is VarientFrameWorkUpdateFailed) {
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
            label: widget.edit==true?"Update Variant Framework":"Create Variant Framework", isAction: false,
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
                    label: "Description",
                    hint: "Eg. Lorem ipsum dolar sit amet. /",
                    controller: discriptionController,
                  ),
                  SizedBox(height: 5,),

                  frameworkRead==true?
                  AttributeWidfgetUpdate(
                    idList: attributeIdList,
                      nameList: attributeNameList,
                      boolList: boolList,
                      linePassing: grpVal,
                  listController: listController,):
                  AttributeWidfget(
                      linePassing: grpVal),

                  // VariantFrameWorkBottomTable(listAssign: (){},table: [],),
                  SizedBox(height: 16,),
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
                        const Text(
                          "Is Active",
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
                  widget.edit==true?
                  GradientButton(
                      onPressed: () {
                        context.read<InventoryBloc>().add(UpdateVarientFrameworkEvent(
                            id: modelData?.id??0,
                            isActive: isActive,
                            name: nameController.text,
                            description: discriptionController.text,
                           lines: lines??[]

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
                      ))
                      :GradientButton(
                      onPressed: () {
                        // PersistentNavBarNavigator.pushNewScreen(
                        //   context,
                        //   screen: AddNewList(),
                        //   withNavBar: true, // OPTIONAL VALUE. True by default.
                        //   pageTransitionAnimation: PageTransitionAnimation.fade,
                        // );

                        context.read<InventoryBloc>().add(VarientFrameworkCreateEvent(
                            name: nameController.text,
                            description: discriptionController.text,
                            lines: lines??[]

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

class AttributeWidfget extends StatefulWidget {
  final Function(List<int>, List<TextEditingController>,List<bool>,bool val) linePassing;


   AttributeWidfget({Key? key, required this.linePassing, }) : super(key: key);

  @override
  State<AttributeWidfget> createState() => _AttributeWidfgetState();
}

class _AttributeWidfgetState extends State<AttributeWidfget> {
  List<List<String>> termsListTwo=[];
  List<String> termsList=List.from([]);
  List<AttributeLines> lines=[];
  TextEditingController valuesController=TextEditingController();
  List<int> attributeIdList=[];


  List<TextEditingController> valusListController=[];
  String? divisionCode;
  int? attributeId;
  List<String> attributeNameList=[];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return  Container(
      // color: Colors.amber,
        child: Column(
          children: [
            for(var i=0;i<valusListController.length;i++)...{
              DropDownCard(
                selValue: attributeNameList[i],
                label: "Attribute",
                onTap: () {
                  context.read<InventoryBloc>().add( GetAttributeListEvent("",'',''));
                  _showModalBottomSheetOfferPeriod(divisionCode);
                },
              ),
              TextFormField(
                // readOnly: widget.readOnly,
                // onChanged: widget.onchange,
                scrollPadding: EdgeInsets.all(10),
                cursorColor: ColorPalette.black,
                // obscureText: show,
                style: TextStyle(color: ColorPalette.black, fontSize: 17),
                // keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
                // inputFormatters: [
                //   widget.numField==true?FilteringTextInputFormatter.digitsOnly:
                //   widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
                //   FilteringTextInputFormatter.singleLineFormatter,
                //
                // ],
                controller: valusListController[i],
                // maxLines: widget.maxLength,
                decoration: loginInputDecoration(
                  // hintText: widget.hint,
                  ('Username'),

                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("* Values seperated by commas",
                      style: GoogleFonts.roboto(
                        color: ColorPalette.black,
                        fontSize: w/30,
                        fontWeight: FontWeight.w500,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("Delete", style: GoogleFonts.roboto(
                      color: ColorPalette.primary,
                      fontSize: w/26,
                      fontWeight: FontWeight.w500,
                    )),
                  )
                ],
              ),
              SizedBox(height: 40,),
            },
            DropDownCard(
              selValue: divisionCode,
              label: "Attribute",
              onTap: () {
                context.read<InventoryBloc>().add( GetAttributeListEvent("",'',''));
                _showModalBottomSheetOfferPeriod(divisionCode);
              },
            ),
            TextFormField(
              // readOnly: widget.readOnly,
              // onChanged: widget.onchange,
              scrollPadding: EdgeInsets.all(10),
              cursorColor: ColorPalette.black,
              // obscureText: show,
              style: TextStyle(color: ColorPalette.black, fontSize: 17),
              // keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
              // inputFormatters: [
              //   widget.numField==true?FilteringTextInputFormatter.digitsOnly:
              //   widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
              //   FilteringTextInputFormatter.singleLineFormatter,
              //
              // ],
              controller: valuesController,
              // maxLines: widget.maxLength,
              decoration: loginInputDecoration(
                // hintText: widget.hint,
                ('Username'),

              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("* Values seperated by commas",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: w/30,
                      fontWeight: FontWeight.w500,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: (){
                      valusListController.add(TextEditingController(text: valuesController.text));
                      print("valusListController${valusListController}");
                      valuesController.clear();
                      divisionCode="";

                      widget.linePassing(attributeIdList,valusListController,[],false);
                      setState(() {

                      });
                    },
                    child: Text("ADD NEW",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primary,
                          fontSize: w / 24),),
                  ),
                )
              ],
            ),
            SizedBox(height: 40,),
          ],
        ),
    );
  }
  _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {
    int selectIndex = 0;
    String nextUrl="";
    String prevUrl="";
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Select Attribute",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: SearchCard(
                          hint: "Search Attribute...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetAttributeListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetAttributeTypeLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is GetAttributeListSuccess) {
                            nextUrl=state.nextPageUrl??"";
                            prevUrl=state.prevPageUrl??"";
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: state.inventory!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [

                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            attributeIdList.add(state.inventory?[index].id??0);
                                            attributeNameList.add(state.inventory?[index].attributeName??"");
                                            print("NNNNN$attributeIdList");
                                            setState(() {});
                                            attributeId = state.inventory?[index].id ?? 0;
                                            divisionCode=state.inventory?[index].attributeName??"";

                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              GestureDetector(

                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 8,
                                                      bottom: 10,
                                                      top: 5,
                                                      right: 8),
                                                  child: SvgPicture.string(state
                                                      .inventory?[index]
                                                      .attributeName ==
                                                      offerPeriodNameNew
                                                  // selectIndex == index
                                                      ? HomeSvg().radioButtonActive
                                                      : HomeSvg().radioInActive),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                state.inventory?[index].attributeName ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          color: ColorPalette.divider,
                                          height: 1,
                                          width: w,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: 15,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        prevUrl!=""?GestureDetector(
                                          onTap: (){
                                            context.read<InventoryBloc>().add( GetAttributeListEvent("",'',prevUrl));
                                            // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                          },
                                          child: Text(
                                            "Previous",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),
                                          ),
                                        ):Container(),
                                        nextUrl!=""?
                                        GestureDetector(
                                          onTap: (){
                                            // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                            setState(() {
                                              context.read<InventoryBloc>().add( GetAttributeListEvent('',nextUrl,''));
                                            });
                                          },
                                          child: Text("Next",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),),
                                        ):Text("")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container(
                              width: w,
                              height: 300,
                              child: customCupertinoLoading());
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}


class AttributeWidfgetUpdate extends StatefulWidget {
  final Function(List<int>, List<TextEditingController> ,List<bool>,bool val) linePassing;
  final List<TextEditingController>listController;
  final List<String>nameList;
  final List<int>idList;
  final List<bool>boolList;

  AttributeWidfgetUpdate({Key? key, required this.linePassing, required this.listController, required this.nameList, required this.idList, required this.boolList}) : super(key: key);

  @override
  State<AttributeWidfgetUpdate> createState() => _AttributeWidfgetUpdateState();
}

class _AttributeWidfgetUpdateState extends State<AttributeWidfgetUpdate> {

  List<AttributeLines> lines=[];
  TextEditingController valuesController=TextEditingController();
  List<int> attributeIdList=[];
  List<bool> valueActiveList=[];


  List<TextEditingController> valusListController=[];
  String? divisionCode;
  bool onChange=false;
  int? attributeId;
  List<String> attributeNameList=[];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return  Container(
      // color: Colors.amber,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          for(var i=0;i<widget.listController.length;i++)...{
            ReadDropDownCard(
              selValue: widget.nameList[i],
              label: "Attribute ${i+1}",
              onTap: () {
                context.read<InventoryBloc>().add( GetAttributeListEvent("",'',''));
                _showModalBottomSheetOfferPeriod(divisionCode);
              },
            ),
            TextFormField(
              onChanged:(sa){

                onChange=true;
                setState(() {

                });
              },
              scrollPadding: EdgeInsets.all(10),
              cursorColor: ColorPalette.black,
              style: TextStyle(color: ColorPalette.black, fontSize: 17),

              controller: widget.listController[i],
              decoration: loginInputDecoration(
                ('Username'),

              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("* Values seperated by commas",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.black,
                      fontSize: w/30,
                      fontWeight: FontWeight.w500,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: (){
                      // valueActiveList
                      print("valll${widget.boolList[i]}");
                      widget.boolList[i]=false;
                      onChange=true;
                      print("valll${widget.boolList[i]}");
                      setState(() {

                      });
                    },
                    child: Text(widget.boolList[i]==true?"Delete":"Deleted", style: GoogleFonts.roboto(
                      color: ColorPalette.primary,
                      fontSize: w/26,
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                )
              ],
            ),
            onChange==true?Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: (){
                  widget.listController[i].text=widget.listController[i].text;
                  print("HAS COME${widget.listController[i]}");
                  print("HAS COME${widget.idList.length}");
                  print("HAS COME${widget.listController.length}");
                  print("HAS COME${widget.boolList.length}");
                  widget.linePassing(widget.idList,widget.listController,widget.boolList,true);
                  setState(() {

                  });
                },
                child: Text("SAVE",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.primary,
                      fontSize: w / 24),),
              ),
            ):Container(),
            SizedBox(height: 40,),
          },

          // DropDownCard(
          //   selValue: divisionCode,
          //   label: "Attribute",
          //   onTap: () {
          //     context.read<InventoryBloc>().add( GetAttributeListEvent("",'',''));
          //     _showModalBottomSheetOfferPeriod(divisionCode);
          //   },
          // ),
          // TextFormField(
          //   // readOnly: widget.readOnly,
          //   // onChanged: widget.onchange,
          //   scrollPadding: EdgeInsets.all(10),
          //   cursorColor: ColorPalette.black,
          //   // obscureText: show,
          //   style: TextStyle(color: ColorPalette.black, fontSize: 17),
          //   // keyboardType: widget.numField==true||widget.floatVal==true?TextInputType.numberWithOptions(decimal: false):TextInputType.emailAddress,
          //   // inputFormatters: [
          //   //   widget.numField==true?FilteringTextInputFormatter.digitsOnly:
          //   //   widget.floatVal==true?FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')):
          //   //   FilteringTextInputFormatter.singleLineFormatter,
          //   //
          //   // ],
          //   controller: valuesController,
          //   // maxLines: widget.maxLength,
          //   decoration: loginInputDecoration(
          //     // hintText: widget.hint,
          //     ('Username'),
          //
          //   ),
          // ),
          // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("* Values seperated by commas",
          //         style: GoogleFonts.roboto(
          //           color: ColorPalette.black,
          //           fontSize: w/30,
          //           fontWeight: FontWeight.w500,
          //         )),

          //   ],
          // ),
          // SizedBox(height: 40,)


        ],
      ),
    );
  }
  _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {
    int selectIndex = 0;
    String nextUrl="";
    String prevUrl="";
    void onselect(int index) {
      setState(() {
        selectIndex = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Select Attribute",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: SearchCard(
                          hint: "Search Attribute...",
                          onchange: (ff){
                            setState((){


                              context.read<InventoryBloc>().add( GetAttributeListEvent(ff,'',''));
                            });
                          },
                        ),
                      ),
                      BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetAttributeTypeLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is GetAttributeListSuccess) {
                            nextUrl=state.nextPageUrl??"";
                            prevUrl=state.prevPageUrl??"";
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: state.inventory!.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [

                                        GestureDetector(
                                          onTap: () {
                                            onselect(index);
                                            attributeIdList.add(state.inventory?[index].id??0);
                                            attributeNameList.add(state.inventory?[index].attributeName??"");
                                            print("NNNNN$attributeIdList");
                                            setState(() {});
                                            attributeId = state.inventory?[index].id ?? 0;
                                            divisionCode=state.inventory?[index].attributeName??"";

                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              GestureDetector(

                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 8,
                                                      bottom: 10,
                                                      top: 5,
                                                      right: 8),
                                                  child: SvgPicture.string(state
                                                      .inventory?[index]
                                                      .attributeName ==
                                                      offerPeriodNameNew
                                                  // selectIndex == index
                                                      ? HomeSvg().radioButtonActive
                                                      : HomeSvg().radioInActive),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                state.inventory?[index].attributeName ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Container(
                                          color: ColorPalette.divider,
                                          height: 1,
                                          width: w,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: 15,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        prevUrl!=""?GestureDetector(
                                          onTap: (){
                                            context.read<InventoryBloc>().add( GetAttributeListEvent("",'',prevUrl));
                                            // context.read<InventoryBloc>().add(ProductStockListEvent("",state.product.count.toString()??""));
                                          },
                                          child: Text(
                                            "Previous",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),
                                          ),
                                        ):Container(),
                                        nextUrl!=""?
                                        GestureDetector(
                                          onTap: (){
                                            // context.read<InventoryBloc>().add(ProductStockListEvent(state.product.nextPageUrl??"",""));
                                            setState(() {
                                              context.read<InventoryBloc>().add( GetAttributeListEvent('',nextUrl,''));
                                            });
                                          },
                                          child: Text("Next",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: ColorPalette.primary,
                                                fontSize: w / 24),),
                                        ):Text("")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container(
                              width: w,
                              height: 300,
                              child: customCupertinoLoading());
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
