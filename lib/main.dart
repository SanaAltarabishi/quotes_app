import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/quotes_provider.dart';
import 'package:quotes_app/welcom_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuotesProvider(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: WelcomePage()));
  }
}
