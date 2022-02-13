import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        fontFamily: 'RedHatText',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashPage(),
      routes: {
        'HomePage': (context) => const HomePage(),
        'LoginScreen': (context) => const LoginScreen(),
        'ForgotPassword': (context) => const ForgotPassword(),
        'RegisterAccount': (context) => const RegisterAccount(),
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Scaffold(backgroundColor: Color(0xff2C3A47)),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset('assets/images/fndlogo.png',
                      height: 223, width: 253),
                ],
              ),
              const CircularProgressIndicator(),
              const Text(
                'version 0.1',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'RedHatText-Light',
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
