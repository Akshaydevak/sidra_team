import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Invoice Number #HJGVF6514GH",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: w / 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(0xffe6ecf0),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sold By :",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Damson Technology Private Limited ",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 27,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Ship-from Address :",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: w / 27,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Lorem ipsum dolar sit amet this is a dummy file and this is for just a dummy text.",
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: w / 27,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xffE6ECF0),
                          indent: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: w / 2.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID :",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 27,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "JGH6314654",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w / 27,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Order ID :",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 27,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "HYT646511",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w / 27,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Invoice Date :",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: w / 27,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      "12 Jun 2022, 03:20 AM",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w/27,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery To : ",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: w/27,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      "Afthabu Rahman P P Pookattu Purayil House Avilora P.O, Koduvally VIA",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: w/27,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xffE6ECF0),
                          indent: 0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: w/3.5,
                                child: Text(
                                  "Product Name",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff888686),
                                    fontSize: w/28,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.green,
                                width: w/11,
                                child: Text(
                                  "Qty",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff888686),
                                    fontSize:  w/28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),Container(
                                color: Colors.pink,
                                width: w/6.3,
                                child: Text(
                                  "Grs.Amt",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff888686),
                                    fontSize: w/28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.brown,
                                width: w/9.5,
                                child: Text(
                                  "Disc.",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff888686),
                                    fontSize: w/28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                "Tax",
                                style: GoogleFonts.roboto(
                                  color: Color(0xff888686),
                                  fontSize: w/28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                color: Colors.yellow,
                                width: w/7,
                                child: Text(
                                  "Total",
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff888686),
                                    fontSize: w/28,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xffE6ECF0),
                          indent: 0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
