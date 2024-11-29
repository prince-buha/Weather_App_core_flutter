import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/Routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.homescreen);
    });
    return Scaffold(
      backgroundColor: const Color(0xffC6BC91),
      body: Column(
        children: [
          const SizedBox(height: 200),
          Center(
            child: Image.asset("assets/Time to Cook!.gif"),
          ),
          const SizedBox(height: 50),
          const Text(
            " Weather_App ",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 3,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            " Welcome ",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
