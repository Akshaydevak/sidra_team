import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAssignee extends StatefulWidget {
  const SearchAssignee({Key? key}) : super(key: key);

  @override
  State<SearchAssignee> createState() => _SearchAssigneeState();
}

class _SearchAssigneeState extends State<SearchAssignee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 10,),

              ],
            ),
          )
        ]),
      ),
    );
  }
}
