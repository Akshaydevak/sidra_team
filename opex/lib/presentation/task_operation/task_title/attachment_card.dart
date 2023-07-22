import 'package:flutter/cupertino.dart';

import '../../inventory/inventory_new_list.dart';
import '../../inventory/new_list_tab/profiling_tab.dart';
import '../create/model/task_models.dart';

class AttachmentCard extends StatefulWidget {
  final GetTaskList? readData;
  const AttachmentCard({Key? key, this.readData}) : super(key: key);

  @override
  State<AttachmentCard> createState() => _AttachmentCardState();
}

class _AttachmentCardState extends State<AttachmentCard> {
  @override
  void initState() {
    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    super.initState();
  }
  picData(){
    picModel.setAll(0, [
      PicModel(
          url: widget.readData?.metaData?.image1 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(1, [
      PicModel(
          url: widget.readData?.metaData?.image2 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(2, [
      PicModel(
          url: widget.readData?.metaData?.image3 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(3, [
      PicModel(
          url: widget.readData?.metaData?.image4 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(4, [
      PicModel(
          url: widget.readData?.metaData?.image5 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);

  }

  @override
  Widget build(BuildContext context) {
    picData();
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
        itemCount: picModel.length,
        itemBuilder: (BuildContext context, int i) {
          return
            Image.network(picModel[i].url??"",height: h/10,width: 100,fit: BoxFit.cover,);
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
  @override
  void initState() {
    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    super.initState();
  }
  picData(){
    picModel.setAll(0, [
      PicModel(
          url: widget.readData?.rewardsData?.image1 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(1, [
      PicModel(
          url: widget.readData?.rewardsData?.image2 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(2, [
      PicModel(
          url: widget.readData?.rewardsData?.image3 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(3, [
      PicModel(
          url: widget.readData?.rewardsData?.image4 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(4, [
      PicModel(
          url: widget.readData?.rewardsData?.image5 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);

  }

  @override
  Widget build(BuildContext context) {
    picData();
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
        itemCount: picModel.length,
        itemBuilder: (BuildContext context, int i) {
          return
            Image.network(picModel[i].url??"",height: h/10,width: 100,fit: BoxFit.cover,);
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
  @override
  void initState() {
    picModel.clear();
    for(int i=0;i<5;i++) {
      picModel.add(PicModel(data: null,url: ""));
    }
    super.initState();
  }
  picData(){
    picModel.setAll(0, [
      PicModel(
          url: widget.readData?.paymentMeta?.image1 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(1, [
      PicModel(
          url: widget.readData?.paymentMeta?.image2 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(2, [
      PicModel(
          url: widget.readData?.paymentMeta?.image3 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(3, [
      PicModel(
          url: widget.readData?.paymentMeta?.image4 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);
    picModel.setAll(4, [
      PicModel(
          url: widget.readData?.paymentMeta?.image5 ??
              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png")
    ]);

  }

  @override
  Widget build(BuildContext context) {
    picData();
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
        itemCount: picModel.length,
        itemBuilder: (BuildContext context, int i) {
          return
            Image.network(picModel[i].url??"",height: h/10,width: 100,fit: BoxFit.cover,);
        }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 5,); },
      ),
    );
  }
}
