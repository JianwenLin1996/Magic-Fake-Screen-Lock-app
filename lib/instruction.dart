import 'package:flutter/material.dart';
//import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import './donate.dart';

class Instruction extends StatefulWidget {
  @override
  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Instruction"),
      ),
      body: new Center(
        child: new ListView(children: <Widget>[
          new Text(
              "This is a MOCK SCREEN LOCK app which can be used to perform trick. Press the setting icon at the right corner of time-display page and proceed to the page where password page."),
          new Padding(
            padding: EdgeInsets.all(15),
          ),
          new Text(
              "Press Volume_UP button at the side of your phone once to turn ON Exit-App function. Any password inserted after that will exit the app."),
          new Padding(
            padding: EdgeInsets.all(15),
          ),
          new Text(
              "Press Volume_DOWN button at the side of your phone again to turn OFF Exit-App function. Any password inserted after that is WRONG password."),
          new Padding(
            padding: EdgeInsets.all(15),
          ),
          new Text(
              "You may use it to do MAGIC trick like guessing what numbers other is thinking."),
          new Padding(
            padding: EdgeInsets.all(15),
          ),
          new Text(
              "Just turn ON the Exit-App function (without audience notice), then claim that you know the password before hand and let the audience key in the password."),
          new RaisedButton(
            child: new Text(
              "Donate",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic),
            ),
            color: Colors.yellowAccent,
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Donate())),
          ),
          /*new Padding(
            padding: EdgeInsets.all(50),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "PRACTICE MAKES PERFECT",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          new Padding(
            padding: EdgeInsets.all(15),
          ),
          new Text(
            "Switch your phone to silent mode.\nDo not turn on WIFI or data connection while performing.",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
          ),
          new Padding(
            padding: EdgeInsets.all(15),
          ),
          new Text(
            "Take note that the Home and Menu button are still functioning, do not let audience press them. Else, app will exit.",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
          ),
          new Padding(
            padding: EdgeInsets.all(15),
          ),

          new Text(
            "Any feedback or inquiry, feel free to reach me at jianwenapp1996@gmail.com",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
          ),

          /*new Text("This is a mock screen lock which perform can be used to perform trick. 
            Proceed to the page where password is entered, the app wont exit for any password. 
            However, after you pressed the volume_up button at the side of your phone. 
            Exit-App function will be tuened ON and the app will exit for any password.
            Press volume_down to turn off the Exit-App function."),
            new Text("Please take note that Home and Menu button is still functioning in this app, 
            don't let audience press them.", style: TextStyle(color: Colors.red))*/
        ]),
      ),
    );
  }
}
