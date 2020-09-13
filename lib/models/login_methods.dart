import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:com/models/prefs.dart';
import 'package:com/screens/welcome_screen.dart';
import 'package:com/screens/login_screen.dart';

class SignInMethods {

  BuildContext context;
  SignInMethods(this.context);
  VisitingFlag visit=new VisitingFlag();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  final GoogleSignIn googleSignIn = new GoogleSignIn(scopes: ['email']);
  bool isLoggedIn = false;

  Future<bool> signIn() async {
    GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signIn(); //Google user ko get kary ga
    GoogleSignInAuthentication gsa = await googleSignInAccount
        .authentication; //google account lo authenticate kary ga
    AuthCredential credentials = GoogleAuthProvider.getCredential(
        idToken: gsa.idToken, accessToken: gsa.accessToken);
    String accessToken = gsa.accessToken;
    String idToken=gsa.idToken;
    visit.setloginWithGooglePref(accessToken, idToken);
    AuthResult result = await _auth.signInWithCredential(credentials);
    user = result.user;
    isLoggedIn = true;

    return isLoggedIn;
  }

  Future<bool> signOut() async {
    await _auth.signOut().then((value) {
      googleSignIn.signOut();
      isLoggedIn = false;
    });
    return isLoggedIn;
  }

  checkIfLoggedIn(context) async {
    bool check = await visit.getVisitingFlag();
    print(check);
    if (check == true) {
      String accessToken = await visit.getAccessToken();
      String idToken = await visit.geIdToken();
      if (accessToken != null && idToken != null) {
        AuthCredential credentials = GoogleAuthProvider.getCredential(
            idToken: idToken, accessToken: accessToken);
        AuthResult result = await _auth.signInWithCredential(credentials);
        user = result.user;
      }
      Navigator.push(context,MaterialPageRoute(builder: (context) => Welcome(user)));
    }
    else{
      Navigator.push(context,MaterialPageRoute(
        builder: (context)=>LoginScreen()
      ));
    }
  }

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Confirm Exit?',
            style: new TextStyle(color: Colors.black, fontSize: 20.0)),
        content: new Text(
            'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              // this line exits the app.
              SystemChannels.platform
                  .invokeMethod('SystemNavigator.pop');
            },
            child:
            new Text('Yes', style: new TextStyle(fontSize: 18.0)),
          ),
          new FlatButton(
            onPressed: () => Navigator.pop(context), // this line dismisses the dialog
            child: new Text('No', style: new TextStyle(fontSize: 18.0)),
          )
        ],
      ),
    ) ??
        false;

  }
}
