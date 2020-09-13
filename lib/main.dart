import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Root(),
    );
  }
}


// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//
//   SignInMethods signing= new SignInMethods();
//   runApp(MaterialApp(
//     home: signing.checkIfLoggedIn()? ,
//
//   ));
// }
//
// Navigator.of(context)
// .push(MaterialPageRoute(builder: (context) => Welcome(user)));