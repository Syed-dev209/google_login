import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:com/models/login_methods.dart';
import 'welcome_screen.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    SignInMethods obj = new SignInMethods(context);
    obj.checkIfLoggedIn(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}

