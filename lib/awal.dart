import 'package:flutter/material.dart';

class Awal extends StatelessWidget {
  const Awal({super.key});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Column(
          children: [
            new Padding(padding: new EdgeInsets.all(60.0),),
            new Text("WELCOME", style: TextStyle(fontSize:50.0, fontWeight: FontWeight.bold),),
            new Padding(padding: new EdgeInsets.all(10.0),),
            new Icon(Icons.supervised_user_circle_rounded, size: 200.0,color: Colors.black,)
          ],
        ),
      ),
    );
  }
}