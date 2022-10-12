import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/LogoutModel.dart';
import '../Model/TokenModel.dart';
import '../Pages/splash.dart';

class logoutapiloging{
  Future<LogoutModel> logoutUser(BuildContext context) async {
    final String strBaseUrl = Constants.LOGOUT_URL;

    // Map<String, String> requestHeaders = {
    //   // 'Content-type': 'application/json',
    //   // 'Accept': 'application/json',
    //   'Cookie':
    //       'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
    // };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strPhpSessionID = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
    String? strCurrency = prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
    String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
    String? strLanguage = prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

    Map<String, String> requestHeaders = {
      'Cookie':
      'PHPSESSID='+strPhpSessionID!+'; currency='+strCurrency!+'; default='+strDefault!+'; language='+strLanguage!
    };


//    final response = await http.get(Uri.parse(strBaseUrl));
    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response status LogoutModel we got is " +
        response.statusCode.toString());
    print(
        "jigar the response LogoutModel we got is " + response.body.toString());
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? langCode = preferences.getString(Constants.UserDetailsTag.LANG_CODE);
    await preferences.clear();
    await preferences.setBool(Constants.UserDetailsTag.ISFIRSTTIME,false);
    await preferences.setString(Constants.UserDetailsTag.LANG_CODE, langCode!);
    Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => new splashscreen()));

    return LogoutModel.fromJson(jsonResponse);
  }
}