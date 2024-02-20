
import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';
import '../../inventory/new_list_tab/profiling_tab.dart';
import '../create/model/task_models.dart';
import '../image_preview_task.dart';

class AttachmentCard extends StatefulWidget {
  final GetTaskList? readData;
  const AttachmentCard({Key? key, this.readData}) : super(key: key);

  @override
  State<AttachmentCard> createState() => _AttachmentCardState();
}

class _AttachmentCardState extends State<AttachmentCard> {
  List<PicModel> picModel = [];
  int picLength=0;
  @override
  void initState() {
    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    picData();
    super.initState();
  }
  picData(){
    picModel.setAll(0, [
      PicModel(
          url: widget.readData?.metaData?.image1)
    ]);
    picModel.setAll(1, [
      PicModel(
          url: widget.readData?.metaData?.image2)
    ]);
    picModel.setAll(2, [
      PicModel(
          url: widget.readData?.metaData?.image3)
    ]);
    picModel.setAll(3, [
      PicModel(
          url: widget.readData?.metaData?.image4)
    ]);
    picModel.setAll(4, [
      PicModel(
          url: widget.readData?.metaData?.image5)
    ]);

    for(var i=0;i<picModel.length;i++){
      if(picModel[i].url!=null){
        picLength++;
      }
    }
    print("hgfhgfhgf${widget.readData?.metaData?.image1}");
    print("hgfhgfhgf${picModel[0].url}");
    print("hgfhgfhgf${picModel[1].url}");
    print("hgfhgfhgf${picModel[2].url}");
    print("hgfhgfhgf${picModel[3].url}");
    print("hgfhgfhgf${picModel[4].url}");
    print("hgfhgfhgf${picLength}");

  }

  @override
  Widget build(BuildContext context) {
    // picData();
     var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return    Container(
      height: h / 6,
      width: w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 0, left: 0),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: picLength,
        itemBuilder: (BuildContext context, int i) {

          return
            GestureDetector(
              onTap: (){

                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(

                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),),

                        content: ImagePreview(
                          assetName: picModel[i].url??"",
                        ),
                      );
                    }
                );
              },
                child: Container(
                    height: h/10,
                    width: w/4,padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Image.network(picModel[i].url??"",fit: BoxFit.cover,)));
        }, separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 5,); },
      ),
    );
  }
}


//rewards
class RewardsCard extends StatefulWidget {
  final GetTaskList? readData;
  const RewardsCard({Key? key, this.readData}) : super(key: key);

  @override
  State<RewardsCard> createState() => _RewardsCardState();
}

class _RewardsCardState extends State<RewardsCard> {
  List<PicModel> picModel = [];
  @override
  void initState() {
    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    picData();
    super.initState();
  }
  int picLength=0;
  picData(){
    picModel.setAll(0, [
      PicModel(
          url: widget.readData?.rewardsData?.image1)
    ]);
    picModel.setAll(1, [
      PicModel(
          url: widget.readData?.rewardsData?.image2)
    ]);
    picModel.setAll(2, [
      PicModel(
          url: widget.readData?.rewardsData?.image3 )
    ]);
    picModel.setAll(3, [
      PicModel(
          url: widget.readData?.rewardsData?.image4 )
    ]);
    picModel.setAll(4, [
      PicModel(
          url: widget.readData?.rewardsData?.image5)
    ]);
    for(var i=0;i<picModel.length;i++){
      if(picModel[i].url!=null){
        picLength++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
// picData();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return    Container(
      height: h / 6,
      width: w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 0, left: 0),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: picLength,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: (){

                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),),
                        content: ImagePreview(
                          assetName: picModel[i].url??"",
                        ),
                      );
                    }
                );
              },
                child: Container(
                    height: h/10,
                    width: w/4,padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Image.network(picModel[i].url??"",fit: BoxFit.cover,)));
        }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 5,); },
      ),
    );
  }
}


//paty
class PaymentCard extends StatefulWidget {
  final GetTaskList? readData;
  const PaymentCard({Key? key, this.readData}) : super(key: key);

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  List<PicModel> picModel = [];
  int picLength=0;
  @override
  void initState() {

    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
   picData();
    super.initState();
  }
  picData(){
    picModel.setAll(0, [
      PicModel(
          url: widget.readData?.paymentMeta?.image1 ??null)
              // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(1, [
      PicModel(
          url: widget.readData?.paymentMeta?.image2 ??null),
              // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(2, [
      PicModel(
          url: widget.readData?.paymentMeta?.image3 ??null),
              // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(3, [
      PicModel(
          url: widget.readData?.paymentMeta?.image4 ??null),
              // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(4, [
      PicModel(
          url: widget.readData?.paymentMeta?.image5 ??null),
              // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);

    for(var i=0;i<picModel.length;i++){
      if(picModel[i].url!=null){
        picLength++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // picData();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return    Container(
      height: h / 6,
      width: w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 0, left: 0),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: picLength,
        itemBuilder: (BuildContext context, int i) {
          return
            GestureDetector(onTap: (){

              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                      content: ImagePreview(
                        assetName: picModel[i].url??"",
                      ),
                    );
                  }
              );
            },child: Container(
              height: h/10,
              width: w/4,padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0x4ca9a8a8), width: 1, ),
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
                child: Image.network(picModel[i].url??"",fit: BoxFit.cover,)));
        }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 5,); },
      ),
    );
  }
}
