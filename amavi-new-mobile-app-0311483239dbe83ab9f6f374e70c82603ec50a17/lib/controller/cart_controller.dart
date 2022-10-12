import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';

import '../Model/CartListModel.dart';

class CartController extends GetxController {
  Rx<CartListModel> cartListModel = CartListModel().obs;

  Future<void> getCartListDetails() async {
    try{
      String strAccessToken;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      strAccessToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN)!;

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

      String strBaseUrl;

      strBaseUrl =
          Constants.GET_CART_LIST_URL + "&secure_token=" + strAccessToken;

      final response =
      await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

      var user = convert.jsonDecode(response.body) as Map<String, dynamic>;

      cartListModel.value = CartListModel.fromJson(user);
      cartListModel.refresh();

    }catch(e){
      cartListModel.value = CartListModel();
      cartListModel.refresh();
    }
    Constants.strCartCount = cartListModel.value.textCount!;
    cartListModel.refresh();
  }
}
