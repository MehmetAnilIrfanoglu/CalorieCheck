import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'SecondScreen.dart';


void main(){
  runApp(MaterialApp(
    home:ThirdScreen(),
  ));
}

class ThirdScreen extends StatelessWidget {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static double dailyCalorieNeedsWithActivity;
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Graphs'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height) / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width)/3,
                height: (MediaQuery.of(context).size.height) / 16,

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Colors.green,

                  borderRadius: BorderRadius.circular(1),
                ),
                child: Center(child: Text('You', style: TextStyle(fontSize: 20))),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width)/3,
                height: (MediaQuery.of(context).size.height) / 5,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Column(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width)/3,
                      height: (MediaQuery.of(context).size.height) / 12,
                      decoration: BoxDecoration(
                        color: Colors.blue,

                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: ListTile(title: Text('CalorieConsumption', style: TextStyle(fontSize: 10)),
                          subtitle: Text(SecondScreen.calorie.toString())),// WILL BE SecondScreen.dataStore[index] later
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width)/3,
                      height: (MediaQuery.of(context).size.height) / 12,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,


                      ),
                      child: Center(child: ListTile(
                        title: Text('DailyCalorieNeed',style: TextStyle(fontSize:10),),
                        subtitle: Text(ThirdScreen.dailyCalorieNeedsWithActivity.toString()),
                      ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height) / 50,
          ),
          Container(
            child: Center(child: Text('Your Weekly Calorie')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: (MediaQuery.of(context).size.height)/3,
                width: (MediaQuery.of(context).size.width)/1.4,
                child: GroupedBarChart.withSampleData()),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height) / 50,
          ),

        ],
      ),
    );
  }
}

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    // When we use shared prefences, calorie will be determined in the SecondScreen and
    // instead of SecondScreen.calorie+2500 there will be just SecondScreen.dataStore[index]
    final CalorieTaken = [
      new OrdinalSales('M', SecondScreen.calorie),
      new OrdinalSales('T', SecondScreen.calorie),
      new OrdinalSales('W', SecondScreen.calorie),
      new OrdinalSales('T', SecondScreen.calorie),
      new OrdinalSales('F', SecondScreen.calorie),
      new OrdinalSales('S', SecondScreen.calorie),
      new OrdinalSales('S', SecondScreen.calorie),
    ];


    final DailyCalorieNeeds = [
      new OrdinalSales('M', ThirdScreen.dailyCalorieNeedsWithActivity),
      new OrdinalSales('T', ThirdScreen.dailyCalorieNeedsWithActivity),
      new OrdinalSales('W', ThirdScreen.dailyCalorieNeedsWithActivity),
      new OrdinalSales('T', ThirdScreen.dailyCalorieNeedsWithActivity),
      new OrdinalSales('F', ThirdScreen.dailyCalorieNeedsWithActivity),
      new OrdinalSales('S', ThirdScreen.dailyCalorieNeedsWithActivity),
      new OrdinalSales('S', ThirdScreen.dailyCalorieNeedsWithActivity),
    ];


    return [
      new charts.Series<OrdinalSales, String>(
        id: 'CalorieTaken',
        domainFn: (OrdinalSales sales, _) => sales.day,
        measureFn: (OrdinalSales sales, _) => sales.calorie,
        data: CalorieTaken,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'DailyCalorieNeeds',
        domainFn: (OrdinalSales sales, _) => sales.day,
        measureFn: (OrdinalSales sales, _) => sales.calorie,
        data: DailyCalorieNeeds,
      ),

    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  String day;
  double calorie;

  OrdinalSales(this.day, this.calorie);
}