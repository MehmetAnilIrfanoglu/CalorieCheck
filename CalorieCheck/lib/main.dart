import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'Services.dart';
import 'login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'ArticleInfo.dart';
import 'FourthScreen.dart';
import 'dart:math';

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  var turkey = tz.getLocation('Europe/Istanbul');
  tz.setLocalLocation(turkey);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  static List<int> flag = [0,0,0,0,0];
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user)
    {
      if (user == null)
      {
        print('User is currently signed out!');
      }
      else
        {
          print('User is signed in!');
        }
    });
    super.initState();
    Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
    var initializationSettingsAndroid =
    AndroidInitializationSettings('launch_background');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOs,
      macOS: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<Widget> onSelectNotification(String payload) {
    var rng = new Random();
    int a = rng.nextInt(6);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleInfo(FourthScreen.topics[a],FourthScreen.articleText[a],FourthScreen.links[a])));

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}


class NewScreen extends StatelessWidget {
  final String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload),
      ),
    );
  }
}





