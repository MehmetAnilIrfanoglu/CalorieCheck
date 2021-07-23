import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'homepage.dart';
import 'api/SearchfromApi.dart';

void main() {
  runApp(MaterialApp(
    home: History(),
  ));
}

class History extends StatefulWidget {

  static int val;


  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('History Menu'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _query(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? denem2.isEmpty
              ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("There is no item"),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage()));
                    },
                    color: Colors.indigoAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(7.0),
                    splashColor: Colors.blue,
                    child: Text(
                      'Turn to Homepage',
                      style: TextStyle(fontSize: 19.0),
                    ),
                  ),
                ],
              ),)
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: denem2.length,
                  itemBuilder: (context, index) => ListTile(
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
              Column(
                children: [

                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [

                        DropdownButton(
                          value: History.val,
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
                              History.val = _val;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),

                        ),


                        RaisedButton(
                          child: Text("Update"),
                          onPressed: () {
                            print('clicked');

                            _updateSearch().then((value) {
                              print('updated last meals calorie');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => History()),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homepage()));
                },
                color: Colors.indigoAccent,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(7.0),
                splashColor: Colors.blue,
                child: Text(
                  'Turn to Homepage',
                  style: TextStyle(fontSize: 19.0),
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.remove),
                backgroundColor: Colors.deepOrange,
                onPressed: () {
                  print('clicked');
                  _deleteSearch().then((value) {
                    print('deleted');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => History()),
                    );
                  });
                },
              ),
            ],
          )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List> _query() async {
    final allRows = await SearchAPI.dbHelper.queryAllRowsSearch();
    List liste = new List();
    allRows.forEach((row) => liste.add(row['name']));
    return liste;
  }

  Future<List> _query2() async {
    final allRows = await SearchAPI.dbHelper.queryAllRowsSearch();
    List liste = new List();
    allRows.forEach((row) => liste.add(row['calorie']));

    return liste;
  }

  Future<void> _deleteSearch() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await SearchAPI.dbHelper.queryRowCountSearch();
    final rowsDeleted = await SearchAPI.dbHelper.deleteSearch(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  Future<void> _updateSearch() async {
    final allRows = await SearchAPI.dbHelper.queryAllRowsSearch();
    double a = 0;
    allRows.forEach((row) => a = (row['calorie']));
    final id = await SearchAPI.dbHelper.queryRowCountSearch();
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnCalorie:a*(History.val/20),

    };
    final rowsAffected = await SearchAPI.dbHelper.updateSearch(row);
    print('updated $rowsAffected row(s)');
  }
}


