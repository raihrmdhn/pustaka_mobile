import 'package:flutter/material.dart';
import './awal.dart' as Awal;
import './menu.dart' as Menu;
import './news.dart' as News;

void main() {
  runApp(MaterialApp(
    home: const Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin{
  late TabController controller;

  @override
  void initState() {
   controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text("MyLibrary", style: TextStyle(color: Colors.white),),
        bottom: new TabBar(
          controller: controller,
          tabs: [
            new Tab(icon: new Icon(Icons.home, color: Colors.white,),),
            new Tab(icon: new Icon(Icons.menu_book, color: Colors.white,),),
            new Tab(icon: new Icon(Icons.newspaper_sharp, color: Colors.white,),),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: [
          Awal.Awal(),
          Menu.Menu(),
          News.News(),



        ],
      ),

    );
  }
}
