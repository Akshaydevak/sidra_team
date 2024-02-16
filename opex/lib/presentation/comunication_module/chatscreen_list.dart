import 'package:cached_network_image/cached_network_image.dart';
import 'package:cluster/common_widgets/string_extensions.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/presentation/comunication_module/chat_screen/image_details_screen.dart';
import 'package:cluster/presentation/comunication_module/com_svg.dart';
import 'package:cluster/presentation/comunication_module/models/communicationuser_model.dart';
import 'package:cluster/presentation/comunication_module/videoplayerscreen.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voice_message_package/voice_message_package.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';


class MyChatList extends StatefulWidget {
  final ChatModel? messageList;
  final String? msgdate;
  final String? loginUserId;
  final bool isGroup;
  final String? formattedTime;
  final int? activeUsersLength;
  final int? index;
  final String grpchatid;
  final String? roomid;
  final bool? seentick;
  const MyChatList({super.key, 
  this.messageList,
  this.msgdate,
  this.loginUserId,
  this.isGroup=false,
  this.formattedTime,
  this.activeUsersLength,
  this.index,
  this.grpchatid="",
  this.roomid,
  this.seentick
  });

  @override
  State<MyChatList> createState() => _MyChatListState();
}

class _MyChatListState extends State<MyChatList> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
                                    crossAxisAlignment:
                                       widget.messageList!.fromuserid !=
                                                widget.loginUserId
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                                    children: [
                                    widget.messageList!.firstMessageOfDay == true ?
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
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (_) {
                                                    return DetailScreen(
                                                      image:widget.messageList!
                                                              .message ??
                                                          "",
                                                    );
                                                  }));
                                                },
                                                child: Container(
                                                  key: new PageStorageKey(
                                  "image ${widget.roomid}${widget.messageList!.message}",
                                ),
                                                    width: w / 1.5,
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(0),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    alignment: Alignment.topLeft,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          constraints: BoxConstraints(
                                                            maxHeight:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height /
                                                                    2.5,
                                                          ),
                                                          width: w,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .only(
                                                                    topLeft: Radius
                                                                        .circular(0),
                                                                    topRight: Radius
                                                                        .circular(6),
                                                                    bottomLeft: Radius
                                                                        .circular(6),
                                                                    bottomRight:
                                                                        Radius
                                                                            .circular(
                                                                                6)),
                                                            child: 
                                                            // CachedNetworkImage(
                                                            //  height: MediaQuery.of(
                                                            //                     context)
                                                            //                 .size
                                                            //                 .height /
                                                            //             3 ,
                                                            //       imageUrl: "${widget.messageList!.message}",
                                                            //       placeholder: (context, url) => Padding(
                                                            //         padding: const EdgeInsets.all(200),
                                                            //         child: CircularProgressIndicator(color: ColorPalette.primary,),
                                                            //       ),
                                                            //       errorWidget: (context, url, error) => Icon(Icons.error),
                                                            //       fit: BoxFit.cover,
                                                            //   ),
                                                            Image(
                                                                loadingBuilder: (context,
                                                                    child,
                                                                    loadingProgress) {
                                                                  if (loadingProgress ==
                                                                      null)
                                                                    return child;
                                                                  return const SizedBox(
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                            color: Colors
                                                                                .white)),
                                                                  );
                                                                },
                                                                fit: BoxFit.fill,
                                                                image:ResizeImage( NetworkImage(
                                                                    widget.messageList!
                                                                            .message ??
                                                                        ""),width: 500,height:400,allowUpscaling: true,policy: ResizeImagePolicy.fit)
                                                                ),
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
                                                                          color: Color(0xFF6D6D6D),
                                                                        ),
                                                                      ),
                                                                      
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
                                                      child: VoiceMessage(
                                                          audioSrc:
                                                              widget.messageList!.message ?? "",
                                                          played:
                                                              false, // To show played badge or not.
                                                          me: false, // Set message side.
                                                          onPlay:
                                                              () {}, // Do something when voice played.
                                                        ),
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
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      300,
                                                  maxWidth: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      95,
                                                ),
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
                                                            Text(
                                                            widget.messageList!
                                                                    .message ??
                                                                "",
                                                                textAlign: TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black),
                                                            ),
                                                            SizedBox(height: 5,),
                                                           
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
                                            )
                                          }
                                        } else ...{
                                          if(widget.messageList!.type=="notify")...{
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
                                         )
                                                   
                                                   } else...{
                                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                            Align(
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
                                                                            color: Colors.blue,
                                                                          )),
                                                                        );
                                                                      },
                                                                      fit: BoxFit.fill,
                                                                      image: ResizeImage(policy:ResizeImagePolicy.fit,  NetworkImage(
                                                                  widget.messageList!
                                                                          .message ??
                                                                      ""),width:500,height:500,allowUpscaling: true)),
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
                                                              child: VoiceMessage(
                                                                audioSrc: widget.messageList!.message ??
                                                                    "",
                                                                played:
                                                                    false, // To show played badge or not.
                                                                me: false, // Set message side.
                                                                onPlay:
                                                                    () {}, // Do something when voice played.
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
                                                    
                                                  } else ...{
                                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                      ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                             minWidth:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  300,
                                                          maxWidth:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  90,
                                                        ),
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
                                                              Text(
                                                              widget.messageList!
                                                                      .message ??
                                                                  "",
                                                                  softWrap: true,
                                                                  textAlign: TextAlign.left,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.black),
                                                              ),
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
                                                     child: VoiceMessage(
                                                        audioSrc:
                                                            widget.messageList!.message ?? "",
                                                        played:
                                                            true, // To show played badge or not.
                                                        me: true, // Set message side.
                                                        onPlay:
                                                            () {}, // Do something when voice played.
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
                                              
                                          
                                        } else ...{
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width - 300,
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width - 100,
                                              ),
                                              child: GestureDetector(
                                                onLongPress: (){
                                                  if(widget.isGroup==true){
                                                    // showMenu(context: context, position: RelativeRect.fill, 
                                                    // items: [
                                                    //   PopupMenuItem(child: Row(
                                                    //     children: [
                                                    //       Text("Read by"),
                                                    //       IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
                                                    //     ],
                                                    //   ))
                                                                        
                                                    // ]);
                                                  }
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
                                                            Text(
                                                            widget.messageList!
                                                                    .message ??
                                                                "",
                                                                textAlign: TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: Color.fromARGB(255, 255, 255, 255)),
                                                            ),
                                                            
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
}