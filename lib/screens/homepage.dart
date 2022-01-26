import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loginscreen.dart';
import 'registeraccount.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF383838),
          body: Stack(children: [
            Container(
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image:
                          AssetImage('assets/images/backgroundmainpage.png'))),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 43,
                    width: 163,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFF7E00),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RedHatText',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Text('OR',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "RedHatText",
                        color: Colors.white,
                      )),
                  Container(
                    height: 43,
                    width: 163,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFF7E00),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterAccount()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RedHatText',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
