import 'package:flutter/material.dart';
import 'package:list_app/screens/dashboard.dart';

// scaffold - obtem uma estrutura de layout basico do material design
void main() {
  runApp(AppList());
  // save(Contact(0, 'merda', 54864)).then(
  //   (id) {
  //     findAll().then(
  //       (contacts) => debugPrint(
  //         contacts.toString(),
  //       ),
  //     );
  //   },
  // );
}

class AppList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
