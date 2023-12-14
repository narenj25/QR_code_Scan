import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_sim_number/utils/get_number.dart';
import 'package:get_sim_number/view/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    GetMobileNumber getmobileNumber = GetMobileNumber();
    // ignore: unused_element
    void claimcoupon() async {
      String? mobNum = await getmobileNumber.getMobileNumberFromMobile();
      log(mobNum.toString());
    }

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
      ),
      home: BarcodeScanner(),
      debugShowCheckedModeBanner: false,
    );
  }
}
