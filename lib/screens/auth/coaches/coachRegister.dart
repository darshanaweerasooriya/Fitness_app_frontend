import 'package:finessmobileapp/components/coaches/appbar.dart';
import 'package:finessmobileapp/screens/auth/coaches/coachLoging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class coachRegister extends StatefulWidget {
  const coachRegister({super.key});

  @override
  State<coachRegister> createState() => _coachRegisterState();
}

class _coachRegisterState extends State<coachRegister> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phnum = TextEditingController();
  bool _isNotvalidate = false;

  Future<void> signUp() async {
    final Uri uri = Uri.parse('http://10.0.2.2:3001/api/users');

    final Map<String, dynamic> userData = {
      'username': usernameController.text,
      'email': useremail.text,
      'password': password.text,
      'phonenumber': phnum.text,
    };


    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(userData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showDialog('Success', 'Registration successful!', true);
      } else {
        _showDialog('Failed', 'Registration failed: ${response.body}', false);
      }
    } catch (error) {
      _showDialog('Error', 'An error occurred: $error', false);
    }
  }

  void _showDialog(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(color: isSuccess ? Colors.green : Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => caochappbar()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
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
              child: Image.asset(
                "images/coaches.webp",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(31.0)),
                child: Container(
                  height: 500,
                  color: Colors.white,
                  child: ListView(
                    padding: const EdgeInsets.only(top: 10),
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text("Welcome !",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text("Let’s reach your goal with us!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                            Text("Register to stay Fit and Healthy",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextField(usernameController, "Enter your username",
                          Icons.person, TextInputType.text),
                      _buildTextField(useremail, "Enter your email",
                          Icons.email, TextInputType.emailAddress),
                      _buildTextField(password, "Enter your password",
                          Icons.lock, TextInputType.text,
                          obscure: true),
                      _buildTextField(phnum, "Enter your phone number",
                          Icons.phone, TextInputType.phone),
                      SizedBox(height: 25),
                      Center(
                        child: ElevatedButton(
                          onPressed:
                          signUp,
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 50),
                            child: Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already a member? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => coachLoging()));
                              },
                              child: Text("Sign in",
                                  style: TextStyle(color: Colors.blueAccent)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      IconData icon, TextInputType type,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Container(
        height: 50,
        child: TextField(
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            errorStyle: TextStyle(color: Colors.red),
            errorText: _isNotvalidate ? "Enter proper Info" : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(icon, color: Colors.black),
            hintText: hintText,
            contentPadding:
            EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        ),
      ),
    );
  }
}