import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MostAffectedCountry extends StatelessWidget {

  final List countryData;

  const MostAffectedCountry({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5
          ),
          child: Row(
            children: <Widget>[
              Image.network(
                countryData[index]['countryInfo']['flag'],
                height: 25,
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                countryData[index]['country'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Cases: ' + countryData[index]['cases'].toString()+ "  |",
                style:
                TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10,),
              Text(
                'Deaths: ' + countryData[index]['deaths'].toString() ,
                style:
                TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
      itemCount: 5,),
    );
  }
}
