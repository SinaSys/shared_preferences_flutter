import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_flutter/user.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:getInfoFromPreferences(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if(snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name : ${snapshot.data.name}"),
                  Text("Age : ${snapshot.data.age.toString()}"),
                  Text("checkBoxStatus : ${snapshot.data.rememberMe}"),
                ],
              ),
            );
          }
          else{
            return Text("Error");
          }
        },

      ),
    );
  }
}

Future<User> getInfoFromPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String name = sharedPreferences.getString("nameValue");
  int age = sharedPreferences.getInt("ageValue");
  bool checkBoxStatus  = sharedPreferences.getBool("CheckBoxValue");
  return User(name, age,checkBoxStatus);
}
