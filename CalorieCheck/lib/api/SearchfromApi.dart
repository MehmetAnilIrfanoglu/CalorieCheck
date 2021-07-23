import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:caloriecheck_app/SecondScreen.dart';
import '../updateData.dart';
import 'Food.dart';
import 'package:http/http.dart' as http;
import 'package:caloriecheck_app/database_helper.dart';


class SearchAPI extends StatefulWidget {
  static String foods;
  static final dbHelper = DatabaseHelper.instance;

  @override
  _SearchAPIState createState() => _SearchAPIState();
}

class _SearchAPIState extends State<SearchAPI> {

  @override
  void initState() {
    super.initState();
  }

  Future<List<Results>> getData() async {
    List<Results> list;
    String link;

    link =
    "https://api.spoonacular.com/recipes/complexSearch?query=${SearchAPI.foods}&number=1000&apiKey=58859c01957e44ada5add594efbd2bb6&maxCalories=20000";

    var res = await http
        .get(Uri.encodeFull(link));

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["results"] as List;
      print(rest);
      list = rest.map<Results>((json) => Results.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    print(list);
    return list;
  }

  Widget listViewWidget(List<Results> results) {

    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: results.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            Nutrition a = results[position].nutrition;
            List b = a.nutrients;
            double amount = b[0].amount; // Calories
            String title = results[position].title;

            return Card(
              child: Container(
                height: 120.0,
                width: 120.0,
                child: Center(
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image.asset("images/main.jpg", fit: BoxFit.cover),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Calories: $amount',
                      ),
                    ),
                    title: Text(
                      '${results[position].title}',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () => {
                      _insert(title,amount),

                      _insertSearch(title,amount),
                      _query(), // 'For debug purposes' It will remain till the final submission. Before final submission we will delete it.
                    update()
                        .authService
                        .addHistory(
                    title,amount
                    )
                        .then((value) {


                    SecondScreen.id++;
                    Navigator.push(
                    context,(MaterialPageRoute(builder: (BuildContext context) => SecondScreen()))
                    );

                    }).catchError((Error) {
                    print(Error);
                    }),


                    },
                  ),

                ),

              ),

            );
          }),
    );
  }
  void _insert(String title, double calorie) async {

    Map<String, dynamic> row = {
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnCalorie: calorie
    };
    final id = await SearchAPI.dbHelper.insert(row);
    print('inserted row id: $id');
  }
  void _insertSearch(String title,double calorie) async{

    Map<String, dynamic> row = {
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnCalorie: calorie,
    };
    final id =   await SearchAPI.dbHelper.insertSearch(row);
    print('inserted row id: $id');
    print("Second database is working fine");
  }

  void _query() async {
    final allRows = await SearchAPI.dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row['name']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(SearchAPI.foods),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

}


