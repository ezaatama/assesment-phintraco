import 'package:flutter/material.dart';
import 'package:phintraco_assesment/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1, milliseconds: 30), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.WHITE,
      body: Container(
        margin: const EdgeInsets.all(50),
        child: Center(
          child: Image.asset("assets/icons/logo_phintraco.png",
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}
