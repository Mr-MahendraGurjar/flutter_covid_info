import 'package:flutter/material.dart';
import 'file:///C:/Users/HOME/FlutterProjects/flutter_covid_info/flutter_covid_info/lib/widgets/datasorce.dart';
import 'package:fluttercovidinfo/widgets/faqs.dart';
import 'package:velocity_x/velocity_x.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FAQSPage()));
            },
            child: Container(
              color: primaryBlack,
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  "FAQ".text.bold.white.size(18).make(),
                  Icon(Icons.arrow_forward,color: Colors.white,)
                ],
              ),
            ),
          ),
          GestureDetector(onTap: (){
          },
            child: Container(
              color: primaryBlack,
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  "DONATE".text.bold.white.size(18).make(),
                  Icon(Icons.arrow_forward,color: Colors.white,)
                ],
              ),
            ),
          ),
          GestureDetector(onTap: (){
          },
            child: Container(
              color: primaryBlack,
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  "MYTH".text.bold.white.size(18).make(),
                  Icon(Icons.arrow_forward,color: Colors.white,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
