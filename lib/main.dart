import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_flutter/home_screen.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Shared Preferences")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: InputDecoration(hintText: "Enter Your name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(hintText: "Enter Your Age"),
                controller: ageController,
              ),
            ),
            CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("Remember me"),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                }),
            SizedBox(height: 50.0),
            RaisedButton(
                child: Text("Go to Home Screen With save info"),
                onPressed: () {
                  saveInfoToPreferences(nameController.text.trim(),
                      int.parse(ageController.text), isChecked);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                }),
            RaisedButton(
                child: Text("Go to Home Screen Without save info"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                }),

          ],
        ));
  }
}

void saveInfoToPreferences(
    String nameValue, int ageValue, bool isChecked) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("CheckBoxValue", isChecked);
  sharedPreferences.setInt("ageValue", ageValue);
  sharedPreferences.setString("nameValue", nameValue);
}
