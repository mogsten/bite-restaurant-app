import 'dart:convert';

import 'package:bite_restaurant/orderList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'models/userModel.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  String _username = "";
  String _password = "";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: null,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

             Container(
                margin: EdgeInsets.all(20),
                child:
                Container(
                  width: 450.0,
                  child:
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                onChanged: (String value) async {
                  print(value);
                  _username = value;
                },
              ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child:
                Container(
                  width: 450.0,
                  child:
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                onChanged: (String value) async {
                  print(value);
                  _password = value;
                },
              ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child:
              Container(
                color: Color(0xff0060a8),
                width: MediaQuery.of(context).size.width / 3,
                height: 50,
                child:
              RaisedButton(
                color: Color(0xff0060a8),
                textColor: Colors.white,
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 18)
                ),
                onPressed: () async {

                  int statusCode = 0;
                  String responseBody = "";

                  print("LOGIN REQUESTED");
                    
                  print("Username: $_username");
                  print("Password: $_password");
                  final String usernameStr = "$_username";
                  final passwordStr = "$_password";
                  //?username=${_username.toString()}&password=${_password.toString()}
                  String uri = 'http://vps189597.vps.ovh.ca/api/login/';
                  Map<String, String> body = {
                    "username":_username.toString(),
                    "password":_password.toString(),
                  };

                  final response = await http.post(
                    uri,
                    body: body,
                    headers: {
                      "Accept": "application/json",
                      "Content-Type": "application/x-www-form-urlencoded"
                    },
                    encoding: Encoding.getByName("utf-8")
                  );

                  print(response);
                  print(response.body);
                  print(response.statusCode);

                  var users = List<Users>();
                  if (response.statusCode == 200) {
                    users.add(Users.fromJson(json.decode(response.body)));

                    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
                    print(decoded["access_token"]);
                    var accessToken = decoded["access_token"].toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderList(access_token: accessToken)),
                    );
                  } else {
                    print("Don't Navigate - Login Failed");
                  }

                },
              )
              ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
