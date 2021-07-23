import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homepage.dart';

class ArticleInfo extends StatelessWidget {
  String head;
  String body;
  static String link;
  ArticleInfo(this.head,this.body,link);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(head),


      ),

      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/article.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height)/12,
                  width: (MediaQuery.of(context).size.width) ,

                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(child: Text(head, style: TextStyle(fontSize: 25,color: Colors.white))),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height)/2,
                  width: (MediaQuery.of(context).size.width) ,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(body,softWrap: true, style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
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
                  child: Icon(
                    Icons.home,
                    color: Colors.blue,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  /*child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 19.0,color: Colors.white),
                  ),
                ),*/
                ),
              ],
            ),
          ),
        ),
      ),

    );


  }




}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(

        body: new Center(
          child: new InkWell(
              child: new Text('Open Browser'),
              onTap: () => launch(ArticleInfo.link)
          ),
        ),
      ),
    );
  }
}