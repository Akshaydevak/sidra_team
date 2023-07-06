import 'package:cluster/common_widgets/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateOrg extends StatelessWidget {
  const UpdateOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
          centerTitle: false,
          elevation: 2,
          actions: const [
            Icon(Icons.check,color: Colors.black,),
            SizedBox(width: 16,)
          ],
          // leading: Icon(Icons.arrow_back,color: Colors.black,),
          leadingWidth: 0,
          title: const Text("Update Organization Profile",style: TextStyle(
              color: Colors.black

          ),),backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text("Admin Profile Photo or Logo",style: TextStyle(
                fontWeight: FontWeight.w500
              ),),
              SizedBox(height:10),
              Container(
                  color: Colors.white,
                  // padding: EdgeInsets.a,
                  padding: EdgeInsets.all(40),
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/placeholder.png",height: 70,width: 70,fit: BoxFit.contain,)),
              const SizedBox(height: 10,),
              TextFormReusable(
                label: "Name of the organisation",
                 hint: "RGC dynamics",
              ),
              const SizedBox(height: 5,),
              TextFormReusable(
                label: "Name of the organisation",
                 hint: "RGC dynamics",
              ),
              const SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}