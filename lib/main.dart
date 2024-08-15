import 'package:flutter/material.dart';
import 'package:taegukgi/taegukgi/taegukgi.dart';

void main() {
  runApp(const TaegukgiApp());
}

class TaegukgiApp extends StatelessWidget {
  const TaegukgiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Taegukgi(),
        ),
      ),
    );
  }
}
