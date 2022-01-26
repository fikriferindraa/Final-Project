import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab2_assignment/model/config.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

void main3() => runApp(const RegisterAccount());

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  bool _isChecked = false;
  late double screenHeight, screenWidth;
  String eula = "";

  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: [
          const SizedBox(height: 50),
          CircleAvatar(
            radius: size.width * 0.14,
            backgroundColor: Colors.grey[400],
            child: const Icon(
              Icons.person,
              color: Colors.grey,
              size: 55,
            ),
          ),
          const SizedBox(height: 20),
          const Flexible(
              child: Text('Register New Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RedhatText-Bold',
                    fontSize: 30,
                  ))),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _nameEditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Full Name',
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (val) => val!.isEmpty || (val.length < 3)
                        ? "name must be longer than 3"
                        : null,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _emailditingController,
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
                    validator: (val) =>
                        val!.isEmpty || !val.contains("@") || !val.contains(".")
                            ? "enter a valid email"
                            : null,
                    focusNode: focus,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus1);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
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
                    textInputAction: TextInputAction.next,
                    validator: (val) => validatePassword(val.toString()),
                    focusNode: focus1,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus2);
                    },
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _pass2EditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Confirm Passowrd',
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    validator: (val) {
                      validatePassword(val.toString());
                      if (val != _passEditingController.text) {
                        return "password do not match";
                      } else {
                        return null;
                      }
                    },
                    focusNode: focus2,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus3);
                    },
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Checkbox(
                  value: _isChecked,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
              ),
              Flexible(
                  child: GestureDetector(
                      onTap: _showEULA,
                      child: const Text('   Agree with terms and conditions',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'RedHatText',
                            color: Colors.white,
                          ))))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: size.height * 0.08,
            width: size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              onPressed: _registerAccountDialog,
              child: const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RedHatText',
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    ]);
  }

  String? validatePassword(String value) {
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void _showEULA() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Eula",
            style: TextStyle(),
          ),
          content: SizedBox(
            height: 500,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.black),
                        text: eula),
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _registerAccountDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept the terms and conditions",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUserAccount();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  loadEula() async {
    eula = await rootBundle.loadString('assets/eula.txt');
  }

  void _registerUserAccount() {
    FocusScope.of(context).requestFocus(FocusNode());
    String _name = _nameEditingController.text;
    String _email = _emailditingController.text;
    String _pass = _passEditingController.text;

    http.post(
        Uri.parse(Config.server + "/lab2_assignment/php/register_user.php"),
        body: {
          "name": _name,
          "email": _email,
          "password": _pass
        }).then((response) {
      print(response.body);
    });
  }
}
