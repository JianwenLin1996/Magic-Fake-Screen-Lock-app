import 'package:flutter/material.dart';
import './timepage.dart';
import 'package:flutter/services.dart';

void main() {
  
  SystemChrome.setEnabledSystemUIOverlays([]);
 // SystemChrome.setEnabledSystemUIOverlays()
  runApp(new MaterialApp(home: new TimePage()));
}
