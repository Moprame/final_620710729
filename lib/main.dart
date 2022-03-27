import 'package:final_620710729/service/api.dart';
import 'package:final_620710729/view/home_page.dart';
import 'package:flutter/material.dart';


void main() {
  //Api().fetch("quizzes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}