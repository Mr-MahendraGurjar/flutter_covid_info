import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Worldwide extends StatelessWidget {

  final Map worldData;

  const Worldwide({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
      children: <Widget>[
        StatusPanel(
          tittle: "CONFIRMED",
          panelColor: Colors.grey[500],
          textColor: Colors.grey[900],
          count: worldData['cases'].toString(),
        ),
        StatusPanel(
          tittle: "ACTIVE",
          panelColor: Colors.teal[100],
          textColor: Colors.purpleAccent,
          count: worldData['active'].toString(),
        ),
        StatusPanel(
          tittle: "RECOVERED",
          panelColor: Colors.green[100],
          textColor: Colors.green,
          count: worldData['recovered'].toString(),
        ),
        StatusPanel(
          tittle: "DEATH",
          panelColor: Colors.red[200],
          textColor: Colors.red,
          count: worldData['deaths'].toString(),
        ),
      ],),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String tittle;
  final String count;

  const StatusPanel({Key key, this.panelColor, this.textColor, this.tittle, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      color: panelColor,
      height: 80,
      width: width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          tittle.text.size(16).color(textColor).bold.make(),
          count.text.size(16).color(textColor).bold.make()
        ],
      ),
    );
  }
}

