// ignore_for_file: prefer_const_constructors

import 'package:ActionListener/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../functionality/images.dart';
import 'Login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double deviceWidth = mediaQuery.size.width;
    double deviceHeight = mediaQuery.size.height;
    void register() async {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'The password provided is too weak! Please try again.',
                style: TextStyle(
                  fontFamily: "MetalMania",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Color(0xfffc8350),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'The account already exists for that email! Please try again.',
                style: TextStyle(
                  fontFamily: "MetalMania",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Color(0xfffc8350),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffc8350),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              Big_Start_Icon,
              height: 270,
              width: double.infinity,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff1e202c),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceHeight * 0.04,
                      ),
                      child: Text(
                        "Welcome to the",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.01),
                      child: Text(
                        "ActionListener",
                        style: TextStyle(
                          color: Color(0xFFF9BD59),
                          fontSize: 40,
                          fontFamily: "MetalMania",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.04),
                      child: Container(
                        height: deviceHeight * 0.07,
                        width: deviceWidth * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: deviceWidth * 0.02,
                              top: deviceHeight * 0.004),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 76, 75, 75)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.01),
                      child: Container(
                        width: deviceWidth * 0.7,
                        height: deviceHeight * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: deviceWidth * 0.02,
                              top: deviceHeight * 0.004),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 76, 75, 75)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.03),
                      child: Container(
                        width: deviceWidth * 0.7,
                        height: deviceHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF9BD59),
                          ),
                          onPressed: () async {
                            register();
                          },
                          child: Text(
                            "Next ->",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight * 0.03),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Already registered?\nClick Here To Login..",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFF9BD59),
                            wordSpacing: 1,
                            fontFamily: "MetalMania",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
