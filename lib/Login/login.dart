import 'dart:convert';

import 'package:flutter/material.dart';

import '../Dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

import '../Dashboard/listofapplicants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please sign in to continue',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: ()async {
                          String passwordurl = _passwordController.text;
                          print("Test string $passwordurl");
                          String emailurl = _emailController.text;
                          final url = Uri.parse('https://corp-u.herokuapp.com/getPermanent/$emailurl/$passwordurl');
                          print(url);



                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 10),
                                  Text('Loading...'),
                                ],
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          try {
                            final response = await http.get(url);
                            print("Testing one two three");

                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              // Handle the fetched data
                              final data = jsonDecode(response.body);
                              print(data);
                              PermanentStaff permanentdata = PermanentStaff(courseid: data['qualification'], id: data['_id']);
                              print("data is $permanentdata");
                              // Navigate to another screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(data:permanentdata),
                                ),
                              );
                            } else {
                              throw Exception('Failed to fetch data');
                            }
                          } catch (error) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            final errorSnackBar = SnackBar(
                              content: Text('Failed to fetch data'),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                          }















                          // CircularProgressIndicator();
                          //
                          // String passwordurl = _passwordController.text;
                          // print("Test string $passwordurl");
                          // String emailurl = _emailController.text;
                          // var url = Uri.parse(
                          //     'https://corp-u.herokuapp.com/getSessional/$emailurl/$passwordurl');
                          //
                          // var response = await http.get(url);
                          //
                          // if (response.statusCode == 200) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomeScreen(),
                          //     ),
                          //   );
                          // } else {
                          //   _showSnackBar(
                          //       context, "Something Went Wrong", "Dissmiss");
                          // }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () {
                    //
                    //     },
                    //     child: Text(
                    //       'Forgot Password?',
                    //       style: TextStyle(
                    //         color: Colors.grey,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    // Center(
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Sign Up',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
