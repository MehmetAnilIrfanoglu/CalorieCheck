import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'homepage.dart';
import 'api/SearchfromApi.dart';

void main() {
  runApp(MaterialApp(
    home: SecondScreen(),
  ));
}

class SecondScreen extends StatefulWidget {
  static double calorie = 0;
  static int val;
  static int id=1;
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController foodName = new TextEditingController();
  List denem2;
  List denem3;

  @override
  void initState() {
    // TODO: implement initState
    _query().then((value) {
      denem2 = value;
      setState(() {});
    });
    _query2().then((value) {
      denem3 = value;
      setState(() {});
    });
    _query3().then((value) {
      SecondScreen.calorie = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Food Search Menu'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/article.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _query(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? denem2.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: (MediaQuery.of(context).size.height) / 10,
                              width: (MediaQuery.of(context).size.width) / 1.2,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: Text(
                                    "Add what you eat",
                                    style: TextStyle(
                                      fontSize: 20,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1
                                        ..color = Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: foodName,
                                obscureText: false,
                                decoration: InputDecoration(fillColor: Colors.white,filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: 'For Example Burger'),
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              setState(() {
                                SearchAPI.foods = foodName.text;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchAPI()));
                            },
                            color: Colors.black,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(7.0),
                            splashColor: Colors.blue,
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontSize: 19.0),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            },
                            color: Colors.black,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(7.0),
                            splashColor: Colors.blue,
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 19.0),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: denem2.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.list),
                                    title: Text(
                                      denem2[index],
                                    ),
                                    trailing: Text(
                                      denem3[index].toString(),
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: TextField(
                                controller: foodName,
                                obscureText: false,
                                decoration: InputDecoration(fillColor: Colors.white,filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'),
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)
                            ),
                            onPressed: () {
                              setState(() {
                                SearchAPI.foods = foodName.text;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchAPI()));
                            },
                            color: Colors.black,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(7.0),
                            splashColor: Colors.blue,
                            child: Text(
                              'Confirm',
                                style: TextStyle(fontSize: 16,color: Colors.white)
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),


                                      child: DropdownButton(
                                        value: SecondScreen.val,
                                        hint: Text("Percentage"),
                                        items: [
                                          DropdownMenuItem(
                                              child: Text("1/4"), value: 5),
                                          DropdownMenuItem(
                                              child: Text("2/4"), value: 10),
                                          DropdownMenuItem(
                                              child: Text("3/4"), value: 15),
                                          DropdownMenuItem(
                                              child: Text("1"), value: 20),
                                        ],
                                        onChanged: (_val) {
                                          setState(() {
                                            SecondScreen.val = _val;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                    ),
                                    RaisedButton(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white)
                                      ),
                                      child: Text("Update",style: TextStyle(fontSize: 16,color: Colors.white)),
                                      onPressed: () {
                                        print('clicked');

                                        _update().then((value) {
                                          print('updated last meals calorie');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SecondScreen()),
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            },
                            color: Colors.black,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(7.0),
                            splashColor: Colors.blue,
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 19.0,color: Colors.white),
                            ),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.remove),
                            backgroundColor: Colors.deepOrange,
                            onPressed: () {
                              print('clicked');

                              _delete().then((value) {
                                print('deleted');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondScreen()),
                                );
                              });
                            },
                          ),
                        ],
                      )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<List> _query() async {
    final allRows = await SearchAPI.dbHelper.queryAllRows();
    List liste = new List();
    allRows.forEach((row) => liste.add(row['name']));
    return liste;
  }

  Future<List> _query2() async {
    final allRows = await SearchAPI.dbHelper.queryAllRows();
    List liste = new List();
    allRows.forEach((row) => liste.add(row['calorie']));

    return liste;
  }

  Future<double> _query3() async {
    final allRows = await SearchAPI.dbHelper.queryAllRows();
    double a = 0;
    allRows.forEach((row) => a += (row['calorie']));

    return a;
  }

  Future<void> _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await SearchAPI.dbHelper.queryRowCount();
    final rowsDeleted = await SearchAPI.dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  Future<void> _update() async {
    final allRows = await SearchAPI.dbHelper.queryAllRows();
    double a = 0;
    allRows.forEach((row) => a = (row['calorie']));
    final id = await SearchAPI.dbHelper.queryRowCount();
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnCalorie: a * (SecondScreen.val / 20),
    };
    final rowsAffected = await SearchAPI.dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
}
