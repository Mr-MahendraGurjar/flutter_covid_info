import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttercovidinfo/Animation/fade_animation.dart';
import 'package:fluttercovidinfo/Responses/statewise.dart';
import 'package:fluttercovidinfo/screens/districtscreen.dart';
import 'package:fluttercovidinfo/screens/searchdistrict.dart';
import 'package:fluttercovidinfo/widgets/constraints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class DistrictData extends StatefulWidget {
  final name;

  DistrictData({this.name});

  @override
  _DistrictDataState createState() => _DistrictDataState();
}

class _DistrictDataState extends State<DistrictData> {
  String dname;
  List name = [];
  List<CityData> listOfCityData;

  @override
  void initState() {
    super.initState();
    getname(widget.name);
    _fetchData();
    Timer(new Duration(seconds: 5), () {
      connectivity();
    });
  }

  connectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("connected");
      }
    } on SocketException catch (_) {
      noConnectionAvailable();
    }
  }

  noConnectionAvailable() {
    Fluttertoast.showToast(
        msg: 'Slow Internet/Not Available',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1);
  }

  getname(name) {
    dname = name;
  }

  Future<List<DistrictModel>> _fetchData() async {
    var response = await http
        .get('https://api.covid19india.org/v2/state_district_wise.json');

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<DistrictModel> listOfCovidData = items.map<DistrictModel>((json) {
        return DistrictModel.fromJson(json);
      }).toList();
      return listOfCovidData;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  dataRefreshed() {
    Fluttertoast.showToast(
        msg: 'Data Refreshed!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1);
  }

  Future onRefresh() async {
    await _fetchData();
    dataRefreshed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Row(
          children: <Widget>[
            Flexible(
                child: Container(
                    child: Text(
              dname.toUpperCase(),
              overflow: TextOverflow.ellipsis,
            ))),
            Flexible(
                child: Container(
                    child: Text(
              ' (Districts)',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xffff9933)),
            ))),
          ],
        ),
        actions: <Widget>[
          Tooltip(
            message: 'Search',
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchDistrict(listofCityData: listOfCityData));
              },
            ),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: FutureBuilder<List<DistrictModel>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int j = 0; j < snapshot.data.length; j++) {
              DistrictModel covidDataModel = snapshot.data[j];
              if (covidDataModel.state == dname) {
                listOfCityData = covidDataModel.districtData;
                listOfCityData.sort((a, b) =>
                    int.parse(b.confirmed).compareTo(int.parse(a.confirmed)));

                return listOfCityData == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        backgroundColor: kBackgroundColor,
                        color: Colors.white,
                        onRefresh: onRefresh,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DistrictScreen(
                                              distdata: listOfCityData,
                                              dname: listOfCityData[index]
                                                  .district,
                                            )));
                              },
                              child: Card(
                                color: kBackgroundColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kContainerColor,
                                  ),
                                  height: kListContainerHeight,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${index + 1} .',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            fontFamily: 'SourceSansPro'),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 170,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            FadeAnimation(
                                                1,
                                                Text(
                                                  listOfCityData[index]
                                                      .district,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      fontFamily:
                                                          'SourceSansPro'),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 30,
                                            ),
                                            FadeAnimation(
                                                1.2,
                                                Text(
                                                  listOfCityData[index]
                                                      .confirmed
                                                      .replaceAllMapped(
                                                          kreg, kmathFunc),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      fontFamily:
                                                          'SourceSansPro',
                                                      color: Colors.deepOrange),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: listOfCityData == null
                              ? 0
                              : listOfCityData.length,
                        ),
                      );
              }
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
