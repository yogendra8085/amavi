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

class homedata{
  String ?strToken;
  BuildContext ?buildContext;
  homedata(this.strToken,this.buildContext);
  Future<dynamic> GetHomeData() async {
    ProgressDialog pr = new ProgressDialog(buildContext);

    pr.show();
    print("jigar the response login url status we got is " +
        Constants.HOME_PAGE_DATA_URL +
        strToken!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strPhpSessionID =
    prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
    String? strCurrency =
    prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
    String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
    String? strLanguage =
    prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

    Map<String, String> requestHeaders = {
      'Cookie': 'PHPSESSID=' +
          strPhpSessionID! +
          '; currency=' +
          strCurrency! +
          '; default=' +
          strDefault! +
          '; language=' +
          strLanguage! +
          ''
    };

    final String strBaseUrl = Constants.HOME_PAGE_DATA_URL + strToken!;

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;

    // LoginModel loginModel = LoginModel.fromJson(jsonResponse);
    // Navigator.push(
    pr.hide();

    return jsonResponse;
  }
}