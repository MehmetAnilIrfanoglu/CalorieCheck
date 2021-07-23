import 'package:flutter/material.dart';
import 'login.dart';
import 'authentication.dart';


class update extends StatefulWidget {

  AuthenticationService authService = new AuthenticationService();

  @override
  _updateState createState() => _updateState();
}

class _updateState extends State<update> {

  TextEditingController mailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController genderControl = new TextEditingController();
  TextEditingController ageControl = new TextEditingController();
  TextEditingController performanceControl = new TextEditingController();
  TextEditingController weightControl = new TextEditingController();
  TextEditingController heightControl = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameControl.text = Login.newUser.name;
    genderControl.text = Login.newUser.gender;
    ageControl.text = Login.newUser.age;
    weightControl.text = Login.newUser.weight;
    heightControl.text = Login.newUser.height;
    performanceControl.text=Login.newUser.performance;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('HomePage'),
      ),
      body: Center(
        child: ListView(

          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: (MediaQuery.of(context).size.height)/7,
                width: (MediaQuery.of(context).size.width)/2,

                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text('Personal Informations', style: TextStyle(
                  fontSize: 30,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.white,
                ),)),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: nameControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: genderControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gender',
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: performanceControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Performance',
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: ageControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: weightControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight',
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: heightControl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Height',
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)
                ),
                color: Colors.black,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () async {
                  update()
                      .authService
                      .updateProcess(
                      Login.newUser.id,
                      nameControl.text,
                      genderControl.text,
                      performanceControl.text,
                      ageControl.text,weightControl.text,heightControl.text)
                      .then((value) {
                    //Scaffold.of(context).showSnackBar(SnackBar(
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Update is Successfully'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2)));
                    Login.email=Login.newUser.email;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login()));

                  }).catchError((Error) {
                    print(Error);
                  });
                },
                child: Text(
                  "Update",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 30,
            ),
          ],
        ),
      ),
    );
  }
}
