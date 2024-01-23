import 'package:avatar_stack/avatar_stack.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_widgets/custom_checkbox.dart';
import '../../../common_widgets/gradient_button.dart';
import '../employee_model/employee_model.dart';
import '../task_svg.dart';

class UserCardEvaluation extends StatelessWidget {
  const UserCardEvaluation({super.key, this.onTap,this.evaluted=false});

  final VoidCallback? onTap;
  final bool? evaluted;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffE6ECF0))),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.loudegg.com/wp-content/uploads/2020/10/Mickey-Mouse.jpg"),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shifas Mehar N K",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: w / 24),
                ),
                Text(
                  "shifas@rgcdynamics.com",
                  style: GoogleFonts.roboto(fontSize: w / 26),
                ),
              ],
            ),
          ),
          Spacer(),
          evaluted==true?Row(
            children: [
              Text("Done",
              style: GoogleFonts.roboto(
                fontSize: w/28,
                color: Colors.green,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(width: 5,),
              SvgPicture.string(
                TaskSvg().tickIcon,
                color: Colors.green,
                width: 15,
                height: 15,
              ),
            ],
          ):
          Container(
            width: w1 > 700?w1/5:w1 / 4,
            height: w1 > 700?35:30,
            child: GradientButton(
                onPressed: onTap,
                gradient: const LinearGradient(
                  colors: [
                    ColorPalette.primary,
                    ColorPalette.primary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: ColorPalette.primary,
                child: Text(
                  "Evaluate",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: w / 26,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class UserCardEvaluationTLs extends StatelessWidget {
  const UserCardEvaluationTLs({super.key, this.onTap, this.isStart = false});

  final VoidCallback? onTap;
  final bool? isStart;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffE6ECF0))),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg"),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John wick",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, fontSize: w / 24),
                ),
                Text(
                  "jhonwick@rgcdynamics.com",
                  style: GoogleFonts.roboto(fontSize: w / 26),
                ),
              ],
            ),
          ),
          Spacer(),
          isStart == true
              ? Container(
                  width: w1 / 5,
                  height: 30,
                  child: GradientButton(
                      onPressed: onTap,
                      gradient: const LinearGradient(
                        colors: [
                          ColorPalette.primary,
                          ColorPalette.primary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: ColorPalette.primary,
                      child: Text(
                        "Start",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: w / 26,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                )
              : Container()
        ],
      ),
    );
  }
}

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, this.onTap, this.isStart = false});

  final VoidCallback? onTap;
  final bool? isStart;

  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
       
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xffE6ECF0))),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg"),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John wick",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: w / 24),
                    ),
                    Text(
                      "jhonwick@rgcdynamics.com",
                      style: GoogleFonts.roboto(fontSize: w / 26),
                    ),
                    SizedBox(height: 5,),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,itemSize: 20,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.green,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("96 Points",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: w/26
                        ),),
                        Text(" | "),
                        Text("Outstanding Performance",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: w/26
                          ),),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
            top: 20,
            child:  Container(
              height: 27,width: 65,
              child: GradientButton(
                  onPressed: onTap,
                  gradient: const LinearGradient(
                    colors: [
                      ColorPalette.primary, ColorPalette.primary
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color:  Colors.transparent,
                  child: Text(
                    "Action",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: w/26,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),)
      ],
    );
  }
}


class EvaluationGroupCard extends StatefulWidget {
  const EvaluationGroupCard({super.key});

  @override
  State<EvaluationGroupCard> createState() => _EvaluationGroupCardState();
}

class _EvaluationGroupCardState extends State<EvaluationGroupCard> {
  @override
  Widget build(BuildContext context) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    var h = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xffE6ECF0))),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Review within 2 Weeeks"),
          SizedBox(
            width: 5,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consecte turadi piscing elit, seddo eiuste?",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500, fontSize: w / 24),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarStack(
                height: 25,width: 80,
                avatars: [
                  for (var n = 0; n < 10; n++)
                    NetworkImage('https://lionsgate.brightspotcdn.com/1d/90/8fc75de5411e985f3a2def98358d/johnwick4-section-promo-double-home-03.jpg'),
                ],
              ),
              Text("2 pending..",
              style: GoogleFonts.roboto(
                color: Colors.red
              ),),
            ],
          ),

        ],
      ),
    );
  }
}




class ShareCard extends StatefulWidget {
  final bool value;
  final String text;
  final String svg;
  final String color;
  final Function(bool)? onChange;

  const ShareCard({Key? key,this.value = false, this.onChange, required this.text, required this.svg, required this.color,}) : super(key: key);

  @override
  State<ShareCard> createState() => _ShareCardState();
}

class _ShareCardState extends State<ShareCard> {
  bool val=false;
  bool onChange = false;

  @override
  Widget build(BuildContext context) {
    print("fasss$val");
    double w1 = MediaQuery.of(context).size.width ;
    double w = w1> 700
        ? 400
        : w1;
    var h=MediaQuery.of(context).size.height;
    if (!onChange) val = widget.value;
    onChange = false;
    return InkWell(
      onTap: () {
        val = !val;
        if (widget.onChange != null) widget.onChange!(val);
        onChange = true;
        setState(() {});
      },
      child:    Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: val==true?ColorPalette.primary:Color(0xffe6ecf0), width: 1, ),
          boxShadow: [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 8,
              offset: Offset(1, 1),
            ),
          ],
          color: val==true?ColorPalette.cardBackground:Color(int.tryParse(widget.color)??0),
        ),
        child: Column(
          children: [

            SvgPicture.string(widget.svg,height: 20,width: 20,),
            SizedBox(height: 5,),
            Text(widget.text,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: w/28
            ),)
          ],
        ),
      ),
    );
  }
}

