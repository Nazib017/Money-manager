import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/models/amount_model.dart';
import 'package:money_management/screens/bottom_navbar.dart';
import 'package:money_management/screens/homescreen.dart';
import 'package:money_management/models/expanse_model.dart';
import 'package:money_management/controllers/expanse_controller.dart';
import 'package:money_management/controllers/amount_controller.dart';
import 'package:money_management/screens/homescreen.dart';
import 'package:intl/intl.dart';
import 'package:money_management/screens/splash_screen.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExModelAdapter());
  Hive.registerAdapter(AmountModelAdapter());
  await Hive.openBox("Expense");
  await Hive.openBox("CurrentM");

  await Hive.openBox("AddMoney");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      home:SplashScreen() ,
    );
  }
}

