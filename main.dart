import 'package:first_app/login.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async{
    sqfliteFfiInit();
  // debugPaintSizeEnabled = true;
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: login(),
      ),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => H_App();
}

class H_App extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(100),
      color: Colors.teal,
      height: 100, // Set the height of the Container
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(22),
        ),
        child: SizedBox(
          height: 300, // Decrease the height of the Text widget
          child: Text(
            "Hello ",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class H_App2 extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Padding(
        padding: EdgeInsets.all(100.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(22),
          ),
          child: SizedBox(
            height: 60,

            width: 100, // Decrease the height of the Text widget
            child: Text(
              "Hello ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class Exact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => mybody();
}

class mybody extends State<Exact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My New Page"),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "hai",
                style: TextStyle(color: Colors.green),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Text(
            "click",
            style: TextStyle(color: Colors.red),
          );
        },
        child: Icon(Icons.access_alarms),
      ),
    );
  }
}
