

// import 'dart:html';
import 'dart:html';
import 'dart:math';
import 'dart:html' as html;
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/core/utils/platform_check.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/image_details_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummy_user_list_model.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/videoplayerscreen.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class WebMyChatList extends StatefulWidget {
  final ChatModel messageList;
  final String? msgdate;
  final String? loginUserId;
  final bool isGroup;
  final String? formattedTime;
  final int? activeUsersLength;
  final int? index;
  final String grpchatid;
  final String? roomid;
  final bool? seentick;
  final List<GroupUserList> grpmember;
  final Function( String) ontap;
  final Function? selectionChange;
  const WebMyChatList({super.key,
    required this.messageList,
    this.msgdate,
    this.loginUserId,
    this.isGroup=false,
    this.formattedTime,
    this.activeUsersLength,
    this.index,
    this.grpchatid="",
    this.roomid,
    required this.grpmember,
    this.seentick,
    required this.ontap, this.selectionChange
  });

  @override
  State<WebMyChatList> createState() => _WebMyChatListState();
}

class _WebMyChatListState extends State<WebMyChatList> {
  late String _localPath;
  Map<String, bool> _downloadStatus = {};
  Map<String, bool> _downloadloading = {};

  @override
  void initState() {
    print("activelength chat page ${widget.activeUsersLength}");
    if(widget.messageList!.type=="image"){
      _downloadStatus[widget.messageList!.message??""] = false;
        _downloadloading[widget.messageList!.message??""] = false;
      // _checkDownloaded(widget.messageList!.message??"");
    }


    // TODO: implement initState
    super.initState();
  }



  // void setTrueAtIndex(List<bool> list, int index) {
  //   for (int i = 0; i <widge.length; i++) {
  //     if (i == index) {
  //       list[i] = true;
  //     } else {
  //       list[i] = false;
  //     }
  //   }
  // }
  // Future<void> _checkDownloaded(String imageUrl) async {
  //   _downloadStatus[imageUrl] = false;
  //   _downloadloading[imageUrl] = false;
  //   final directory = await getApplicationDocumentsDirectory();
  //   _localPath = directory.path;
  //   final filePath = '$_localPath/${imageUrl.split('/').last}';
  //   final file = File(filePath);
  //   //  bool exists = await _isImageInGallery(imageUrl);
  //   setState(() {
  //     _downloadStatus[imageUrl] = file.existsSync();
  //     _downloadloading[imageUrl] = file.existsSync();
  //   });
  // }
// Future<bool> _isImageInGallery(String imageUrl) async {
//   try {
//     // Request permission to read external storage
//     if (!(await Permission.storage.request().isGranted)) {
//       throw PlatformException(code: 'PERMISSION_DENIED', message: 'Storage permission not granted');
//     }

//     // Get the pictures directory
//     String picturesDirectory = await getPicturesDirectory( imageUrl);

//     // Check if the image exists in the pictures directory
//     String filePath = '$picturesDirectory/${imageUrl.split('/').last}';
//     bool exists = await File(filePath).exists();

//     return exists;
//   } catch (e) {
//     print('Error checking image existence: $e');
//     return false;
//   }
// }
// Future<String> getPicturesDirectory(String imageUrl) async {
//   try {
//     // Get the external storage directory
//     Directory? externalDir = await getExternalStorageDirectory();
//     if (externalDir == null) {
//       throw Exception('External storage directory not found');
//     }
//      String name=" ${imageUrl.split('?').first.split('/').last}";
//     // Navigate to the pictures directory (assuming it's named "Pictures")
//     String picturesPath = '${externalDir.path}/$name';
//     Directory picturesDir = Directory(picturesPath);
//     if (!await picturesDir.exists()) {
//       throw Exception('Pictures directory not found');
//     }

//     return picturesPath;
//   } catch (e) {
//     print('Error getting pictures directory: $e');
//     rethrow; // Re-throw the error for handling in the caller
//   }
// }


  // Future<void> _downloadImage(String imageUrl) async {
  //  print("download");
  //  _downloadloading[imageUrl] = true;
  //    final response = await http.get(Uri.parse(imageUrl));
  //    final directory = await getApplicationDocumentsDirectory();
  //    _localPath = directory.path;
  //    final filePath = '$_localPath/${imageUrl.split('/').last}';
  //    final file = File(filePath);
  //    await file.writeAsBytes(response.bodyBytes);
  //    _downloadStatus[imageUrl] = true;
  //    await ImageGallerySaver.saveFile(file.path);
  //    // await GallerySaver.saveImage(file.path);
  //    setState(() {});
  //  }




  Future<void> _downloadImage(String imageUrl) async {
    print("download $imageUrl");
    try {
      final response = await html.HttpRequest.request(imageUrl, responseType: 'blob');
      final blob = response.response as html.Blob;
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", imageUrl.split('/').last)
        ..click();
      html.Url.revokeObjectUrl(url);

      // Update your state accordingly
      setState(() {
        _downloadStatus[widget.messageList!.message ?? ""] = true;
        _downloadloading[widget.messageList!.message ?? ""] = true;
      });
    } catch (e) {
      // Handle any errors that occur during the download process
      print("Error downloading image: $e");
    }
  }






  Future<void> _downloadImage1(String imageUrl) async {
    print("download$imageUrl");



    final response = await http.get(Uri.parse(imageUrl),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        // "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
        // "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET,POST, OPTIONS"
      },


    ); // Use suitable HTTP package for web
    final imageData = response.bodyBytes;

    // Simulating saving the image to a file (not possible in web directly)
    final blob = html.Blob([imageData]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", imageUrl.split('/').last)
      ..click();
    html.Url.revokeObjectUrl(url);

    // Update your state accordingly
    setState(() {
      // Update your state here
    });

    // final response = await http.get(Uri.parse(imageUrl));
    // final directory = await getApplicationDocumentsDirectory();
    // _localPath = directory.path;
    // final filePath = '$_localPath/${imageUrl.split('/').last}';
    // final file = File(filePath);
    // await file.writeAsBytes(response.bodyBytes);
    _downloadStatus[imageUrl] = true;
    // await ImageGallerySaver.saveFile(file.path);
    // await GallerySaver.saveImage(file.path);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1 > 700
        ? 400
        : w1;
    var h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment:
      widget.messageList.fromuserid !=
          widget.loginUserId
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        widget.messageList.firstMessageOfDay == true ?
        Padding(
          padding: const EdgeInsets.only(top:5,left: 25,right: 25,bottom: 10),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(top:5,bottom:5,right: 10,left: 10),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(236, 233, 232, 232)
              ),
              child: Column(
                  children:[

                    Text(
                      "${widget.msgdate}",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        color: Color(0xff151522),
                        fontSize: 12,
                      ),
                    )
                    ,]
              ),
            ),
          ),
        ):Container(),

        if (widget.messageList!.fromuserid !=
            widget.loginUserId) ...{
          if (widget.isGroup == false ) ...{
            if (widget.messageList!.type == "image")...{
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height:widget.isselcted==true? 5:0,),
                  InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) {
                        //       return MyPhotoView(
                        //         Path :widget.messageList
                        //             .message ??
                        //             "",
                        //       );
                        //     }));
                      },
                      // onLongPress: widget.ontap,
                      child: Container(
                          width: w / 1.5,
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              Container(
                                key: new PageStorageKey(
                                  "image ${widget.roomid}${widget.messageList.message}",
                                ),
                                constraints: BoxConstraints(
                                  maxHeight:
                                  MediaQuery.of(context)
                                      .size
                                      .height /
                                      2.5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                      Radius.circular(
                                          6),
                                      topRight:
                                      Radius.circular(
                                          6),
                                      bottomLeft:
                                      Radius.circular(
                                          6),
                                      bottomRight:
                                      Radius.circular(
                                          0)),
                                ),
                                width: w,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [

                                    Image(
                                        loadingBuilder:
                                            (context,
                                            child,
                                            loadingProgress) {
                                          if (loadingProgress ==
                                              null)
                                            return child;
                                          return const SizedBox(
                                            child: Center(
                                                child: CircularProgressIndicator(
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                )),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                        image: ResizeImage(policy:ResizeImagePolicy.fit,
                                            NetworkImage(
                                                widget.messageList
                                                    .message ??
                                                    ""),width:700,height:800,allowUpscaling: true)),
                                    Positioned(child:_downloadStatus[widget.messageList.message??""]==false?
                                    BlurryContainer(
                                        color: Color.fromARGB(97, 0, 0, 0),
                                        width: w,
                                        height: h,
                                        borderRadius: BorderRadius.zero,
                                        child:InkWell(
                                            onTap: () {
                                              _downloadloading[widget.messageList.message??""]=true;
                                              _downloadImage(widget.messageList.message??"");
                                              setState(() {

                                              });
                                            },
                                            child:_downloadloading[widget.messageList.message??""]==false?  Padding(
                                              padding:  EdgeInsets.only(right:w/6,left:w/6,top:h/6.1,bottom:h/6.1),
                                              child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white.withOpacity(0.7900000214576721),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(36),
                                                    ),
                                                  ),

                                                  child: SvgPicture.string(CommunicationSvg().imageIcon)),
                                            )
                                                :Padding(
                                              padding:  EdgeInsets.only(right:w/4,left:w/4,top:h/6.1,bottom:h/6.1),
                                              child: InkWell(
                                                onTap: () {
                                                  _downloadImage(widget.messageList.message??"");
                                                },
                                                child: Container(
                                                    width: 50,
                                                    height: 40,
                                                    padding: EdgeInsets.all(10),
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white.withOpacity(0.7900000214576721),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(36),
                                                      ),
                                                    ),

                                                    child:customCupertinoLoading()),
                                              ),
                                            ))
                                    ):SizedBox()),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.formattedTime??"",
                                    style: const TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ))),
                  // SizedBox(height:widget.isselcted==true? 5:0,),
                ],
              )

            } else if (widget.messageList!.type ==
                "audio") ...{
              Stack(
                  children:[
                    Container(

                      key: new PageStorageKey(
                        "audio ${widget.roomid}${widget.messageList!.message}",),
                      child: VoiceMessageView(controller: VoiceController(
                        audioSrc:  widget.messageList.message ?? "",
                        maxDuration: const Duration(hours:5),
                        isFile: false,
                        onComplete: () {},
                        onPause: () {},
                        onPlaying: () {},
                      ),
                        me: false,
                      )
                    ),
                    Positioned(
                      right: 6,
                      bottom: 5,
                      child: Text(
                        widget.formattedTime??"",
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF6D6D6D),
                        ),                                                           ),
                    ),
                  ]
              )

            } else if (widget.messageList!.type ==
                "video") ...{
              Container(
                key: new PageStorageKey(
                  "vedio ${widget.roomid}${widget.messageList!.message}",
                ),
                constraints:  BoxConstraints(
                  maxWidth: 277,
                  maxHeight:
                  MediaQuery.of(context)
                      .size
                      .height /
                      2.5,
                ),
                decoration: BoxDecoration(

                  // RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                    bottomLeft:
                    Radius.circular(10),
                    bottomRight:
                    Radius.circular(10),

                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  // ),
                  color: Colors.white,
                ),

                child:Stack(
                    children:[
                      VideoPlayerScreen(
                        autoplay: false,
                        looping: true,
                        me: false,
                        videoUrl:widget.messageList!.message ?? "",
                        alignmentGeometry: Alignment.topLeft,
                        // videoPlayerController:
                        //     VideoPlayerController.network(
                        //   messageList[index].message ?? "",
                        // ),
                      ),
                      Positioned(
                        right: 6,
                        bottom: 0,
                        child: Text(
                          widget.formattedTime??"",
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF6D6D6D),
                          ),                                                           ),
                      ),
                    ]
                ),
              )


            } else if (widget.messageList!.type ==
                "file") ...{
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  Container(
                    width: w / 1.63,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(11),
                        bottomRight:
                        Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(
                                      8),
                                  color: Colors.white),
                              child: SvgPicture.string(
                                  CommunicationSvg().docIcon2),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: w / 2,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    10),
                                boxShadow: [
                                  const BoxShadow(
                                    color:
                                    Color(0x05000000),
                                    blurRadius: 8,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets
                                  .symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    // messageList[index].message ??
                                      "${ widget.messageList!.message!.split('?').first.split('/').last}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(textStyle:TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),)
                                  ),
                                  const SizedBox(height: 4),
                                  // Text(
                                  //   "21.54 Mb",
                                  //   style: TextStyle(
                                  //     color: Color(0xff333333),
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 3,
                          bottom: -4,
                          child: Text(
                            widget.formattedTime??"",
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xFF6D6D6D),
                            ),                                                           ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () async {
                        final url = widget.messageList!
                            .message ??
                            "";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: SvgPicture.string(
                          CommunicationSvg().dwnldIcon)),
                ],
              ),
            } else ...{
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
                minWidth:
                25,
                maxWidth:
                MediaQuery.of(context)
                    .size
                    .width/3,),
                  child: GestureDetector(
                    onLongPress: (){
                      print("enterreeeeeeeeee");
                      widget.ontap( widget.messageList
                          .message??"");
                    },

                    child: Container(
                      // elevation: 1,
                      decoration: BoxDecoration(
                        // RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(10),
                          bottomLeft:
                          Radius.circular(10),
                          bottomRight:
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        // ),
                        color: Colors.white,
                      ),
                      // shape:

                      // margin: const EdgeInsets.symmetric(
                      //     horizontal: 15, vertical: 5),
                      child: Stack(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(
                              left: 10,
                              right:20,
                              top:7,
                              bottom: 17,
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Theme(data: Theme.of(context).copyWith(
                                    textSelectionTheme: TextSelectionThemeData(
                                        selectionColor:widget.messageList.isSelectable==true? Colors.grey.withOpacity(.2):Colors.transparent)),
                                  child: SelectableLinkify(
                                    onTap: (){
                                      Clipboard.setData(ClipboardData(text: widget.messageList.message ?? ""));
                                      // Fluttertoast.showToast(
                                      //   msg: 'URL copied to clipboard',
                                      //   toastLength: Toast.LENGTH_SHORT,
                                      //   gravity: ToastGravity.BOTTOM,
                                      //   timeInSecForIosWeb: 1,
                                      //   backgroundColor: Colors.grey,
                                      //   textColor: Colors.white,
                                      //   fontSize: 16.0,
                                      // );
                                      print("Akshay selectable");
                                    },
                                    linkifiers:  [

                                      EmailLinkifier(),
                                      UrlLinkifier(),

                                    ],


                                    onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
                                      if (selection.baseOffset != selection.extentOffset) {
                                        if(widget.selectionChange!=null){
                                          widget.selectionChange!(widget.index);
                                        }
                                        // Text is selected

                                      } else {
                                        // Text is not selected
                                        setState(() {
                                          print("testing case in false");
                                        });
                                      }
                                    },
                                    linkStyle: TextStyle(decorationColor: Colors.blue,color: Colors.red),
                                    onOpen: (link) async {
                                      if (!await launchUrl(Uri.parse(link.url))) {
                                        throw Exception('Could not launch ${link.url}');
                                      }
                                    },
                                    text: widget.messageList
                                        .message ??
                                        "",

                                    textAlign: TextAlign.left,





                                    style:  TextStyle(
                                        fontSize:isMobile?w/29:w/27,
                                        color: Colors.black),
                                  ),
                                ),

                                // Text(
                                // widget.messageList!
                                //         .message ??
                                //     "",
                                //     textAlign: TextAlign.left,
                                // style: const TextStyle(
                                //     fontSize: 16,
                                //     color: Colors.black),
                                // ),
                                SizedBox(height: 2,),

                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: Text(
                              widget.formattedTime??"",
                              style: const TextStyle(
                                fontSize: 8,
                                color: Color(0xFF6D6D6D),
                              ),                                                           ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            }
          } else ...{
            if(widget.messageList.type=="notify")...{
              Padding(
                padding: const EdgeInsets.only(top:10,left: 25,right: 25,bottom: 10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top:5,bottom:5,left:5,right:5),
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                    ),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(236, 233, 232, 232)
                    ),
                    child: Text(
                      "${widget.messageList
                          .message.toString()}"
                      ,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 5,
                      style: const TextStyle(
                        color: Color(0xff151522),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )

            } else...{
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: ()async{
                      await showDialog(
                          context: context,
                          builder: (_) => imageDialog(widget.messageList!
                              .fromUser
                              ?.name,widget.messageList!.fromUser!.photo??"",context)
                      );
                    },
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:widget.messageList!.fromUser!.photo ==null ||widget.messageList!.fromUser!.photo!.isEmpty? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius:18,
                            child: TextAvatar(
                              shape: Shape.Circular,
                              size: 14,
                              numberLetters: 2,
                              fontSize: w/23,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              text:"${widget.messageList!.fromUser?.name.toString().toTitleCase()}" ,
                            )
                        ):CircleAvatar(
                          backgroundColor: Colors.white,
                          radius:18,
                          backgroundImage: NetworkImage(widget.messageList!.fromUser!.photo??""),
                        )
                    ),
                  ),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Text(
                        widget.messageList!
                            .fromUser
                            ?.name.toString().toTitleCase() ??
                            "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff151522),
                          fontSize: 12,
                        ),
                      ),

                      if (widget.messageList!.type ==
                          "image") ...{
                        InkWell(
                            onTap: () {
                              _downloadStatus[widget.messageList?.message??""] ==false?null:
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (_) {
                                        return DetailScreen(
                                          image:
                                          widget.messageList!
                                              .message ??
                                              "",
                                        );
                                      }));
                            },
                            child: Container(
                                key:new PageStorageKey(widget.messageList!.message??"") ,
                                width: w / 1.5,
                                padding:
                                const EdgeInsets.all(
                                    4),
                                decoration:
                                const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.only(
                                      topLeft:
                                      Radius.circular(
                                          0),
                                      topRight:
                                      Radius.circular(
                                          10),
                                      bottomLeft:
                                      Radius.circular(
                                          10),
                                      bottomRight:
                                      Radius.circular(
                                          10),
                                    ),
                                    color: Colors.white
                                ),
                                alignment:
                                Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      key: new PageStorageKey(
                                        "image ${widget.roomid}${widget.messageList!.message}",
                                      ),
                                      constraints:
                                      BoxConstraints(
                                        maxHeight: MediaQuery.of(
                                            context)
                                            .size
                                            .height /
                                            2.5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius
                                            .only(
                                            topLeft: Radius
                                                .circular(
                                                0),
                                            topRight: Radius
                                                .circular(
                                                6),
                                            bottomLeft: Radius
                                                .circular(
                                                6),
                                            bottomRight: Radius
                                                .circular(
                                                6)),
                                      ),
                                      width: w,
                                      child: Stack(
                                        children: [
                                          Image(
                                              loadingBuilder:
                                                  (context,
                                                  child,
                                                  loadingProgress) {
                                                if (loadingProgress ==
                                                    null)
                                                  return child;
                                                return const SizedBox(
                                                  child: Center(
                                                      child: CircularProgressIndicator(
                                                        color: Colors.blue,
                                                      )),
                                                );
                                              },
                                              fit: BoxFit.fill,
                                              image: ResizeImage(policy:ResizeImagePolicy.fit,  NetworkImage(
                                                  widget.messageList!
                                                      .message ??
                                                      ""),width:500,height:500,allowUpscaling: true)),
                                          Positioned(child:_downloadStatus[widget.messageList?.message??""] ==false? BlurryContainer(color: Colors.transparent,

                                            child: Container(

                                                height: 20,
                                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        // _downloadImage(widget.messageList!
                                                        //     .message ??
                                                        // "");
                                                      } ,

                                                      child: Card(
                                                          color: Color.fromARGB(147, 255, 255, 255),
                                                          child:_downloadStatus[widget.messageList?.message??""]==false? Row(
                                                            children: [
                                                              Icon(Icons.download,size: 36,),
                                                              Text("download",style: TextStyle(fontWeight: FontWeight.w400),),
                                                              SizedBox(width: 2,)
                                                            ],
                                                          ):customCupertinoLoading()
                                                      ),
                                                    ),
                                                  ],
                                                )

                                            ),

                                            height:
                                            MediaQuery.of(context)
                                                .size
                                                .height /
                                                2.5,

                                            width: w,):SizedBox())
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .end,
                                      children: [
                                        Text(
                                          widget.formattedTime??"",
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Color(0xFF6D6D6D),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )))
                      } else if (widget.messageList!
                          .type ==
                          "audio") ...{

                        Stack(
                            children:[
                              Container(

                                key: new PageStorageKey(
                                  "image ${widget.roomid}${widget.messageList!.message}",),
                                child: VoiceMessageView(controller: VoiceController(
                                  audioSrc:  widget.messageList.message ?? "",
                                  maxDuration: const Duration(hours:5),
                                  isFile: false,
                                  onComplete: () {},
                                  onPause: () {},
                                  onPlaying: () {},
                                ),
                                  me: false,
                                )
                              ),
                              Positioned(
                                right: 6,
                                bottom: 5,
                                child: Text(
                                  widget.formattedTime??"",
                                  //   messageList[index]
                                  //     .createdAt ??
                                  // "",
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Color(0xFF6D6D6D),
                                  ),
                                ),
                              ),
                            ]
                        )

                      } else if (widget.messageList!
                          .type ==
                          "file") ...{
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Container(
                              width: w / 1.6,
                              padding: const EdgeInsets
                                  .symmetric(
                                  vertical: 10,
                                  horizontal: 8),
                              decoration:
                              const BoxDecoration(
                                borderRadius:
                                BorderRadius.only(
                                  topLeft:
                                  Radius.circular(0),
                                  topRight:
                                  Radius.circular(10),
                                  bottomLeft:
                                  Radius.circular(10),
                                  bottomRight:
                                  Radius.circular(10),
                                ),
                                color: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                8),
                                            color:
                                            Colors.white),
                                        child:
                                        SvgPicture.string(
                                            CommunicationSvg()
                                                .docIcon2),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: w / 2,
                                        height: 45,
                                        decoration:
                                        BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              10),
                                          boxShadow: [
                                            const BoxShadow(
                                              color: Color(
                                                  0x05000000),
                                              blurRadius: 8,
                                              offset: Offset(
                                                  1, 1),
                                            ),
                                          ],
                                          color: Colors.white,
                                        ),
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              // messageList[index]
                                              //         .message ??
                                              "${ widget.messageList!.message!.split('?').first.split('/').last}",
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                              GoogleFonts.roboto(textStyle: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontSize:13,
                                              ),
                                              ),
                                            ),
                                            const SizedBox(
                                                height: 4),
                                            // Text(
                                            //   "21.54 Mb",
                                            //   style: TextStyle(
                                            //     color: Color(0xff333333),
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: 3,
                                    bottom: -4,
                                    child: Text(
                                      widget.formattedTime??"",
                                      //   messageList[index]
                                      //     .createdAt ??
                                      // "",
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF6D6D6D),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  final url =
                                      widget.messageList!
                                          .message ??
                                          "";
                                  if (await canLaunch(
                                      url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.string(
                                  CommunicationSvg().dwnldIcon,)),
                          ],
                        ),
                      } else if (widget.messageList!
                          .type ==
                          "video") ...{
                        Container(
                          constraints:  BoxConstraints(
                            maxWidth: 277,
                            maxHeight:
                            MediaQuery.of(context)
                                .size
                                .height /
                                2.5,
                          ),
                          decoration: BoxDecoration(

                            // RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(10),
                              bottomLeft:
                              Radius.circular(10),
                              bottomRight:
                              Radius.circular(10),

                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            // ),
                            color: Colors.white,
                          ),
                          key: new PageStorageKey(
                            "vedio ${widget.roomid}${widget.messageList!.message}",
                          ),
                          child:Stack(
                              children:[
                                VideoPlayerScreen(
                                  autoplay: false,
                                  looping: true,
                                  me: false,
                                  videoUrl: widget.messageList!.message ?? "",
                                  alignmentGeometry: Alignment.topLeft,
                                  // videoPlayerController:
                                  //     VideoPlayerController.network(
                                  //   messageList[index].message ?? "",
                                  // ),
                                ),
                                Positioned(
                                  right: 6,
                                  bottom: 0,
                                  child: Text(
                                    widget.formattedTime??"",
                                    style: const TextStyle(
                                      fontSize: 8,
                                      color: Color(0xFF6D6D6D),
                                    ),                                                           ),
                                ),
                              ]
                          ),
                        )

                      } else if(widget.messageList!
                          .type ==
                          "mention")...{
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                constraints: BoxConstraints(
                                  minWidth:
                                  25,
                                  maxWidth:
                                  MediaQuery.of(context)
                                      .size
                                      .width/3,),
                                child: GestureDetector(
                                  onLongPress: (){ widget.ontap( widget.messageList
                                      .message??"");},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(10),
                                        bottomLeft:
                                        Radius.circular(10),
                                        bottomRight:
                                        Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: Offset(0, 1), // changes position of shadow
                                        ),
                                      ],
                                      // ),
                                      color: Colors.white,
                                    ),
                                    // margin: const EdgeInsets
                                    //         .symmetric(
                                    //     horizontal: 15,
                                    //     vertical: 5),
                                    child:  Stack(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            left: 10,
                                            right:20,
                                            top:7,
                                            bottom: 17,
                                          ),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              MentionText(
                                                text: widget.messageList! .message ??"",
                                                grpmember: widget.grpmember,
                                                mentionStyle: TextStyle(color: getRandomColor(),fontSize:PlatformUtils.isMobile? w/29:w/27),),
                                              // Text(
                                              // widget.messageList!
                                              //         .message ??
                                              //     "",
                                              //     softWrap: true,
                                              //     textAlign: TextAlign.left,
                                              // style: const TextStyle(
                                              //     fontSize: 16,
                                              //     color: Colors.black),
                                              // ),
                                              SizedBox(height: 5,),

                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 6,
                                          bottom: 5,
                                          child: Text(
                                            widget.formattedTime??"",
                                            //   messageList[index]
                                            //     .createdAt ??
                                            // "",
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Color(0xFF6D6D6D),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       messageList[index]
                              //               .createdAt ??
                              //           "",
                              //       style: const TextStyle(
                              //           fontSize: 13,
                              //           color: Color(
                              //               0xFF6D6D6D)),
                              //     ),
                              //   ],
                              // ),
                            ])
                      }
                      else ...{
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  constraints: BoxConstraints(
                                    minWidth:
                                    25,
                                    maxWidth:
                                    MediaQuery.of(context)
                                        .size
                                        .width/3,
                                  ),
                                  child: GestureDetector(
                                    onLongPress: (){
                                      widget.ontap( widget.messageList
                                          .message??"");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(10),
                                          bottomLeft:
                                          Radius.circular(10),
                                          bottomRight:
                                          Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: Offset(0, 1), // changes position of shadow
                                          ),
                                        ],
                                        // ),
                                        color: Colors.white,
                                      ),
                                      // margin: const EdgeInsets
                                      //         .symmetric(
                                      //     horizontal: 15,
                                      //     vertical: 5),
                                      child:  Stack(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                              left: 10,
                                              right:20,
                                              top:7,
                                              bottom: 17,
                                            ),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                               Theme(data: Theme.of(context).copyWith(
                                                    textSelectionTheme: TextSelectionThemeData(
                                                      selectionHandleColor: Colors.orange,
                                                        selectionColor:widget.messageList.isSelectable==true? Colors.grey.withOpacity(.2):Colors.transparent)),
                                                  child: SelectableLinkify(
                                                    onTap: (){
                                                      Clipboard.setData(ClipboardData(text: widget.messageList.message ?? ""));
                                                      // Fluttertoast.showToast(
                                                      //   msg: 'URL copied to clipboard',
                                                      //   toastLength: Toast.LENGTH_SHORT,
                                                      //   gravity: ToastGravity.BOTTOM,
                                                      //   timeInSecForIosWeb: 1,
                                                      //   backgroundColor: Colors.grey,
                                                      //   textColor: Colors.white,
                                                      //   fontSize: 16.0,
                                                      // );
                                                      print("Akshay selectable");
                                                    },
                                                    linkifiers:  [

                                                      EmailLinkifier(),
                                                      UrlLinkifier(),

                                                    ],
                                                    onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
                                                      if (selection.baseOffset != selection.extentOffset) {
                                                        // Text is selected
                                                        if(widget.selectionChange!=null){
                                                          widget.selectionChange!(widget.index);
                                                        }
                                                      } else {
                                                        // Text is not selected
                                                        setState(() {
                                                          print("testing case in false");
                                                        });
                                                      }
                                                    },
                                                    linkStyle: TextStyle(decorationColor: Colors.blue,color: Colors.white,),
                                                    onOpen: (link) async {
                                                      if (!await launchUrl(Uri.parse(link.url))) {
                                                        throw Exception('Could not launch ${link.url}');
                                                      }
                                                    },
                                                    text: widget.messageList
                                                        .message ??
                                                        "",

                                                    textAlign: TextAlign.left,
                                                    style:  TextStyle(
                                                        fontSize: PlatformUtils.isMobile?w/29:w/27,
                                                        color: Colors.black),),
                                                ),
                                                // Text(
                                                // widget.messageList!
                                                //         .message ??
                                                //     "",
                                                //     softWrap: true,
                                                //     textAlign: TextAlign.left,
                                                // style: const TextStyle(
                                                //     fontSize: 16,
                                                //     color: Colors.black),
                                                // ),
                                                SizedBox(height: 5,),

                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 6,
                                            bottom: 5,
                                            child: Text(
                                              widget.formattedTime??"",
                                              //   messageList[index]
                                              //     .createdAt ??
                                              // "",
                                              style: const TextStyle(
                                                fontSize: 8,
                                                color: Color(0xFF6D6D6D),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       messageList[index]
                                //               .createdAt ??
                                //           "",
                                //       style: const TextStyle(
                                //           fontSize: 13,
                                //           color: Color(
                                //               0xFF6D6D6D)),
                                //     ),
                                //   ],
                                // ),
                              ])
                        }
                    ],
                  ),
                ],
              )


            }
          }
        }

        else ...{
          if(widget.messageList!.type=="notify")...{
            Padding(
              padding:  EdgeInsets.only(top:10,left: 25,right: 25,bottom:10),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top:5,bottom:5,right: 10,left: 10),
                  constraints: const BoxConstraints(
                    maxWidth: 250,
                  ),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(236, 233, 232, 232)
                  ),
                  child: Center(
                    child: Text(
                      "${widget.messageList!
                          .message.toString()}"

                      ,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 5,
                      style: const TextStyle(
                        color: Color(0xff151522),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
          }
          else if (widget.messageList!.type == "image") ...{

            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) {
                        return DetailScreen(
                          image:
                          widget.messageList!.message ??
                              "",
                        );
                      }));
                },
                child: Container(
                    width: w / 1.5,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
                      color: ColorPalette.primary,
                    ),
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        Container(
                          key: new PageStorageKey(
                            "image ${widget.roomid}${widget.messageList!.message}",
                          ),
                          constraints: BoxConstraints(
                            maxHeight:
                            MediaQuery.of(context)
                                .size
                                .height /
                                2.5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                Radius.circular(
                                    6),
                                topRight:
                                Radius.circular(
                                    6),
                                bottomLeft:
                                Radius.circular(
                                    6),
                                bottomRight:
                                Radius.circular(
                                    0)),
                          ),
                          width: w,
                          child: Image(
                              loadingBuilder:
                                  (context,
                                  child,
                                  loadingProgress) {
                                if (loadingProgress ==
                                    null)
                                  return child;
                                return const SizedBox(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      )),
                                );
                              },
                              fit: BoxFit.cover,
                              image: ResizeImage(policy:ResizeImagePolicy.fit,
                                  NetworkImage(
                                      widget.messageList!
                                          .message ??
                                          ""),width:500,height:500,allowUpscaling: true)),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.formattedTime??"",
                              style: const TextStyle(
                                fontSize: 8,
                                color: Color.fromARGB(255, 211, 209, 209),
                              ),
                            ),
                            SizedBox(width: 5,),
                            if(widget.grpchatid=="")...{
                              if(widget.activeUsersLength! >=2)...{
                                Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                              }
                              else if(widget.activeUsersLength! == 1 && widget.messageList!.seenBy == null )...{
                                SizedBox()
                              }
                              else...{
                                  widget.messageList!.seenBy!.isEmpty?
                                  SizedBox():
                                  Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)

                                }
                            } else...{
                              SizedBox()
                            }
                          ],
                        ),
                      ],
                    )))
          } else if (widget.messageList!.type ==
              "audio") ...{
            Stack(
                children:[
                  Container(

                    key: new PageStorageKey(
                      "image ${widget.roomid}${widget.messageList!.message}",),
                    child: VoiceMessageView(controller: VoiceController(
                      audioSrc:  widget.messageList.message ?? "",
                      maxDuration: const Duration(hours:5),
                      isFile: false,
                      onComplete: () {},
                      onPause: () {},
                      onPlaying: () {},
                    ),
                      me: true,
                    )
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Row(
                      children: [
                        Text(
                          widget.formattedTime??"",
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color.fromARGB(255, 211, 209, 209),
                          ),
                        ),
                        SizedBox(width: 5,),
                        if(widget.grpchatid=="")...{
                          if(widget.activeUsersLength! >=2)...{
                            Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                          }
                          else if(widget.activeUsersLength! == 1&& widget.messageList!.seenBy == null )...{
                            SizedBox()
                          }
                          else...{
                              widget.messageList!.seenBy!.isEmpty?
                              SizedBox():
                              Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)

                            }
                        } else...{
                          SizedBox()
                        }


                      ],
                    ),
                  ),
                ]
            )

          } else if (widget.messageList!.type ==
              "file") ...{
            Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () async {
                            final url =
                            widget.messageList!.message.toString();
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: SvgPicture.string(
                            CommunicationSvg().dwnldIcon,)),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                            ),
                            color: ColorPalette.primary),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 8,),
                                SizedBox(
                                  width: 34,
                                  height: 36,
                                  child: SvgPicture.string(
                                    CommunicationSvg().docIcon2,color: Colors.white,),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: w / 1.8,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Color(0x05000000),
                                        blurRadius: 8,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                    color: ColorPalette.primary,
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15,),
                                      Text(
                                        // messageList[index]
                                        //         .message ??
                                          "${ widget.messageList!.message!.split('?').first.split('/').last}",
                                          overflow:TextOverflow.ellipsis ,
                                          // textScaler:TextScaler.linear(textScaleFactor) ,
                                          style:GoogleFonts.roboto (textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize:13,
                                          ),)
                                      ),
                                      Text(
                                        "${ widget.messageList!.message!.split('?').first.split('.').last.toString().toUpperCase()}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: Row(
                                children: [
                                  Text(
                                    widget.formattedTime??"",
                                    style: const TextStyle(
                                      fontSize: 8,
                                      color: Color.fromARGB(255, 211, 209, 209),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  if(widget.grpchatid=="")...{
                                    if(widget.activeUsersLength! >= 2)...{
                                      Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                    }
                                    else if(widget.activeUsersLength! ==1 && widget.messageList!.seenBy == null )...{
                                      SizedBox()
                                    }
                                    else...{
                                        widget.messageList!.seenBy!.isEmpty?
                                        SizedBox():
                                        Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)

                                      }
                                  } else...{
                                    SizedBox()
                                  }


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ]),
          } else if (widget.messageList!.type ==
              "video") ...{
            Container(
              constraints:  BoxConstraints(
                maxWidth: 277,
                maxHeight:
                MediaQuery.of(context)
                    .size
                    .height /
                    2.5,
              ),
              decoration: BoxDecoration(

                // RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft:
                  Radius.circular(10),
                  bottomRight:
                  Radius.circular(0),

                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
                // ),
                color: ColorPalette.primary,
              ),
              key: new PageStorageKey(
                "vedio ${widget.roomid}${widget.messageList!.message}",
              ),
              child: Stack(
                  children:[
                    VideoPlayerScreen(
                      me:true,
                      autoplay: false,
                      looping: true,
                      alignmentGeometry: Alignment.topRight,
                      videoUrl: widget.messageList!.message ??
                          "",
                      // videoPlayerController:
                      //     VideoPlayerController.network(
                      //   messageList[index].message ?? "",
                      // ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 0,
                      child: Row(
                        children: [
                          Text(
                            widget.formattedTime??"",
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color.fromARGB(255, 211, 209, 209),
                            ),
                          ),
                          SizedBox(width: 5,),
                          if(widget.grpchatid=="")...{
                            if(widget.activeUsersLength! >= 2)...{
                              Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                            }
                            else if(widget.activeUsersLength! ==1 && widget.messageList!.seenBy == null )...{
                              SizedBox()
                            }
                            else...{
                                widget.messageList!.seenBy!.isEmpty?
                                SizedBox():
                                Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)

                              }
                          } else...{
                            SizedBox()
                          }


                        ],
                      ),
                    ),
                  ]
              ),
            ),


          } else if(widget.messageList!.type ==
              "mention")...{
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                  minWidth:
                  25,
                  maxWidth:
                  MediaQuery.of(context)
                      .size
                      .width/1.5,
                ),
                child: GestureDetector(
                  onLongPress: ()=> widget.ontap( widget.messageList
                      .message??""),

                  child: Container(
                    decoration: BoxDecoration(
                      // RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft:
                        Radius.circular(10),
                        bottomRight:
                        Radius.circular(0),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      // ),
                      color: ColorPalette.primary,
                    ),

                    // margin:
                    //     const EdgeInsets.symmetric(
                    //         horizontal: 10,
                    //         vertical: 5),
                    child:  Stack(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(
                            left: 10,
                            right:20,
                            top:7,
                            bottom:16,
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MentionText(
                                text: widget.messageList.message ??"",
                                grpmember: widget.grpmember,
                                mentionStyle: TextStyle(color: Color(0xFFF1D302),fontSize: PlatformUtils.isMobile? w/29:w/27),
                                color: true,),
                              // Text(
                              // widget.messageList!
                              //         .message ??
                              //     "",
                              //     textAlign: TextAlign.left,
                              // style: const TextStyle(
                              //     fontSize: 16,
                              //     color: Color.fromARGB(255, 94, 206, 90)),
                              // ),

                              SizedBox(height: 5,)
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: Row(
                            children: [
                              Text(
                                widget.formattedTime??"",
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Color.fromARGB(255, 211, 209, 209),
                                ),
                              ),
                              SizedBox(width: 5,),
                              if(widget.grpchatid=="")...{
                                if(widget.activeUsersLength!>= 2)...{
                                  Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                }
                                else if(widget.activeUsersLength! ==1 && widget.messageList.seenBy == null )...{
                                  SizedBox()
                                }
                                else...{
                                    widget.messageList.seenBy!.isEmpty?
                                    SizedBox():
                                    Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)

                                  }
                              } else...{
                                SizedBox()
                              }


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          }
          else ...{
              Align(
                alignment: Alignment.centerRight,
                child:
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    minWidth:
                    25,
                    maxWidth:
                    MediaQuery.of(context)
                        .size
                        .width/3,
                  ),
                  child: GestureDetector(
                    onLongPress: (){
    widget.ontap( widget.messageList
        .message??"");

    },
                    child: Container(
                      decoration: BoxDecoration(
                        // RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft:
                          Radius.circular(10),
                          bottomRight:
                          Radius.circular(0),
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        // ),
                        color: ColorPalette.primary,
                      ),

                      // margin:
                      //     const EdgeInsets.symmetric(
                      //         horizontal: 10,
                      //         vertical: 5),
                      child:  Stack(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(
                              left: 10,
                              right:20,
                              top:7,
                              bottom:16,
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [


                                  Theme(data: Theme.of(context).copyWith(
                                      textSelectionTheme: TextSelectionThemeData(
                                          selectionHandleColor: Colors.orange,
                                          selectionColor:widget.messageList.isSelectable==true? Colors.white.withOpacity(.2):Colors.transparent)),
                                    child: SelectableLinkify(
                                    onTap: (){
                                      Clipboard.setData(ClipboardData(text: widget.messageList.message ?? ""));
                                      // Fluttertoast.showToast(
                                      //   msg: 'URL copied to clipboard',
                                      //   toastLength: Toast.LENGTH_SHORT,
                                      //   gravity: ToastGravity.BOTTOM,
                                      //   timeInSecForIosWeb: 1,
                                      //   backgroundColor: Colors.grey,
                                      //   textColor: Colors.white,
                                      //   fontSize: 16.0,
                                      // );
                                      print("Akshay selectable");
                                    },
                                      options: LinkifyOptions(
                                          humanize: false
                                      ),
                                      linkifiers:  [

                                        EmailLinkifier(),
                                        UrlLinkifier(),

                                      ],
                                      onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
                                        if (selection.baseOffset != selection.extentOffset) {
                                          // Text is selected
                                          if(widget.selectionChange!=null){
                                            widget.selectionChange!(widget.index);
                                          }
                                        } else {
                                          // Text is not selected
                                          setState(() {
                                            print("testing case in false");
                                          });
                                        }
                                      },
                                      linkStyle: TextStyle(color: Color.fromARGB(255, 219, 246, 244),decorationColor: Color.fromARGB(255, 219, 246, 244)),
                                      onOpen: (link) async {
                                        if (!await launchUrl(Uri.parse(link.url))) {
                                          throw Exception('Could not launch ${link.url}');
                                        }
                                      },
                                      text: widget.messageList.message ??"",

                                      textAlign: TextAlign.left,
                                      style:  TextStyle(
                                          fontSize: PlatformUtils.isMobile?w/29:w/27,
                                          color:Colors.white),),
                                  ),
                                // Text(
                                // widget.messageList!
                                //         .message ??
                                //     "",
                                //     textAlign: TextAlign.left,
                                // style: const TextStyle(
                                //     fontSize: 16,
                                //     color: Color.fromARGB(255, 255, 255, 255)),
                                // ),

                                SizedBox(height: 5,)
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: Row(
                              children: [
                                Text(
                                  widget.formattedTime??"",
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Color.fromARGB(255, 211, 209, 209),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                if(widget.grpchatid=="")...{
                                  if(widget.activeUsersLength!>= 2)...{
                                    Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)
                                  }
                                  else if(widget.activeUsersLength! ==1 && widget.messageList.seenBy == null )...{
                                    SizedBox()
                                  }
                                  else...{
                                      widget.messageList.seenBy!.isEmpty?
                                      SizedBox():
                                      Icon(Icons.done,color: Color.fromARGB(255, 211, 209, 209),size: 13,)

                                    }
                                } else...{
                                  SizedBox()
                                }


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            }
        },
        // totpage>1 &&  messageList[index].lastMessageOfDay == true?
        // Padding(
        //      padding: const EdgeInsets.only(top:5,left: 25,right: 25,bottom: 10),
        //      child: Center(
        //        child: Container(
        //          padding: EdgeInsets.only(top:5,bottom:5,right: 10,left: 10),

        //          decoration: BoxDecoration(
        //            borderRadius: BorderRadius.circular(20),
        //            color: Color.fromARGB(236, 233, 232, 232)
        //          ),
        //          child: Column(
        //            children:[

        //             Text(
        //                     "$msgdate",
        //                          textAlign: TextAlign.center,
        //                          softWrap: true,
        //                          maxLines: 3,
        //                      style: const TextStyle(
        //                        color: Color(0xff151522),
        //                        fontSize: 12,
        //                      ),
        //                    )
        //                    ,]
        //          ),
        //        ),
        //      ),
        //    ):Container(),
      ],
    );
  }
  Widget buildMessage(String message) {
    List<String> words = message.split(' '); // Split message by spaces

    List<Widget> wordWidgets = [];
    for (String word in words) {
      // Check if the word meets your condition (e.g., starts with '@')
      Color color = word.startsWith('@') ? Colors.red : Colors.black;

      // Create a Text widget for the word with the specified color
      Widget wordWidget = Text(
        '$word ',
        style: TextStyle(color: color),
      );

      wordWidgets.add(wordWidget);
    }

    // Use the Wrap widget to display the words in a line
    return Wrap(
      children: wordWidgets,
    );
  }

  Widget imageDialog(text, path,context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  child: Center(
                    child: Text(
                      '${text.toString().toTitleCase()}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0,right: 8.0,left: 8.0,bottom:25),
            child: Container(
              width: MediaQuery.of(context).size.width/5,
              height: MediaQuery.of(context).size.height/3,
              child:
              path==""?TextAvatar(
                shape: Shape.Circular,
                size: 20,
                numberLetters: 2,
                fontSize: MediaQuery.of(context).size.width/5,
                textColor: Colors.white,
                fontWeight: FontWeight.w500,
                text:"${text.toString().toUpperCase()}" ,
              )
                  :Image.network(
                '$path',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Color getRandomColor() {
    // Generate random RGB values between 0 and 255
    final random = Random();
    final r = random.nextInt(256);
    final g = random.nextInt(256);
    final b = random.nextInt(256);

    // Create and return a Color object with the random RGB values
    return Colors.blue;
  }

}


class MentionText extends StatelessWidget {
  final String text;
  final List<GroupUserList> grpmember;
  final TextStyle mentionStyle;
  final bool  color;


  MentionText({required this.text,required this.grpmember,required this.mentionStyle,this.color=false});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    RegExp regExp = RegExp(r"(@\w+)");
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    int start = 0;
    for (RegExpMatch match in matches) {
      String mention = match.group(0)!;
      String prefix = text.substring(start, match.start);
      textSpans.add(TextSpan(text: prefix));
      String mentionWithoutAt = mention.substring(1).trim();
      bool mentionFound = false;
      for (int i = 0; i < grpmember.length; i++) {
        List<String> names = grpmember[i].name!.split(" ");
        if (names.length > 2) {
          names = [names.first, names[1]];
        }
        String formattedFullName = names.map((name) => name.trim()).join('');
        String fullName1 = "$formattedFullName";
        String fullName = "$fullName1";
        print("mention $fullName");
        if (fullName == mentionWithoutAt) {
          textSpans.add(TextSpan(
            text: mention,
            style: mentionStyle,
          ));
          mentionFound = true;
          break;
        }
      }
      if (!mentionFound) {
        textSpans.add(TextSpan(text: mention));
      }

      start = match.end;
    }

    if (start < text.length) {
      textSpans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(children: textSpans ,style: TextStyle(color:color==true?Colors.white:Colors.black,)),
    );
  }
}


// class CustomSelectableLinkify extends StatefulWidget {
//   final String text;
//   final TextStyle? style;
//   final Color selectedTextColor;
//
//   const CustomSelectableLinkify({
//     Key? key,
//     required this.text,
//     this.style,
//     this.selectedTextColor = Colors.blue, // Default selected text color
//   }) : super(key: key);
//
//   @override
//   _CustomSelectableLinkifyState createState() => _CustomSelectableLinkifyState();
// }
//
// class _CustomSelectableLinkifyState extends State<CustomSelectableLinkify> {
//   late final FocusNode _focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SelectableLinkify(
//       text: widget.text,
//       style: widget.style,
//       focusNode: _focusNode,
//       onTap: () {
//         // When text is tapped, ensure that the widget gets the focus
//         _focusNode.requestFocus();
//       },
//       onOpen: (_) {
//         // When link is tapped, ensure that the widget gets the focus
//         _focusNode.requestFocus();
//       },
//       linkStyle: TextStyle(color: Colors.blue), // Default link color
//       onTextHighlightChanged: (isHighlighted) {
//         setState(() {});
//       },
//       textSelectionControls: CustomTextSelectionControls(
//         selectionColor: widget.selectedTextColor,
//       ),
//     );
//   }
// }

class CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Color selectionColor;

  CustomTextSelectionControls({
    required this.selectionColor,
  });

  @override
  Color get handleColor => Colors.blue; // Default handle color

  @override
  Color getToolbarColor(BuildContext context) {
    return selectionColor; // Custom selected text color
  }
}


