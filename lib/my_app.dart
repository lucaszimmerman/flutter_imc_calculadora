import 'package:flutter/material.dart';
import 'package:imc_calculadora/page/imc_calculator_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const IMCCalculatorPage(),
    );
  }
}
