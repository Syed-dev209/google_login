import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'welcome_screen.dart';
import 'package:com/models/login_methods.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:com/models/prefs.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoggedIn = false;
  bool showSpinner=false;
  VisitingFlag visit = new VisitingFlag();

  @override
  Widget build(BuildContext context) {
    SignInMethods signing = new SignInMethods(context);
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Google Sign in '),
          leading: Icon(Icons.vpn_key),
          backgroundColor: Colors.teal,
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autovalidate: true,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                      EmailValidator(errorText: 'Not a valid Email')
                    ]),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    autovalidate: true,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                      MinLengthValidator(6, errorText: 'Too small'),
                      MaxLengthValidator(10, errorText: 'Password too long')
                    ]),
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.remove_red_eye),
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      elevation: 5.0,
                      color: Colors.teal,
                      splashColor: Colors.grey,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print('Pressed Successfully');
                        } else {
                          print('Somethings Wrong');
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                    child: Text(
                      'Log In with Google',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    elevation: 5.0,
                    color: Colors.blueGrey,
                    splashColor: Colors.grey,
                    onPressed: () async {
                      setState(() {
                        showSpinner=true;
                      });

                      isLoggedIn = await signing.signIn();
                        if (isLoggedIn) {

                          visit.setVisitingFlag(isLoggedIn);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Welcome(signing.user)));
                        }
                        setState(() {
                          showSpinner=false;
                        });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: signing.onWillPop,
    );
  }
}
