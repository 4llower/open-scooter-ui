import 'package:flutter/material.dart';
import 'package:open_scooter_ui/models/balance.dart';
import 'package:open_scooter_ui/models/scooter.dart';
import 'package:open_scooter_ui/models/user.dart';
import 'package:open_scooter_ui/screens/balance.dart';
import 'package:open_scooter_ui/screens/finish.dart';
import 'package:open_scooter_ui/screens/home.dart';
import 'package:open_scooter_ui/screens/login.dart';
import 'package:open_scooter_ui/screens/qr.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BalanceModel>(create: (_) => BalanceModel()),
        Provider<UserModel>(create: (_) => UserModel()),
        Provider<ScooterModel>(create: (_) => ScooterModel())
      ],
      child: App(),
    );
  }
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
