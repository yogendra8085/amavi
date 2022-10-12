import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';
class loginapi{
  String ?userpasward;
  String ?email;
  String?token;
  SharedPreferences? prefs;

  loginapi(this.email,this.userpasward,this.token,this.prefs);

 Future<dynamic> loginauthentication()async{
    String? strPhpSessionID =
    prefs?.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
    String? strCurrency =
    prefs?.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
    String? strDefault =
    prefs?.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
    String? strLanguage =
    prefs?.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

    // Map<String, String> requestHeaders = {
    //   'Cookie': 'PHPSESSID=' +
    //       strPhpSessionID! +
    //       '; currency=' +
    //       strCurrency! +
    //       '; default=' +
    //       strDefault! +
    //       '; language=' +
    //       strLanguage! +
    //       ''
    // };
    final String strBaseUrl = Constants.LOGIN_URL + token!;
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = userpasward;

    final response = await http.post(Uri.parse(strBaseUrl),
        body: map, );

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    // LoginModel loginModel = LoginModel.fromJson(jsonResponse);
    prefs?.setString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN, "false");
    //await getFirebaseToken(context, strToken!, "login");
   // pr.hide();
    return jsonResponse;
  }




}
