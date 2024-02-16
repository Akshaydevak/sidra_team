import 'package:cluster/core/color_palatte.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String? image;
  const DetailScreen({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){

          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: ColorPalette.primary,
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              image ?? "",
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
