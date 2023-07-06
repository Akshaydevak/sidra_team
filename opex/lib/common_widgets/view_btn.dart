import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewButton extends StatelessWidget {
  VoidCallback onTap;
   ViewButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "View All",
        style: GoogleFonts.roboto(
          color: Color(0xfffe5762),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
