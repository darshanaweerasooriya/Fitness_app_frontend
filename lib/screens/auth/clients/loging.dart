import 'package:finessmobileapp/screens/auth/clients/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class logingScrenn extends StatefulWidget {
  const logingScrenn({super.key});

  @override
  State<logingScrenn> createState() => _logingScrennState();
}

class _logingScrennState extends State<logingScrenn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotvalidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Image.asset("images/authpageclients.jpg", fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(31.0)),
                child: Container(
                  width: 400,
                  height: 450,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              "Welcome Back ! ",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              "Let’s reach your goal with us!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              "We can secure the health of your health",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              "for the better future ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Username field
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 50,
                              height: 50,
                              child: TextField(
                                controller: usernameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  errorStyle: TextStyle(color: Colors.red),
                                  errorText: _isNotvalidate
                                      ? "Enter proper Info"
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                      Icons.person, color: Colors.black),
                                  hintText: 'Enter your username',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        // Password field
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 50,
                              height: 50,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  errorStyle: TextStyle(color: Colors.red),
                                  errorText: _isNotvalidate
                                      ? "Enter proper Info"
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                      Icons.lock, color: Colors.black),
                                  hintText: 'Enter your Password',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => registerClients()),
                                );
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                  color: Colors.blueAccent.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Sign In button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 220,
                              child: ElevatedButton(
                                onPressed: loginUser,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.black),
                                ),
                                child: const Text("Sign in", style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),

                        // Sign up redirect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 240,
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  Text("New to HealthBite? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                           registerClients()),
                                      );
                                    },
                                    child: Text("Sign up", style: TextStyle(
                                        color: Colors.blueAccent)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
