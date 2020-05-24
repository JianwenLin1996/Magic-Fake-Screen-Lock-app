import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  static const List<String> iapId = [
    'com.jianwen.screenlock.sweets',
    'com.jianwen.screenlock.coffee',
    'com.jianwen.screenlock.motivation'
  ];
  List<IAPItem> _items = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // prepare
    var result = await FlutterInappPurchase.initConnection;
    //print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // refresh items for android
    String msg = await FlutterInappPurchase.consumeAllItems;
    //print('consumeAllItems: $msg');
    await _getProduct();
  }

  Future<Null> _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.getProducts(iapId);
    for (var item in items) {
      //print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
    });
  }

  Future<Null> _buyProduct(IAPItem item) async {
    try {
      print(item.productId.toString());
      PurchasedItem purchased =
          await FlutterInappPurchase.buyProduct(item.productId);
      //print(purchased);
      String message = await FlutterInappPurchase.consumeAllItems;
      Fluttertoast.showToast(
          msg: "Really appreciate that. Have a nice day!",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      //print('consumeAllItems: $msg');
    } catch (error) {
      //print('$error');
    }
  }

  Widget options(String description, String price, int item) {
    return new Row(
      children: <Widget>[
        new SizedBox(
            height: 80.0,
            width: 250.0,
            child: new Text(
              "\n\n" + description,
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.w600),
            )),
        new RaisedButton(
          color: Colors.blueGrey,
          child: new Text(price,
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
          onPressed: () => _buyProduct(_items[item]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Your Generousity Helps")),
      body: new ListView(
        children: <Widget>[
          options("A few cents will help too! At least I can buy some \bSWEETS\b!",
              "~0.99 USD", 2),
          options("How about buying me a cup of \bCOFFEE\b?", "~2.50 USD", 0),
          options(
              "A tasty extra large \bPIZZA\b will definitely be the best treat for me!",
              "~25.00 USD",
              1),
        ],
      ),
    );
  }
}
