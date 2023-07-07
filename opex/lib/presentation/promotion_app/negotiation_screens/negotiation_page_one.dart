import 'dart:io';

import 'package:cluster/presentation/promotion_app/negotiation_screens/negotiation_bloc/negotiation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../../../common_widgets/loading.dart';
import '../../../common_widgets/no_glow.dart';
import '../../../common_widgets/reusable_textfield.dart';
import '../../../core/color_palatte.dart';
import '../../../core/common_snackBar.dart';
import '../../../core/utils/variables.dart';
import '../../authentication/authentication.dart';
import '../../dashboard_screen/home_screen/home_svg.dart';
import '../../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../blocs/discount_bloc/discount_bloc.dart';
import '../buy_more_get_form/buymore_bloc/buy_more_bloc.dart';
import '../dropdown_card.dart';
import '../models_promotion/discount_models/model_discount.dart';
import '../promotion_svg.dart';
import '../widget/file_upload_card.dart';
import 'negotiation_page_two.dart';

class NegotiationPageOne extends StatefulWidget {
  final bool? editDiscount;
  const NegotiationPageOne({super.key, this.editDiscount});

  @override
  State<NegotiationPageOne> createState() => _NegotiationPageOneState();
}

class _NegotiationPageOneState extends State<NegotiationPageOne> {
  bool isAvailable = true;
  bool isPriority = false;
  bool isActive = false;
  List<String> segmentListttt = [];
  List<GetTypeApplying> availableCustomerList = [];
  List<GetTypeApplying> selectedCustomerList = [];
  String _selectedDate1 = '';
  String _dateCount = '';
  String _range = '';
  String _range2 = '';
  String _rangeCount = '';
  bool selDate = false;
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selDate = true;
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            ' ${DateFormat('yyyy-MM-dd').format(
            args.value.endDate ?? args.value.startDate)}';
        _range2 = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd-MM-yyyy').format(
            args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate1 = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }
  String? imageFileName;
  final TextEditingController title = TextEditingController();
  final TextEditingController discription = TextEditingController();
  final TextEditingController note = TextEditingController();
  String? fromDate;
  String? toDate;
  String? fromTime;
  String? toTime;
  String? fromDateView;
  String? toDateView;
  GetOfferPeriod? offerperiodRead;
  GetOfferGroup? offerGroup;
  String? offerPeriodName;
  String? offerGroupName;
  bool changeSegment=false;

  refresh(){
    setState(() {

    });
  }



  @override
  void initState() {
    context.read<DiscountBloc>().add(const GetSegmentListEvent());
    context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent("",""));
    context.read<DiscountBloc>().add(PaginatedChannelListEvent(""));
    context.read<DiscountBloc>().add(PaginatedOfferGroupEvent(""));
    context.read<BuyMoreBloc>().add(GetOfferApplyingBasedOnReadBuyMoreEvent());
    context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(null,null));
    super.initState();
  }
  clearData() {
    title.clear();
    discription.clear();
    note.clear();
    fromDate = "";
    _range="";
    _range2="";
    toDate = "";
    fromTime = "";
    toTime = "";
    selTime=false;
    selTime2=false;
    _time = const TimeOfDay(hour: 00, minute: 00);
    _time2 = const TimeOfDay(hour: 00, minute: 00);
  }
  final picker = ImagePicker();
  File? cropImage;
  bool _cropped = false;
  dynamic imageId;



  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00,);
  TimeOfDay _time2 = const TimeOfDay(hour: 00, minute: 00);


  bool selTime = false;
  bool selTime2 = false;
  String formattedTime="";
  String formattedTime2="";
  void _selectTime() async {
    selTime = true;
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        // startTime="${newTime.hour}"":""${newTime.minute}"":""00 ";
      });
    }
    final twelveHourFormat = DateFormat('h:mm a');
    final twentyFourHourFormat = DateFormat('HH:mm');

    final dateTime = DateTime(1, 1, 1, _time.hour, _time.minute);
    formattedTime = twentyFourHourFormat.format(dateTime);

    print("TYM${_time.hour}" ":" "${_time.minute}");
    print("TYMTTT${formattedTime}");
  }

  void _endTime() async {
    selTime2 = true;
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime != null) {
      setState(() {
        _time2 = newTime;
        // endTime="${newTime.hour}"":""${newTime.minute}"":""00 ";
      });
    }
    final twelveHourFormat = DateFormat('h:mm a');
    final twentyFourHourFormat = DateFormat('HH:mm');
    final dateTime = DateTime(1, 1, 1, _time2.hour, _time2.minute);
    formattedTime2 = twentyFourHourFormat.format(dateTime);


    print("TYMTTT${formattedTime2}");
    print("TYM${_time2.hour}" ":" "${_time2.minute}");
  }

  List<String> customercode=[];
  String? segmentName;
  List<GetSegmentList> segmentList = [];
  List<GetSegmentList> discountSegment = [];
  List<GetTypeApplying> customerList = [];
  List<GetOfferPeriod> offerPeriodList = [];
  List<GetOfferGroup> offergroupList = [];
  List<ChannelList>channelList = [];
  List<String> basedOn = [];
  String? basedOnValue;
  TextEditingController promotionTitle = TextEditingController();
  TextEditingController promotionDescription = TextEditingController();
  TextEditingController promotiondiscount = TextEditingController();
  int? offerperiodId;
  int? offergroupId;
  String lifeStyle="";
  String? discountChannelCode;
  String? drop;
  int? discountChannelId;
  NegotiationList? readDiscount;
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    return MultiBlocListener(
      listeners: [
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is PostImageDiscontLoading) {

            }
            if (state is PostImageDiscontSuccess) {
              print("pIC IS ID${state.id}");

              imageId = state.id;
              print("pIC IS ID$imageId");
              setState(() {

              });
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is GetSegmentListLoading) {
              customCupertinoLoading();
            }
            if (state is GetSegmentListSuccess) {
              segmentList = state.segments;
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is GetCustomerGroupListLoading) {
              customCupertinoLoading();
            }
            if (state is GetCustomerGroupListSuccess) {
              customerList = state.customerGroup.data;
              print("CUSTOMER GROUP LIST$customerList");
              setState(() {

              });
            }
          },
        ),
        BlocListener<BuyMoreBloc, BuyMoreState>(
          listener: (context, state) {
            print("potti$state");
            if (state is GetOfferAppliyingBasedOnReadBuyMoreLoading) {
              customCupertinoLoading();
            }
            if (state is GetOfferAppliyingBasedOnReadBuyMoreSuccess) {
              basedOn = state.discount.basedOn!;
              print("BAES$basedOn");
              setState(() {

              });
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is GetOfferPeriodListLoading) {
              customCupertinoLoading();
            }
            if (state is GetOfferPeriodListSuccess) {
              offerPeriodList = state.offerPeriod.data;
              print("paginated${state.offerPeriod.data}");
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is OfferPeriodCreateLoading) {
              showSnackBar(context,
                  message: "Offer Period Loading",
                  color: ColorPalette.green);
            } else if (state is OfferPeriodCreateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent("",""));
              Navigator.pop(context);
            } else if (state is OfferPeriodCreateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is OfferPeriodUpdateLoading) {
              showSnackBar(context,
                  message: "Offer Period Loading",
                  color: ColorPalette.green);
            } else if (state is OfferPeriodUpdateSuccess) {
              showSnackBar(context,
                  message: state.successMessage??"",
                  color: ColorPalette.green);
              context.read<DiscountBloc>().add( PaginatedOfferPeriodEvent("",""));
              Navigator.pop(context);

            } else if (state is OfferPeriodUpdateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is DeleteOfferPeriodLoading) {
              showSnackBar(context,
                  message: "Offer Period Loading",
                  color: ColorPalette.green);
            } else if (state is DeleteOfferPeriodSuccess) {
              showSnackBar(context,
                  message: "Offer Period Deleted",
                  color: ColorPalette.green);
              context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent("",""));
              Navigator.pop(context);
            } else if (state is DeleteOfferPeriodFailed) {
              showSnackBar(context,
                  message: "Not Deleted", color: ColorPalette.black);
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is OfferGroupCreateLoading) {
              showSnackBar(context,
                  message: "Offer Group Loading",
                  color: ColorPalette.green);
            } else if (state is OfferGroupCreateSuccess) {
              showSnackBar(context,
                  message: "Offer Group Created",
                  color: ColorPalette.green);
              context.read<DiscountBloc>().add(PaginatedOfferGroupEvent(""));
              Navigator.pop(context);
            } else if (state is OfferGroupCreateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is GetOfferGroupListLoading) {
              customCupertinoLoading();
            }
            if (state is GetOfferGroupListSuccess) {
              offergroupList = state.offerGroup.data;
              print("paginatrd${state.offerGroup.data}");
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is OfferGroupUpdateLoading) {
              showSnackBar(context,
                  message: "Offer Group Loading",
                  color: ColorPalette.green);
            } else if (state is OfferGroupUpdateSuccess) {
              showSnackBar(context,
                  message: "Offer Group Updated",
                  color: ColorPalette.green);
              Navigator.pop(context);
            } else if (state is OfferGroupUpdateFailed) {
              showSnackBar(context,
                  message: state.error, color: ColorPalette.black);
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if (state is DeleteOfferGroupLoading) {
              showSnackBar(context,
                  message: "Offer Group Loading",
                  color: ColorPalette.green);
            } else if (state is DeleteOfferGroupSuccess) {
              showSnackBar(context,
                  message: "Offer Group Deleted",
                  color: ColorPalette.green);
              context.read<DiscountBloc>().add(PaginatedOfferGroupEvent(""));
              Navigator.pop(context);
            } else if (state is DeleteOfferGroupFailed) {
              showSnackBar(context,
                  message: "Not Deleted", color: ColorPalette.black);
            }
          },
        ),
        BlocListener<NegotiationBloc, NegotiationState>(
          listener: (context, state) {
            if (state is GetNegotiationReadLoading) {
              customCupertinoLoading();
            }
            else if (state is GetNegotiationReadSuccess) {
              readDiscount = state.negotiationList;
              print("read$readDiscount");
              print("segmentListRead$segmentListttt");
              promotionTitle.text = readDiscount?.name ?? "";
              promotionDescription.text = readDiscount?.description ?? "";
              basedOnValue = readDiscount?.basedOn ?? "";
              offerperiodId = readDiscount?.offerPeriodDetails?.offerPeriodId ?? 0;
              isAvailable = readDiscount?.isAvailableForAll ?? false;
              discountSegment = readDiscount?.segments ?? [];
              imageId = readDiscount?.image ?? "";
              availableCustomerList=readDiscount?.customer??[];
              selectedCustomerList=readDiscount?.customer??[];
              imageFileName=readDiscount?.image??"";
              drop = readDiscount?.channelCode ?? "";
              offerPeriodName=readDiscount?.offerPeriodDetails?.offerPeriodName??"";
              for (var i = 0; i < readDiscount!.segments!.length; i++) {
                segmentListttt.add(
                    readDiscount?.segments?[i].segmentName ?? "");
              }
              for(int i=0;i<segmentListttt.length;i++){
                lifeStyle="$lifeStyle${segmentListttt[i]},";
              }
              for(int i=0;i<readDiscount!.customer!.length;i++){
                customercode.add(readDiscount?.customer?[i].customerGroupCode??"");
              }
              print("segmentListRead$segmentListttt");
              setState(() {

              });
            }
          },
        ),
        BlocListener<DiscountBloc, DiscountState>(
          listener: (context, state) {
            if(state is GetOfferPeriodReadLoading){
              customCupertinoLoading();
            }
            if(state is GetOfferPeriodReadSuccess){
              selTime = false;
              selTime2 = false;
              selDate = false;
              _showModalBottomSheetNew(context,true);
              offerperiodRead=state.offerPeriod;
              title.text=state.offerPeriod.title??"";
              discription.text=state.offerPeriod.description??"";
              note.text=state.offerPeriod.notes??"";
              fromDate=state.offerPeriod.fromDate??"";
              toDate=state.offerPeriod.toDate??"";
              fromTime=state.offerPeriod.fromTime??"";
              toTime=state.offerPeriod.toTime??"";
              var date = state.offerPeriod.fromDate;
              var date2 = state.offerPeriod.toDate;
              var dateTime =  DateTime.parse("$date");
              var dateTime2 =  DateTime.parse("$date2");
              fromDateView =  DateFormat('dd-MM-yyyy').format(dateTime).toString();
              toDateView =  DateFormat('dd-MM-yyyy').format(dateTime2).toString();
              setState(() {

              });
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: BackAppBar(label: "Negotiation",
              isBack: true,
              isAction: false,
              onTap: () {
                Navigator.pop(context);
              }
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
                  SvgPicture.string(PromotionSvg().progressDesign),
                  SizedBox(
                    height: 30,
                  ),
                  widget.editDiscount==true?
                  ReadDropDownCard(
                    selValue: lifeStyle,
                  ):
                  DropDownCard(
                    selValue: segmentListttt.isNotEmpty
                        ? "Segment Selected"
                        : segmentName,
                    onTap: () {
                      _showModalBottomSheet();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormReusable(
                    label: "Promotion Title",
                    hint: "Eg. SEM",
                    controller: promotionTitle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormReusable(
                    label: "Description",
                    hint: "",
                    controller: promotionDescription,
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // widget.editDiscount==true?ReadDropDownCard(
                  //   selValue: drop,
                  //   label: "Select Channel",
                  // ):Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text("Select Channel",
                  //       style: GoogleFonts.roboto(
                  //         color: ColorPalette.black,
                  //         fontSize: w / 24,
                  //         fontWeight: FontWeight.w500,
                  //       ),),
                  //     Container(
                  //         width: w,
                  //         padding: EdgeInsets.only(left: 15),
                  //         decoration: BoxDecoration(color: Colors.white,
                  //             border: Border.all(color: Color(0xffe6ecf0)),
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: DropdownButton<String>(
                  //           underline: Container(),
                  //           icon:  Padding(
                  //             padding: const EdgeInsets.only(left: 170),
                  //             child: Icon(Icons.arrow_drop_down_circle),
                  //           ),
                  //           hint: const Text("Select Channel"),
                  //           value: drop,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               drop = value;
                  //             });
                  //           },
                  //
                  //           items: channelList
                  //               .map<DropdownMenuItem<String>>((
                  //               ChannelList _value) =>
                  //               DropdownMenuItem<String>(
                  //                   value: _value.channelCode,
                  //                   child: Text(_value.channelCode ?? "",)
                  //               )).toList(),
                  //         )
                  //     ),
                  //   ],
                  // ),

                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Customer Group",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xffe6ecf0),
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
                    child: Column(
                      children: [
                        Padding(
                          padding: isAvailable
                              ? const EdgeInsets.all(10) :
                          const EdgeInsets.only(
                              left: 10, top: 10, bottom: 0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Is Available for All",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xff151522),
                                  fontSize: w / 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAvailable = !isAvailable;
                                    context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(null,null));
                                  });
                                },
                                child: isAvailable
                                    ? SvgPicture.string(HomeSvg().toggleActive)
                                    : SvgPicture.string(
                                    HomeSvg().toggleInActive),
                              )
                            ],
                          ),
                        ),
                        isAvailable
                            ? Container() :
                        Column(
                          children: [
                            const Divider(
                              indent: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(null,null));
                                selectedCustomerList.isEmpty?
                                _showModalBottomSheetCustomer():
                                _showModalBottomSheetCustomerSelected();
                              },
                              child: Container(width: w,
                                color: Colors.white,
                                padding: const EdgeInsets.only(
                                    left: 10, top: 0, bottom: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      customercode.isNotEmpty?"Customer Group Selected":"",
                                      style: TextStyle(
                                        color: const Color(0x7f666161),
                                        fontSize: w / 24,
                                      ),
                                    ),
                                    const Icon(
                                        Icons.keyboard_arrow_down_outlined)
                                  ],
                                ),
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropDownCard(
                    selValue: offerPeriodName,

                    label: "Offer Period",
                    onTap: () {
                      context.read<DiscountBloc>().add( PaginatedOfferPeriodEvent("",""));
                      _showModalBottomSheetOfferPeriod(offerPeriodName);
                    },
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // DropDownCard(
                  //   selValue: offerGroupName,
                  //   label: "Offer Group",
                  //   onTap: (){
                  //     _showModalBottomSheetOfferGroup();
                  //   },
                  // ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flex(direction: Axis.vertical,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Based On",
                              style: GoogleFonts.roboto(
                                color: ColorPalette.black,
                                fontSize: w / 24,
                                fontWeight: FontWeight.w500,
                              ),),
                            Container(
                                width: w,
                                padding: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xffe6ecf0)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: const Padding(
                                    padding: EdgeInsets.only(left: 200),
                                    child: Icon(Icons.arrow_drop_down_circle),
                                  ),
                                  hint: const Text("Based On"),
                                  value: basedOnValue,
                                  onChanged: (value) {
                                    setState(() {
                                      basedOnValue = value;
                                    });
                                  },

                                  items: basedOn.map<DropdownMenuItem<String>>((
                                      String _value) =>
                                      DropdownMenuItem<String>(
                                          value: _value,
                                          child: Text(_value ?? "",)
                                      )).toList(),
                                )

                            ),
                          ],
                        ),
                      ]),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // TextFormReusable(
                  //   label: "Discount Percentage / Price",
                  //   hint: "Eg. Lorem ipsum dollar sit amet.",
                  //   controller: promotiondiscount,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  FileUploadCard(
                    label: imageId == null
                        ? "No file chosen"
                        : imageFileName,
                    onTap: () {
                      getCoverImage(
                          ImageSource.gallery);
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                      color: ColorPalette.primary,
                      onPressed: () {
                        print("IFFF$offergroupId");
                        basedOnValue==""?
                        Fluttertoast.showToast(
                            msg: 'Please Check the Fields',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black):
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen:NegotiationPageTwo(
                            changeedSeg: changeSegment,
                            segmentList: segmentListttt,
                            basedOn: basedOnValue,
                            editBuyMore: widget.editDiscount??false,
                            buyMore: readDiscount,
                            promotionDiscription: promotionDescription.text,
                            promotionTitle: promotionTitle.text,
                            discountPercentagePrice: double.tryParse(
                                promotiondiscount.text),
                            isAvailableForAll: isAvailable,
                            customerList: isAvailable == true
                                ? []
                                : availableCustomerList,
                            imageId: imageId,
                            discountSegment: discountSegment,
                            offerGroupId: offergroupId,
                            offerPeriodId: offerperiodId,
                            channelCode: drop,
                            channelId: drop,
                          ),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                          PageTransitionAnimation.fade,
                        );
                      },
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ColorPalette.primary, ColorPalette.primary]),
                      child: Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w / 22,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    final TextEditingController groupName = TextEditingController();
    int select = 0;

    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          print("qqqqqqqqqqqqqqqqq${segmentListttt}");
          var h = MediaQuery
              .of(context)
              .size
              .height;
          var w = MediaQuery
              .of(context)
              .size
              .width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 450,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Segments",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              primary: true,
                              shrinkWrap: true,
                              itemCount: segmentList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  Row(
                                    children: [

                                      CustomCheckBox(
                                        key: UniqueKey(),
                                        value:
                                        // widget.readUser,
                                        segmentListttt.contains(
                                            segmentList[index].name),
                                        onChange: (p0) {
                                          if (p0) {
                                            segmentListttt.add(
                                                segmentList[index].name ?? "");
                                            discountSegment.add(GetSegmentList(
                                                segmentName: segmentList[index]
                                                    .name,
                                                segmentCode: segmentList[index]
                                                    .code
                                            ));
                                            changeSegment=true;
                                          }
                                          else {
                                            segmentListttt.remove(
                                                segmentList[index].name ?? "");
                                            discountSegment.remove(
                                                GetSegmentList(
                                                    name: segmentList[index]
                                                        .name,
                                                    code: segmentList[index]
                                                        .code
                                                ));
                                            changeSegment=true;
                                          }
                                          print("seg-list${segmentListttt}");
                                          print("seg-list${discountSegment}");
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        segmentList[index].name ?? "",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
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
                            GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  refresh();

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
                                  "Select and Continue",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetCustomer() {

    String nextCustomer="";
    String prevCustomer="";
    int select = 0;

    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          print("qqqqqqqqqqqqqqqqq${availableCustomerList}");
          var h = MediaQuery.of(context).size.height;
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 450,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Customer Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<DiscountBloc, DiscountState>(
                        builder: (context, state) {
                          if (state is GetCustomerGroupListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is GetCustomerGroupListSuccess) {
                            customerList = state.customerGroup.data;
                            nextCustomer=state.customerGroup.nextPageUrl??"";
                            prevCustomer=state.customerGroup.count??"";
                            print("CUSTOMER GROUP LIST$customerList");
                            print("CUSTOMER GROUP LIST$prevCustomer");
                            print("CUSTOMER GROUP LIST$nextCustomer");

                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: customerList.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        CustomCheckBox(
                                          key: UniqueKey(),
                                          value: customercode
                                              .contains(customerList[index].code),
                                          onChange: (p0) {
                                            if (p0) {
                                              availableCustomerList
                                                  .add(GetTypeApplying(
                                                customerGroupId:
                                                customerList[index].code,
                                                customerGroupCode:
                                                customerList[index].code,
                                              ));
                                              customercode.add(
                                                  customerList[index].code ?? "");
                                            } else {
                                              availableCustomerList
                                                  .remove(GetTypeApplying(
                                                customerGroupId:
                                                customerList[index].code,
                                                customerGroupCode:
                                                customerList[index].code,
                                              ));
                                              customercode.remove(
                                                  customerList[index].code ?? "");
                                            }
                                            print(
                                                "customer list${availableCustomerList}");
                                          },
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          customerList[index].name ?? "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: w / 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    separatorBuilder: (context, index) => Container(
                                      color: ColorPalette.divider,
                                      height: 1,
                                      width: w,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      prevCustomer==null||prevCustomer==""?Text(""):
                                      GestureDetector(
                                        onTap: (){
                                          context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(null,prevCustomer));
                                        },
                                        child: Text(
                                          "Previous",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorPalette.primary,
                                              fontSize: w / 24),
                                        ),
                                      ),
                                      state.customerGroup.nextPageUrl==null?Text(""):
                                      GestureDetector(
                                        onTap: (){
                                          context.read<DiscountBloc>().add(PaginatedCustomerGroupEvent(nextCustomer,null));
                                        },
                                        child: Text(
                                          "Next",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorPalette.primary,
                                              fontSize: w / 24),
                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        refresh();
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
                                        "Select and Continue",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                ],
                              ),
                            );}
                          return Container();
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

  _showModalBottomSheetCustomerSelected() {

    String nextCustomer="";
    String prevCustomer="";
    int select = 0;

    void onselect(int index) {
      setState(() {
        select = index;
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
                height: 450,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Customer Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),


                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              primary: true,
                              shrinkWrap: true,
                              itemCount: selectedCustomerList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      selectedCustomerList[index].customerGroupCode ?? "",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              separatorBuilder: (context, index) => Container(
                                color: ColorPalette.divider,
                                height: 1,
                                width: w,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showModalBottomSheetCustomer();

                                },
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorPalette.primary,
                                      ColorPalette.primary
                                    ]),
                                child: Text(
                                  "Select New",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        ),



                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetNew(BuildContext context, bool edit) {
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
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: h / 1.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        edit ? "Update Offer Period" : "Create Offer Period",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormReusable(
                        label: "Name",
                        hint: "Enter name",
                        controller: title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormReusable(
                        controller: discription,
                        label: "Description",
                        hint: "Enter Description",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormReusable(
                        controller: note,
                        label: "Notes",
                        hint: "Enter Notes",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 300,
                                        child: Scaffold(
                                          body: SfDateRangePicker(
                                            backgroundColor: Colors.white,
                                            endRangeSelectionColor:
                                            ColorPalette.primary,
                                            startRangeSelectionColor:
                                            ColorPalette.primary,
                                            rangeSelectionColor: ColorPalette
                                                .primary
                                                .withOpacity(0.1),
                                            selectionColor: Colors.grey,
                                            todayHighlightColor:
                                            ColorPalette.primary,
                                            onSelectionChanged:
                                            _onSelectionChanged,
                                            selectionMode:
                                            DateRangePickerSelectionMode
                                                .range,
                                            initialSelectedRange:
                                            PickerDateRange(
                                                DateTime.now().subtract(
                                                    const Duration(
                                                        days: 4)),
                                                DateTime.now()
                                                    .add(const Duration(
                                                    days: 3))),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: w / 3,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          alignment: Alignment.center,
                                          color: ColorPalette.primary,
                                          child: Text(
                                            "Ok",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.string(PromotionSvg().calenderIcon),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Start Date",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            _range.isEmpty && fromDate == ""
                                ? Text("Choose Date",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ))
                                : Text(
                              selDate == true
                                  ? _range2.split(" - ")[0]
                                  : edit
                                  ? fromDateView ?? ""
                                  : "",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.string(PromotionSvg().calenderIcon),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "End Date",
                                style: GoogleFonts.roboto(
                                  color: Color(0xff151522),
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          _range.isEmpty && toDate == ""
                              ? Text(
                            "Choose Date",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                              : Text(
                            selDate == true
                                ? _range2.split(" - ")[1]
                                : edit
                                ? toDateView ?? ""
                                : "",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontSize: w / 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      GestureDetector(
                        onTap: _selectTime,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.string(PromotionSvg().clockIcon),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Start Time",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            selTime == false && fromTime == ""
                                ? Text(
                              "Select Time",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                                : Text(
                              selTime == true
                                  ? formattedTime
                                  : edit
                                  ? fromTime ?? ""
                                  : "",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: ColorPalette.divider,
                        thickness: 1.1,
                      ),
                      GestureDetector(
                        onTap: _endTime,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.string(PromotionSvg().clockIcon),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "End Time",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff151522),
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            selTime2 == false && toTime == ""
                                ? Text("Select Time",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.primary,
                                  fontSize: w / 22,
                                  fontWeight: FontWeight.w500,
                                ))
                                : Text(
                              selTime2 == true
                                  ? formattedTime2
                                  : edit
                                  ? toTime ?? ""
                                  : "",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.primary,
                                fontSize: w / 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GradientButton(
                          color: ColorPalette.primary,
                          onPressed: () {
                            edit==true?print("edittttt"):
                            print("creatttt");
                            edit
                                ? BlocProvider.of<DiscountBloc>(context)
                                .add(UpdateOfferPeriodEvent(
                              id: offerperiodRead?.id,
                              isActive: offerperiodRead?.isActive,
                              createdBy: offerperiodRead?.createdBy,
                              description: discription.text ?? "",
                              fromTime: selTime
                                  ? formattedTime
                                  : fromTime.toString(),
                              note: note.text,
                              title: title.text,
                              toDate: selDate
                                  ? _range.split(" - ")[1]
                                  : toDate.toString(),
                              toTime: selTime2
                                  ? formattedTime2
                                  : toTime.toString(),
                              fromDate: selDate
                                  ? _range.split(" - ")[0]
                                  : fromDate.toString(),
                            ))
                                : title.text == "" ||
                                _time.hour == 7 ||
                                _range.isEmpty
                                ? Fluttertoast.showToast(
                                msg: 'Please Check the Fields',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.white,
                                textColor: Colors.black)
                                : BlocProvider.of<DiscountBloc>(context)
                                .add(CreateOfferPeriodEvent(
                                isActive: true,
                                createdBy: authentication.authenticatedUser.code,
                                description: discription.text ?? "",
                                fromTime: formattedTime,
                                note: note.text,
                                title: title.text,
                                toDate: _range.split(" - ")[1],
                                toTime: formattedTime2,
                                fromDate: _range.split(" - ")[0]));
                          },
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorPalette.primary,
                                ColorPalette.primary
                              ]),
                          child: Text(
                            edit ? "Update" : "Create New",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      edit
                          ? GradientButton(
                          color: Colors.white,
                          onPressed: () {
                            BlocProvider.of<DiscountBloc>(context).add(
                                DeleteOfferPeriodEvent(
                                    offerperiodRead?.id ?? 0));
                          },
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white
                              ]),
                          child: Text(
                            "Delete",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: ColorPalette.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                          : Container()
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetOfferPeriod(String? offerPeriodNameNew) {
    int selectIndex = 0;
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
                        "Select Offer Period",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      BlocBuilder<DiscountBloc, DiscountState>(
                        builder: (context, state) {
                          print("SASAFA$state");
                          if (state is GetOfferPeriodListLoading) {
                            Container(
                                width: w,
                                height: 300,
                                child: customCupertinoLoading());
                          }
                          if (state is GetOfferPeriodListSuccess) {
                            print("OZFFDARA${state.offerPeriod.data}");
                            print("OZFFDARA${state.offerPeriod.nextPageUrl}");
                            print("OZFFDARA${state.offerPeriod.count}");
                            print("OZFFDARA${state.offerPeriod.count}");
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.separated(
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: state.offerPeriod.data.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        onselect(index);
                                        setState(() {});
                                        offerperiodId = state.offerPeriod
                                            .data[index].id ??
                                            0;
                                        offerPeriodName = state.offerPeriod
                                            .data[index].title ??
                                            "";
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 8,
                                                      bottom: 10,
                                                      top: 5,
                                                      right: 8),
                                                  child: SvgPicture.string(state
                                                      .offerPeriod
                                                      .data[index]
                                                      .title ==
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
                                                state.offerPeriod.data[index].title ??
                                                    "",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: w / 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {

                                              context.read<DiscountBloc>().add(
                                                  GetOfferPeriodReadEvent(state
                                                      .offerPeriod
                                                      .data[index]
                                                      .id ??
                                                      0));
                                              context.read<DiscountBloc>().add(
                                                  PaginatedOfferPeriodEvent("",""));
                                            },
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorPalette.primary,
                                                  fontSize: w / 24),
                                            ),
                                          )
                                        ],
                                      ),
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
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      state.offerPeriod.count==null?Text(""):
                                      GestureDetector(
                                        onTap: (){
                                          context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent(state.offerPeriod.nextPageUrl??"",state.offerPeriod.count));
                                        },
                                        child: Text(
                                          "Previous",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorPalette.primary,
                                              fontSize: w / 24),
                                        ),
                                      ),
                                      state.offerPeriod.nextPageUrl==null?Text(""):
                                      GestureDetector(
                                        onTap: (){
                                          context.read<DiscountBloc>().add(PaginatedOfferPeriodEvent(state.offerPeriod.nextPageUrl??"",""));
                                        },
                                        child: Text(
                                          "Next",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ColorPalette.primary,
                                              fontSize: w / 24),
                                        ),
                                      ),

                                    ],
                                  ),
                                  GradientButton(
                                      color: ColorPalette.primary,
                                      onPressed: () {
                                        clearData();
                                        _showModalBottomSheetNew(
                                            context, false);
                                      },
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            ColorPalette.primary,
                                            ColorPalette.primary
                                          ]),
                                      child: Text(
                                        "Create New",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
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

  _showModalBottomSheetOfferGroup() {
    final TextEditingController groupName = TextEditingController();
    int select = 0;
    void onselect(int index) {
      setState(() {
        select = index;
      });
    }

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        builder: (context) {
          var w = MediaQuery
              .of(context)
              .size
              .width;
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
                      Text(
                        "Select Offer Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: w / 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              primary: true,
                              shrinkWrap: true,
                              itemCount: offergroupList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          onselect(index);
                                          setState(() {});
                                          offergroupId =
                                              offergroupList[index].id ?? 0;
                                          discountChannelCode =
                                              offergroupList[index]
                                                  .channelCode ?? "";
                                          discountChannelId =
                                              offergroupList[index].channelId ??
                                                  0;
                                          offerGroupName =
                                              offergroupList[index].title ?? "";
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              bottom: 10,
                                              top: 5,
                                              right: 8),
                                          child: SvgPicture.string(
                                              select == index
                                                  ? HomeSvg().radioButtonActive
                                                  : HomeSvg().radioInActive),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        offergroupList[index].title ?? "",
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: w / 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Variable.offerGroupId =
                                              offergroupList[index].id ?? 0;
                                          print(
                                              "OFFFER${Variable.offerGroupId}");
                                          context.read<DiscountBloc>().add(
                                              GetOfferGroupReadEvent(
                                                  offergroupList[index].id ??
                                                      0));
                                          setState(() {});
                                          _showModalBottomSheetGroupCreate(
                                              context, true);
                                        },
                                        child: Text("View", style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.primary,
                                            fontSize: w / 24),),
                                      )
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
                            GradientButton(
                                color: ColorPalette.primary,
                                onPressed: () {
                                  _showModalBottomSheetGroupCreate(
                                      context, false);
                                },
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorPalette.primary,
                                      ColorPalette.primary
                                    ]),
                                child: Text(
                                  "Create New",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: w / 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _showModalBottomSheetGroupCreate(BuildContext context, bool edit) {
    final TextEditingController titlegroup = TextEditingController();
    final TextEditingController discriptiongroup = TextEditingController();
    final TextEditingController note = TextEditingController();
    String? codeChannel;
    String? drop;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var h = MediaQuery
              .of(context)
              .size
              .height;
          var w = MediaQuery
              .of(context)
              .size
              .width;
          return BlocListener<DiscountBloc, DiscountState>(
            listener: (context, state) {
              if (state is GetOfferGroupReadLoading) {
                customCupertinoLoading();
              }
              if (state is GetOfferGroupReadSuccess) {
                offerGroup = state.offerGroup;
                titlegroup.text = state.offerGroup.title ?? "";
                discriptiongroup.text = state.offerGroup.description ?? "";
                codeChannel = state.offerGroup.channelCode ?? "";

                setState(() {

                });
              }
            },
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  height: h / 1.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        edit ? "Update Offer Group" : "Create Offer Group",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FileUploadCard(onTap: () {
                        getCoverImage(
                            ImageSource.gallery);
                      },

                      ),
                      const SizedBox(height: 16,),
                      TextFormReusable(
                        label: "Title",
                        hint: "Enter Title",
                        controller: titlegroup,

                      ),
                      const SizedBox(height: 10,),
                      TextFormReusable(
                        controller: discriptiongroup,
                        label: "Description",
                        hint: "Enter Description",
                      ),
                      const SizedBox(height: 10,),

                      Flex(direction: Axis.vertical,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Channel",
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.black,
                                    fontSize: w / 24,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                Container(
                                    width: w,
                                    padding: const EdgeInsets.only(left: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xffe6ecf0)),
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      icon: const Padding(
                                        padding: EdgeInsets.only(left: 160),
                                        child: Icon(
                                            Icons.arrow_drop_down_circle),
                                      ),
                                      hint: const Text("Select Channel"),
                                      value: drop,
                                      onChanged: (value) {
                                        setState(() {
                                          drop = value;
                                        });
                                      },

                                      items: channelList
                                          .map<DropdownMenuItem<String>>((
                                          ChannelList _value) =>
                                          DropdownMenuItem<String>(
                                              value: _value.channelCode,
                                              child: Text(
                                                _value.channelCode ?? "",)
                                          )).toList(),
                                    )
                                  //     :Padding(
                                  // padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  // child: Text(codeChannel.toString()),
                                  // ),
                                ),
                              ],
                            ),
                          ]),

                      const SizedBox(height: 30,),
                      GradientButton(
                          color: ColorPalette.primary,
                          onPressed: () {
                            edit ? BlocProvider.of<DiscountBloc>(context).add(
                                UpdateOfferGroupEvent(
                                  priority: 0,
                                    id: Variable.offerGroupId,
                                    isActive: offerGroup?.isActive,
                                    createdBy: authentication.authenticatedUser
                                        .code,
                                    description: discriptiongroup.text ?? "",
                                    img: imageId ?? 0,
                                    title: titlegroup.text ?? ""
                                )) :
                            BlocProvider.of<DiscountBloc>(context).add(
                                CreateOfferGroupEvent(
                                  priorty: 0,
                                    isActive: true,
                                    createdBy: authentication.authenticatedUser
                                        .code,
                                    description: discriptiongroup.text ?? "",
                                    title: titlegroup.text,
                                    image: imageId ?? 0,
                                    channelCode: drop ?? "",
                                    inventoryId: authentication
                                        .authenticatedUser.organisationCode ??
                                        ""
                                ));
                          },
                          gradient: const LinearGradient(begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorPalette.primary,
                                ColorPalette.primary
                              ]),
                          child: Text(
                            edit ? "Update" : "Create Group",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      edit ? GradientButton(
                          color: ColorPalette.primary,
                          onPressed: () {
                            BlocProvider.of<DiscountBloc>(context).add(
                                DeleteOfferGroupEvent(
                                    Variable.offerGroupId ?? 0));
                          },
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [ColorPalette.primary, ColorPalette
                                  .primary
                              ]),
                          child: Text(
                            "Delete",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )) : Container()
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> getCoverImage(source) async {
    try {
      final pickedFile = await picker.pickImage(
          source: source, maxHeight: 512, maxWidth: 512);

      cropImage = (pickedFile != null ? File(pickedFile.path) : null)!;

      if (cropImage != null) {
        BlocProvider.of<DiscountBloc>(context)
            .add(PostImageDiscountEvent(cropImage!));
        imageFileName=cropImage?.path.split("_")[1];
      }
      setState(() {
        _cropped = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
