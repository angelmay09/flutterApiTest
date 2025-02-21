import 'package:flutter/material.dart';
import 'person_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Exam',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: PersonListScreen(),
    );
  }
}
