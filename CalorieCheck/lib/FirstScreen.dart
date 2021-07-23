import 'package:caloriecheck_app/Services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'FourthScreen.dart';
import 'login.dart';
import 'updateData.dart';
import 'history.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController updateWeight = new TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  String _selectedParam;
  int val;
  String task;
  Future<void> scheduleNotification() async {
    var scheduledTime;
    if(_selectedParam=="Hours")
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(hours: val));
    else if(_selectedParam=="Minutes")
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(minutes: val));
    else scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: val));
    var android = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'launch_background',
      largeIcon: DrawableResourceAndroidBitmap('launch_background'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: android,
      iOS: iOSPlatformChannelSpecifics,
      macOS: null,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'water notifier',
      task,
      scheduledTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: null,
      androidAllowWhileIdle: false,
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page',style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  'Calorie Check',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),


            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => History()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Services'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp()));
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Update Data'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => update()));
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Person'),
              onTap: () async{
                update()
                    .authService
                    .delete(
                    Login.newUser.id
                )
                    .then((value) {


                }).catchError((Error) {
                  print(Error);
                });
                update()
                    .authService
                    .deleteUser(

                )
                    .then((value) {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login()));

                }).catchError((Error) {
                  print(Error);
                });
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) / 2.2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Calorie Check',style: TextStyle(fontSize: 50,color: Colors.white)),
                    Icon(
                      Icons.beach_access,
                      color: Colors.white,
                      size: 45.0,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: ListView(
              children: [

                Container(
                  height: (MediaQuery.of(context).size.height) /19,

                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text('Notifications', style: TextStyle(fontSize: 20,color: Colors.white))),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width),
                  height: (MediaQuery.of(context).size.height) / 9,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FourthScreen()));
                    },
                    color: Colors.indigoAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(7.0),
                    splashColor: Colors.blue,
                    child: Text(
                      'Did you know that a suitable diet would be beneficial for your life? '
                          'Click for more details.',
                      style: TextStyle(fontSize: 19.0),
                      softWrap: true,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.all(12),
                      child: TextField(
                        onChanged: (_val){
                          task=_val;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton(
                            value: _selectedParam,
                            hint: Text("time"),
                            items: [
                              DropdownMenuItem(child: Text("Seconds"),value: "Seconds"),
                              DropdownMenuItem(child: Text("Minutes"),value: "Minutes"),
                              DropdownMenuItem(child: Text("Hours"),value: "Hours"),
                            ],
                            onChanged: (_val){
                              setState(() {
                                _selectedParam=_val;
                              });
                            },
                          ),
                          DropdownButton(
                            value: val,
                            hint: Text("duration"),
                            items: [
                              DropdownMenuItem(child: Text("5"),value: 5),
                              DropdownMenuItem(child: Text("10"),value: 10),
                              DropdownMenuItem(child: Text("15"),value: 15),
                              DropdownMenuItem(child: Text("20"),value: 20),
                            ],
                            onChanged: (_val){
                              setState(() {
                                val = _val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text("Schedule Notification"),
                      onPressed: scheduleNotification,
                    ),
                    RaisedButton(
                      child: Text("Cancel scheduled notifications"),
                      onPressed: cancelNotification,
                    )
                  ],
                ),
              ],
            ),
            ),



          ],
        ),
      ),
    );
  }
}