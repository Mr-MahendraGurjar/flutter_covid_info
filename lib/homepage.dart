import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttercovidinfo/widgets/countrypage.dart';
import 'package:fluttercovidinfo/widgets/info.dart';
import 'package:fluttercovidinfo/widgets/mostaffactedcountry.dart';
import 'package:fluttercovidinfo/widgets/worldwide.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluttercovidinfo/datasorce.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Map worldData;

  fetchWorldWidedata() async {
    http.Response response = await http
        .get("https://disease.sh/v2/all?yesterday=true&allowNull=true");
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;

  fetchCountrydata() async {
    http.Response response = await http.get(
        "https://disease.sh/v2/countries?yesterday=true&sort=cases&allowNull=true");
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    fetchWorldWidedata();
    fetchCountrydata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("COVID-INFO"),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 80,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                color: Colors.orange[100],
                child: DataSource.quote.text.orange800.size(15).bold.make(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("WorldWide").text.size(22).bold.make(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: primaryBlack,
                              borderRadius:
                              BorderRadiusDirectional.circular(10)),
                          child:
                          Text("Regional").text
                              .size(16)
                              .white
                              .bold
                              .make()),
                    ),
                  ],
                ),
              ),
              worldData == null
                  ? Center(child: SpinKitThreeBounce(color: Colors.blueAccent))
                  : Worldwide(
                worldData: worldData,
              ),
              worldData == null
                  ? Container()
                  : PieChart(
                dataMap: {
                  'CONFIRMED': worldData['cases'].toDouble(),
                  'ACTIVE': worldData['active'].toDouble(),
                  'RECOVERED': worldData['recovered'].toDouble(),
                  'DEATHS': worldData['deaths'].toDouble(),
                },
                colorList: [
                  Colors.grey[600],
                  Colors.teal[100],
                  Colors.green,
                  Colors.red,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: "Most affected Countries".text.size(22).bold.make(),
              ),
              SizedBox(
                height: 10,
              ),
              countryData == null
                  ? Center(child: SpinKitChasingDots(color: Colors.blue))
                  : MostAffectedCountry(
                countryData: countryData,
              ),
              SizedBox(
                height: 10,
              ),
              Info(),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: "WE ARE TOGETHER WITH FIGHT"
                      .text
                      .blue400
                      .bold
                      .size(13)
                      .make()),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
