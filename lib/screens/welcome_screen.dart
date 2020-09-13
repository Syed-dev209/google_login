import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import 'package:com/models/login_methods.dart';
import 'package:com/models/prefs.dart';
import 'package:com/screens/crud.dart';

class Welcome extends StatefulWidget {
  final FirebaseUser _user;

  Welcome(this._user);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  VisitingFlag visit = new VisitingFlag();
  bool isLoggedin = true;

  @override
  Widget build(BuildContext context) {
    SignInMethods sigining = new SignInMethods(context);
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget._user.photoUrl),
                ),
                SizedBox(height: 20.0),
                Text(widget._user.displayName),
                SizedBox(height: 20.0),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  elevation: 5.0,
                  color: Colors.teal,
                  splashColor: Colors.grey,
                  onPressed: () async {

                    isLoggedin = await sigining.signOut();
                    setState(() {
                      if (isLoggedin == false) {
                        visit.removeUser();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>LoginScreen()
                        ));
                      }
                    });
                  },
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  elevation: 5.0,
                  color: Colors.teal,
                  splashColor: Colors.grey,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>CRUD()
                    ));
                  },

                )
              ],
            ),
          ),
        ),
      ),
      onWillPop:sigining.onWillPop,
      );

  }


}
