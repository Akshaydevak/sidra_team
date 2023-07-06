import 'package:cluster/presentation/purchase_app/pdf_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';
import '../task_operation/task_title/attachment_card.dart';

class PurchaseAttachmentScreen extends StatelessWidget {
  const PurchaseAttachmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Attachments",isAction: false,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attached Files",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: w/22,
                ),
              ),
              SizedBox(height: 10,),
              ListView.separated(
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PdfCard(),
                separatorBuilder: (context, index) => SizedBox(height: 5,), itemCount: 2,
                  ),
              SizedBox(height: 20,),
              Text(
                "Attached Images",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: w/22,
                ),
              ),
              AttachmentCard(),
              SizedBox(height: 5,),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(hintText: "Description ...",
                  hintStyle:  TextStyle(
                    color: Color(0x66151522),
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffe6ecf0),width: 1)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE6ECF0),width: 1)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
