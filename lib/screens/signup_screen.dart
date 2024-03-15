import 'package:flutter/material.dart';
import 'package:padika/screens/dashboard.dart';
import 'package:padika/screens/login_screen.dart';
import 'package:padika/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userNameContoller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        "username": _userNameContoller.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await authService.createUser(data, context);
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SIGN-UP",
          style: TextStyle(color: Colors.white,fontFamily: "Raleway",fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0D7207),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 500, // Adjusted height
            child: Image.asset(
              'assets/images/sign_up_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 300.0), // Adjusted padding
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _userNameContoller,
                          decoration: InputDecoration(labelText: "Username"),
                          style: TextStyle(color: Colors.black),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: "Password"),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Increased space between form and buttons
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: isLoader
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(
                      'Create',
                      style: TextStyle(color: Color(0xFF0D7207), fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 10), // Added space between buttons
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color.fromARGB(255, 241, 89, 0), fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
