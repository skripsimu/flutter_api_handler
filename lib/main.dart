import 'package:flutter/material.dart';
import 'package:flutter_api_handler/views/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api Handler',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
