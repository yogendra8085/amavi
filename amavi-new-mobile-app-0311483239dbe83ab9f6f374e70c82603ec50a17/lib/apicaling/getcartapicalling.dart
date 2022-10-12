import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/CartListModel.dart';
import '../Model/TokenModel.dart';
class getcartapi{

  Future<dynamic> getCartListDetails() async {
    String? strAccessToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strAccessToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);

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

    // Map<String, String> requestHeaders = {
    //   'Cookie':
    //       'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
    // };

    String strBaseUrl;

    strBaseUrl =
        Constants.GET_CART_LIST_URL + "&secure_token=" + strAccessToken!;

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;

    // cartListModel = CartListModel.fromJson(user);
    // setState(() {
    //   Constants.strCartCount = (cartListModel?.textCount)!.toInt();
    // });
    return user;

  }
}