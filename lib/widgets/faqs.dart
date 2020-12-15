import 'package:flutter/material.dart';
import 'file:///C:/Users/HOME/FlutterProjects/flutter_covid_info/flutter_covid_info/lib/widgets/datasorce.dart';
import 'package:velocity_x/velocity_x.dart';

class FAQSPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context,index){
        return ExpansionTile(title: Text(DataSource.questionAnswers[index]['question'],style: TextStyle(fontWeight: FontWeight.bold),),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DataSource.questionAnswers[index]['answer']),
          )
        ],
        );
      }),
    );
  }
}
