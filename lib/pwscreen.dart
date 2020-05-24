import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:math';
import 'dart:async';
import 'package:vibrate/vibrate.dart';
import 'package:flutter/services.dart';
import './emergencycall.dart';

//import './timepage.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  static const platform = MethodChannel('samples.flutter.io/contact');
  int passwordinsert = 0;
  String deleteback = "Back";
  bool trigger = false;
  FocusNode _disableVolumeNode = new FocusNode();
  double pad1 = 1/128;

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
  ];

  List<String> animationlist = [
    "Wrong pw",
    "F R1 white",
    "F R2 white",
    "F R3 white",
    "F R4 white",
    "F R1 dim",
    "F R2 dim",
    "F R3 dim",
    "F R4 dim"
  ];
  var range = new Random();
  void flare(int passwordinsert) {
    setState(() {
      _animation = animationlist[passwordinsert];
      passwordinsert == 0 ? deleteback = "Back" : deleteback = "Delete";
    });
  }

  void unflare(int passwordinsert) {
    setState(() {
      _animation = animationlist[passwordinsert + 5];
      passwordinsert == 0 ? deleteback = "Back" : deleteback = "Delete";
    });
  }

  handleKey(RawKeyEvent key) {
    _disableVolume(key);
    RawKeyEventDataAndroid dat = key.data;
    key.runtimeType.toString() == "RawKeyDownEvent"
        ? trigger = dat.keyCode == 24 ? true : false
        : null;
    //print(key.runtimeType.toString());
  }

  Future<void> _disableVolume(RawKeyEvent event) async {
    try {
      await platform.invokeMethod("hideVolume", event);
    } catch (e) {
      print(e);
    }
  }

  _buildComposer() {
    FocusScope.of(context).requestFocus(_disableVolumeNode);
    //print (MediaQuery.of(context).size.width);
    return new RawKeyboardListener(
      
      focusNode: _disableVolumeNode,
      onKey: (key) => handleKey(key),
      child: new SizedBox(
        width: 1.0,
        height: 1.0,
      ),
    );
    
  }

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
              animation: numericalvalue == " "
                  ? null
                  : _anime[int.parse(numericalvalue)],
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
        if (alphabet != " " || numericalvalue != " ") {
          if (passwordinsert == 3) {
            if (trigger == true) {
              SystemNavigator.pop();
            } else {
              passwordinsert = 0;
              Vibrate.vibrate();
            }
            //passwordinsert == 0? deleteback = "Back" : deleteback = "Delete";
          } else {
            passwordinsert++;
          }
          flare(passwordinsert);
          int rank = int.parse(numericalvalue);
          setState(() {
            _anime[rank] = "blob";
            Future.delayed(Duration(milliseconds: 500), () {
              setState(() {
                _anime[rank] = "idle";
              });
            });
          });
        }
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

  /*Future<bool> _onWillPop(){
    return Future.delayed(Duration(milliseconds: 100), ()=> trigger== true? true: false);
  }*/

  //FlareController flareController;
  String _animation = "Do nothing";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: //new WillPopScope(
            //onWillPop: () => _onWillPop(),
            //child:
            new Container(
                decoration: const BoxDecoration(
                    image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: const AssetImage("assets/bg2.jpg"),
                )),
                child: new Center(
                  child: new Stack(
                    //alignment: Alignment.center,
                    children: <Widget>[
                      _buildComposer(),

                      //new Image.asset("assets/bg2.jpg", fit: BoxFit.cover),
                      Positioned(
                        child: FlareActor(
                          "assets/pw.flr",
                          fit: BoxFit.fitWidth,
                          animation: _animation,
                        ),
                        left: (MediaQuery.of(context).size.width - 250) / 2,
                        
                        top: (MediaQuery.of(context).size.height - 200) / 2,
                        width: 250,
                        height: 120,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          displayrow("1", " ", "2", "ABC", "3", "DEF"),
                          new Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*pad1),
                          ),
                          displayrow("4", "GHI", "5", "JKL", "6", "MNO"),
                          new Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*pad1),
                          ),
                          displayrow("7", "PQRS", "8", "TUV", "9", "WXYZ"),
                          new Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*pad1),
                          ),
                          displayrow(" ", " ", "0", "+", " ", " "),
                          new Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*pad1*2),
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/8, 0.0, 0.0, 0.0)),
                              new GestureDetector(
                                  child: new Text(
                                    "EMERGENCY",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new EmergencyCall()))),
                              new Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width*3/8, 0.0, 0.0, 0.0)),
                              new GestureDetector(
                                child: new Text(
                                  deleteback,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                onTap: () {
                                  if (passwordinsert != 0) {
                                    passwordinsert--;
                                    unflare(passwordinsert);
                                    //print(passwordinsert);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                              )
                            ],
                          ),
                          new Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.height*3/64),
                          )
                        ],
                      ),
                    ],
                  ),
                  //),
                )));
  }
}
