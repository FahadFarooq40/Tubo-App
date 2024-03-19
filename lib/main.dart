import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobo_app/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return const MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
