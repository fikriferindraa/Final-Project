import 'package:flutter/material.dart';

void main2() => runApp(const ForgotPassword());

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [Colors.black, Colors.transparent],
        ).createShader(rect),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splashpage.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            title: const Text('Forgot Password'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: const Text(
                      'Enter your email and we will send instruction to reset your password',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'RedHatText',
                        fontSize: 14,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Email Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: size.width * 0.8,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RedHatText',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    ]);
  }
}
