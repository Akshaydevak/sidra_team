import 'package:cluster/common_widgets/cluster_card.dart';
import 'package:cluster/common_widgets/gradient_button.dart';
import 'package:cluster/common_widgets/no_glow.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen/home_svg.dart';
import 'package:cluster/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:cluster/presentation/inventory/model/inventory_model.dart';
import 'package:cluster/presentation/seller_app/new_list_tab/textfield_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../order_app/order_svg.dart';
import '../seller_svg.dart';

class GeneralTab extends StatefulWidget {
final TextEditingController? varientName;
final TextEditingController? searchName;
final TextEditingController? displayName;
final TextEditingController? description;
final TextEditingController? oldSystemCode;
final TextEditingController? identification;
final Function(String)? onChangeBaseUom;
final Function(String)? onChangeSalesUom;
final Function(String)? onChangeChannel;
 final int ?id;
  GeneralTab({Key? key,this.id,this.varientName,this.searchName,this.displayName,this.description,this.oldSystemCode,this.identification,this.onChangeBaseUom,this.onChangeSalesUom,this.onChangeChannel}) : super(key: key);

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  int? isSelect;
  int? isSelectSales;
  bool isActive=false;
  List<InventoryModel>?uomList=[];
  List<String>?channelList=[];
  String ?selectChannel;
  String base="- select -";
  String sales="- select -";
  // TextEditingController varientNameController=TextEditingController();
  // TextEditingController searchNameController=TextEditingController();
  // TextEditingController displayNameController=TextEditingController();
  // TextEditingController discriptionController=TextEditingController();
  @override
  void initState() {

    context.read<InventoryBloc>().add( GetSalesUomEvent(id:widget.id));
    context.read<InventoryBloc>().add( GetChannelEvent());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      // padding: EdgeInsets.all(16),
      child: BlocListener<InventoryBloc,InventoryState>(
        listener: (context, state) {
          if(state is GetUomSuccess){
            uomList=state.inventory;
          } if(state is ChannelSuccess){
            for(int i=0;i<state.inventory!.length;i++)
              channelList?.add(state.inventory?[i].displayName??'');
            setState(() {

            });
            // channelList=state.inventory;
            print(".......channel list$channelList");
          }
        },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              TextFieldTab(
                controller: widget.varientName,
                label: "Varient Name",
                hint: "Eg. SEM",
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(
                controller: widget.searchName,
                label: "Search Name",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(
                controller: widget.displayName,
                label: "Display Name",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 16,
              ), TextFieldTab(
                controller: widget.description,
                label: "Description",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(

                controller: widget.oldSystemCode,
                label: "Old System Code",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "Base UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon,height: 15,)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: (){
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  _showModalBottomSheet();
                },
                child: Container(
                  width: w ,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 11),
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
                  children:  [
                    Text(
                      base??"-  Select  -",
                      style: TextStyle(
                        color: Color(0xbf666161),
                        fontSize: w/24,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color:Color(0x7f666161))
                  ],
                ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    "Sales UOM",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon,height: 15,)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: (){
                  _showModalBottomSheetSales();
                },
                child: Container(
                  width: w ,
                  // padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 11),
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
                  children:  [
                    Text(
                      sales??"-  Select  -",
                      style: TextStyle(
                        color: Color(0xbf666161),
                        fontSize: w/24,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,color:Color(0x7f666161))
                  ],
                ),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "Please choose any UOM",
                style: TextStyle(
                  color: Color(0xff666161),
                  fontSize: w/26,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    "Channel",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.string(SellerSvg().validationIcon,height: 15,)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: w / 2.3,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
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
                  child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down,color:Color(0x7f666161)),
                      elevation: 1,
                      underline: Container(),
                      value: selectChannel,
                      items: channelList
                          ?.map((String items) {
                        return DropdownMenuItem(

                          alignment: Alignment
                              .centerLeft,
                          enabled: true,
                          value: items,
                          child: Text(items,
                              style: GoogleFonts
                                  .poppins(
                                  color: ColorPalette
                                      .black)),
                        );
                      }).toList(),
                      onChanged:
                          (dynamic value) {
                        setState(() {
                          widget.onChangeChannel!(value??"");
                          selectChannel =
                              value;
                        });
                      },
                      hint: Text(
                        "Select",
                        style: TextStyle(
                          color: Color(0xbf666161),
                          fontSize: w/24,
                        ),
                      ))),
              SizedBox(
                height: 16,
              ),
              TextFieldTab(
                controller: widget.identification,
                label: "Identification",
                hint: "Eg. Lorem ipsum dolar sit amet.",
              ),
              SizedBox(height: 30,),
              ClusterCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is Active",
                        style: GoogleFonts.roboto(
                          color: ColorPalette.black,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                        child: isActive
                            ? SvgPicture.string(HomeSvg().toggleActive,height: 22,)
                            : SvgPicture.string(HomeSvg().toggleInActive,height: 22),
                      )
                    ],
                  )),
              SizedBox(height: 20,)
            ],
          )

      ),
    );
  }

  _showModalBottomSheet() {

    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: ScrollConfiguration(
                  behavior: NoGlow(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: w,
                          padding: EdgeInsets.only(right: 10,top: 10),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: (){Navigator.pop(context);},
                              child: Icon(Icons.close)),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "Base Uom",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: w/20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Divider(
                          color: ColorPalette.divider,
                          thickness: 1.1,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  widget.onChangeBaseUom!(uomList?[index].name??"");
                                  base=uomList?[index].name??"";

                                  isSelect=index;
                                });
                                Navigator.pop(context);
                              },
                              child: isSelect==index
                                  ? Container(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.string(OrderSvg().checkBoxActiveIcon))
                                  : SvgPicture.string(
                                OrderSvg().checkBoxIcon,
                                height: 35,
                                width: 35,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(uomList?[index].name??"")
                          ],
                        ), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: uomList!.length),
                        SizedBox(height: 40,),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: GradientButton(
                              color: ColorPalette.primary,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    ColorPalette.primary,
                                    ColorPalette.primary
                                  ]),
                              child: Text(
                                "Continue",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: w/22,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
  _showModalBottomSheetSales() {

    final TextEditingController groupName = TextEditingController();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 550,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: w,
                        padding: EdgeInsets.only(right: 10,top: 10),
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Sales Uom",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: w/20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState((){
                                widget.onChangeSalesUom!(uomList?[index].name??"");
                                sales=uomList?[index].name??"";
                                isSelectSales=index;
                              });
                            },
                            child: isSelectSales==index
                                ? Container(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.string(OrderSvg().checkBoxActiveIcon))
                                : SvgPicture.string(
                              OrderSvg().checkBoxIcon,
                              height: 35,
                              width: 35,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(uomList?[index].name??"")
                        ],
                      ), separatorBuilder: (context, index) => SizedBox(height: 10,), itemCount: uomList!.length),

                      SizedBox(height: 40,),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: GradientButton(
                            color: ColorPalette.primary,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorPalette.primary,
                                  ColorPalette.primary
                                ]),
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: w/22,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
