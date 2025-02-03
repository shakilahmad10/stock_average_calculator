import 'package:average_cal/views/stock_calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 68, 175, 18)),
        useMaterial3: true,
      ),
      home: const StockCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
