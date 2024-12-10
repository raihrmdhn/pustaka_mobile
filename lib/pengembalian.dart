import 'package:flutter/material.dart';

class Pengembalian extends StatelessWidget {
  const Pengembalian({super.key});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          children: [
            new Padding(padding: new EdgeInsets.all(60.0),),
            new Text("WELCOME", style: TextStyle(fontSize:50.0 ),),
            new Padding(padding: new EdgeInsets.all(10.0),),
            new Icon(Icons.supervised_user_circle_rounded, size: 200.0,)
          ],
        ),
      ),
    );
  }
}