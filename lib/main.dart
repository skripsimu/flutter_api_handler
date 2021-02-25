import 'package:flutter/material.dart';
import 'package:flutter_api_handler/views/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/bloc/api_bloc.dart';
import 'api/repositories/api_repository.dart';


void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
