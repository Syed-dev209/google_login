import 'package:shared_preferences/shared_preferences.dart';

class VisitingFlag{
  SharedPreferences _prefs;

  setVisitingFlag(bool loggedIn)async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("boolValue", loggedIn);
    print(loggedIn);

  }
  setloginWithGooglePref(String accessToken,String idToken) async
  {
    _prefs=await SharedPreferences.getInstance();
    _prefs.setString('accessToken', accessToken);
    _prefs.setString('idToken', idToken);
  }

  Future<String> getAccessToken() async
  {
    _prefs=await SharedPreferences.getInstance();
    String accessToken=_prefs.getString('accessToken');
    return accessToken;
  }

  Future<String> geIdToken() async
  {
    _prefs=await SharedPreferences.getInstance();
    String idToken=_prefs.getString('idToken');
    return idToken;
  }

  Future<bool> getVisitingFlag()async{
    _prefs=await SharedPreferences.getInstance();
    bool isLoggedin =_prefs.getBool("boolValue") ?? false;
    return isLoggedin;
  }

  removeUser()async{
    _prefs=await SharedPreferences.getInstance();
    _prefs.remove("boolValue");
    _prefs.remove('accessToken');
    _prefs.remove('idToken');
  }

}

