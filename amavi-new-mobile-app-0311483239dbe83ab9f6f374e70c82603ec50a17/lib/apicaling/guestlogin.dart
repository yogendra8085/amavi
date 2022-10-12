import 'package:amavinewapp/apicaling/homedataapi.dart';
import 'package:amavinewapp/apicaling/tokenauthentication.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/LoginModel.dart';
import '../Model/TokenModel.dart';
import '../Pages/homepage.dart';


class guestlogin{
  BuildContext ?buildContext;
   String ?langcode;
   String? strToken;
  SharedPreferences? prefs;
   guestlogin(this.buildContext,this.langcode,this.strToken,this.prefs);
  void GuestLogin() async {
    await token().setGetCurrencyUpdate(buildContext!,langcode!);
    TokenModel _tokenMyResponse = await token().tokenAuthentication(buildContext!);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

    strToken = _tokenMyResponse.token ?? "";
    print("jigar the response new token generated  is  " + (strToken ?? ""));

    prefs?.setString(Constants.TokenDetailsTag.TAG_TOKEN, strToken ?? "");

    // final String strUserEmail = userNameController.text;
    // final String strUserPassword = passwordController.text;

    await token().setGetCurrencyUpdate(buildContext!,langcode!);
   var _loginMyResponse = await homedata(strToken,buildContext).GetHomeData();

    // var jsonResponse =
    // convert.jsonDecode(_loginMyResponse.toString()) as Map<String, dynamic>;

    print("jigar the response l_loginMyResponse with new token is  " +
        _loginMyResponse.toString());
    LoginModel loginModel = LoginModel.fromJson(_loginMyResponse);

    prefs?.setString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN, "true");

    Navigator.of(buildContext!, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
            builder: (context) => new homepage(loginModel,true)));

    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => HomeBottomScreen(loginModel, true)));
    // print("jigar the response loginModel.code.toString() with new token is  " +
    //     loginModel.code.toString());
  }


}