import 'package:flutter/material.dart';

import '../dashboard_screen/home_screen/homescreen_widget/appbar.dart';

class RequestInformation extends StatelessWidget {
  const RequestInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackAppBar(label: "Request Information",isAction: false,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Request Information from ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w/22,
                    ),
                  ), Text(
                    "Rawabi Market",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: w/22,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(hintText: "Notes ...",
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
              SizedBox(height: 5,),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(hintText: "Remarks ...",
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
