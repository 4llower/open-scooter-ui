import 'package:flutter/material.dart';
import 'package:open_scooter_ui/screens/balance.dart';
import 'package:open_scooter_ui/screens/finish.dart';
import 'package:open_scooter_ui/screens/home.dart';
import 'package:open_scooter_ui/screens/login.dart';
import 'package:open_scooter_ui/screens/qr.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Scooter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
        '/balance': (context) => Balance(),
        '/qr': (context) => QRScanner(),
        '/finish': (context) => Finish(),
      },
    );
  }
}
