import 'package:flutter/material.dart';
//import './pwscreen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';

class EmergencyCall extends StatefulWidget {
  @override
  _EmergencyCallState createState() => _EmergencyCallState();
}

class _EmergencyCallState extends State<EmergencyCall> {
  String displayNumber = "Emergency Call";

  List<String> _anime = [
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle",
    "idle"
  ];

  Widget number(String numericalvalue, String alphabet) {
    return new GestureDetector(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new SizedBox(
            width: 50,
            height: 50,
            child: new FlareActor(
              "assets/blob.flr",
              animation: (numericalvalue != "*") && (numericalvalue != "#")
                  ? _anime[int.parse(numericalvalue)]
                  : numericalvalue == "*"
                      ? _anime[10]
                      : numericalvalue == "#" ? _anime[11] : null,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: <Widget>[
              new Text(numericalvalue,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 25.0)),
              new Text(
                alphabet,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontSize: 10.0),
              ),
            ],
          ),
        ],
      ),
      onTap: (() async {
        int rank;

        switch (numericalvalue) {
          case "*":
            rank = 10;
            break;
          case "#":
            rank = 11;
            break;
          default:
            rank = int.parse(numericalvalue);
            break;
        }
        displayNumber == "Emergency Call"
            ? displayNumber = numericalvalue
            : displayNumber = displayNumber + numericalvalue;

        setState(() {
          _anime[rank] = "blob";
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              _anime[rank] = "idle";
            });
          });
        });
      }),
    );
  }

  Widget displayrow(
    String value1,
    String alphabet1,
    String value2,
    String alphabet2,
    String value3,
    String alphabet3,
  ) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        number(value1, alphabet1),
        number(value2, alphabet2),
        number(value3, alphabet3)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // new Image.asset("assets/bg2.jpg"),
              new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text(displayNumber,
                      style: TextStyle(color: Colors.white, fontSize: 35.0)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 9 / 128, 0, 0),
                  ),
                  displayrow("1", " ", "2", "ABC", "3", "DEF"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 5 / 128, 0, 0),
                  ),
                  displayrow("4", "GHI", "5", "JKL", "6", "MNO"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 5 / 128, 0, 0),
                  ),
                  displayrow("7", "PQRS", "8", "TUV", "9", "WXYZ"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 5 / 128, 0, 0),
                  ),
                  displayrow("*", " ", "0", "+", "#", " "),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 5 / 128, 0, 0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () => Navigator.of(context).pop(true),
                        child: new Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                      new Icon(Icons.call, color: Colors.green, size: 50.0),
                      new GestureDetector(
                        onTap: () {
                          setState(() {
                            displayNumber == "Emergency Call"
                                ? null
                                : displayNumber = displayNumber.substring(
                                    0, displayNumber.length - 1);

                            displayNumber == ""
                                ? displayNumber =
                                    displayNumber = "Emergency Call"
                                : null;
                          });
                          print(displayNumber[displayNumber.length - 1]);
                        },
                        child: new Text(
                          "Delete",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 16),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
