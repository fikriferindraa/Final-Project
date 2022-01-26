import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab2_assignment/model/config.dart';
import 'package:lab2_assignment/model/user.dart';
import 'package:lab2_assignment/screens/screens.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth;

  final focus = FocusNode();
  final focus1 = FocusNode();
  final TextEditingController _emailditingController = TextEditingController();
  final focus2 = FocusNode();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
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
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 140),
                const Flexible(
                    child: Text('Ferindra.co',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lora',
                          fontSize: 55,
                        ))),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextInputField(),
                      PasswordInput(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgotPassword'),
                      child: const Text('Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RedHatText',
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      child: ElevatedButton(
                        onPressed: _loginUser,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Login',
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
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'RegisterAccount'),
                      child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 1)),
                          ),
                          child: const Text('Create new account',
                              style: TextStyle(
                                fontFamily: 'RedHatText',
                                color: Colors.white,
                                fontSize: 16,
                              ))),
                    ),
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        )
      ],
    );
  }

  void _loginUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."), title: const Text("Login user"));
    progressDialog.show();
    String _email = _emailditingController.text;
    String _pass = _passEditingController.text;
    http.post(Uri.parse(Config.server + "/lab2_assignment/php/login_user.php"),
        body: {"email": _email, "password": _pass}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = json.decode(response.body);
        print(response.body);
        User user = User.fromJson(jsonResponse);
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()));
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
      progressDialog.dismiss();
    });
  }
}

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key? key,
  }) : super(key: key);

  final focus1 = FocusNode();
  final focus2 = FocusNode();

  final TextEditingController _passEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          height: size.height * 0.08,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (val) => val!.isEmpty ? "Enter a password" : null,
            focusNode: focus1,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(focus2);
            },
            controller: _passEditingController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
              ),
              hintText: 'Password',
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            obscureText: true,
          )),
    );
  }
}

class TextInputField extends StatelessWidget {
  TextInputField({
    Key? key,
  }) : super(key: key);

  final focus = FocusNode();
  final focus1 = FocusNode();
  final TextEditingController _emailditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          height: size.height * 0.08,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: _emailditingController,
            validator: (val) =>
                val!.isEmpty || !val.contains("@") || !val.contains(".")
                    ? "enter a valid email"
                    : null,
            focusNode: focus,
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(focus1);
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
              ),
              hintText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          )),
    );
  }
}
