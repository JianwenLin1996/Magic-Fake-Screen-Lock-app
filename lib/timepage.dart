import 'package:flutter/material.dart';
import './pwscreen.dart';
import './instruction.dart';
import 'dart:async';

class TimePage extends StatefulWidget {
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  var time = new DateTime.now();

  String weekday() {
    String whatisthedaytoday;
    switch (time.weekday.toString()) {
      case "1":
        whatisthedaytoday = "Monday";
        break;
      case "2":
        whatisthedaytoday = "Tuesday";
        break;
      case "3":
        whatisthedaytoday = "Wednesday";
        break;
      case "4":
        whatisthedaytoday = "Thursday";
        break;
      case "5":
        whatisthedaytoday = "Friday";
        break;
      case "6":
        whatisthedaytoday = "Saturday";
        break;
      case "7":
        whatisthedaytoday = "Sunday";
        break;
    }
    return whatisthedaytoday;
  }

  Future<bool> _willpop(BuildContext context) {
    return Future.delayed(Duration(milliseconds: 100), () => false);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () => _willpop(context),
      child: new Scaffold(
          body: new Container(
        decoration: const BoxDecoration(
            image: const DecorationImage(
          fit: BoxFit.fill,
          image: const AssetImage("assets/bg2.jpg"),
        )),
        child: new Center(
          child: new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/8, 0, 0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new GestureDetector(
                          child: new Icon(
                            Icons.settings,
                            color: Colors.white70,
                            size: 30.0,
                          ),
                          onTap: () => Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new PasswordScreen()))),
                      new Padding(
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/36, 0, 0, 0),
                      )
                    ],
                  ),
                  new Text(
                    time.hour.toString() +
                        ":" +
                        time.minute.toString().padLeft(2, "0"),
                    style: TextStyle(
                        fontSize: 70.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                  new Text(
                      time.month.toString().padLeft(2, "0") +
                          "/" +
                          time.day.toString().padLeft(2, "0") +
                          "   " +
                          weekday(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.white)),
                  new Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*37/128),
                  ),
                  new GestureDetector(
                    child: new Text(
                      "Instruction",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new Instruction())),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
