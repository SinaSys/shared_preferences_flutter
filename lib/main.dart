import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_flutter/home_screen.dart';
import 'package:shared_preferences_flutter/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shared Preferences")),
      body: Center(
        child: FlatButton(
            child: Text("Proceed"),
            onPressed: () async {

              setVisitingFlag();

              if(await getVisitingFlag()){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              }
              else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
              }
            }),
      ),
    );
  }
}

void setVisitingFlag() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("alreadyVisited", true);
}

Future<bool> getVisitingFlag() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool alreadyVisited = sharedPreferences.getBool("alreadyVisited") ?? false;
  return alreadyVisited;
}
