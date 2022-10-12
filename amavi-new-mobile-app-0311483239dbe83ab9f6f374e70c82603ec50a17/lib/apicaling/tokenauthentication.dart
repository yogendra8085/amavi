import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/TokenModel.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
  class token{
  Future<TokenModel> tokenAuthentication(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context);

    pr.show();
    final String strBaseUrl = Constants.TokenDetailsTag.TOKEN_LOGIN;

    var map = new Map<String, dynamic>();
    map[Constants.TokenDetailsTag.TAG_USER_NAME] =
        Constants.TokenDetailsTag.TAG_VALUE_USER_NAME;
    map[Constants.TokenDetailsTag.TAG_PASSWORD] =
        Constants.TokenDetailsTag.TAG_VALUE_PASSWORD;

    final response = await http.post(Uri.parse(strBaseUrl), body: map);
    pr.hide();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strCookie = response.headers['set-cookie'];
    String strPhpid = strCookie!
        .substring(strCookie.indexOf("PHPSESSID") + 10, strCookie.indexOf(";"));
    strCookie = strCookie.substring(strCookie.indexOf(";"));
    String strCurrency = strCookie.substring(strCookie.indexOf("currency") + 9,
        strCookie.indexOf(";", strCookie.indexOf("currency") + 9));
    String strDefault = strCookie.substring(strCookie.indexOf("default") + 8,
        strCookie.indexOf(";", strCookie.indexOf("default") + 8));
    String strLanguage = strCookie.substring(strCookie.indexOf("language") + 9,
        strCookie.indexOf(";", strCookie.indexOf("language") + 9));
    prefs.setString(Constants.TokenDetailsTag.TAG_PHPSESSID, strPhpid);
    prefs.setString(Constants.TokenDetailsTag.TAG_CURRENCY, strCurrency);
    prefs.setString(Constants.TokenDetailsTag.TAG_DEFAULT, strDefault);
    prefs.setString(Constants.TokenDetailsTag.TAG_LANGUAGE, strLanguage);
    String? strHeader =
    prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);

//    final String responseString = response.body;

    print("jigar the response  we got is " + response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    return TokenModel.fromJson(jsonResponse);
  }
  Future<dynamic> setGetCurrencyUpdate(BuildContext context,String langcode) async {
    ProgressDialog pr = new ProgressDialog(context);

    pr.show();
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

    String strCurrencyCode = "KWD";
    String strCustomerLanguage = langcode;
    String strBaseUrl;
    strBaseUrl = Constants.SET_CURRENCY_DEFAULT_URL +
        "&currency_code=" +
        strCurrencyCode +
        "&customer_language=" +
        strCustomerLanguage;

    print("jigar the response setGetCurrencyUpdate url is we got is " +
        strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response setGetCurrencyUpdate status we got is " +
        response.statusCode.toString());
    print("jigar the response setGetCurrencyUpdate we got is " +
        response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(
        "jigar the response setGetCurrencyUpdate we got is " + user.toString());

    pr.hide();

    return user;
    // else {
    //   print("jigar the else part with no language info");
    //   pr.hide();
    //
    //   return "";
    // }
  }
}