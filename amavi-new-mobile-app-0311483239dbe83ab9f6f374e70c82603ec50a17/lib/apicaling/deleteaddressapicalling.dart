import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';
import '../constantpages/colors.dart';

class deleteaddres{
  deletaddress(String strAddressID,strToken) async {
    //ProgressDialog de = new ProgressDialog(context);
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
  //  de.show();
    print(strAddressID);
    print(strToken!);
    try {
      String strBaseUrl =
          "https://amavi.com.kw/index.php?route=endpoint/account/address/delete&address_id=${strAddressID}&secure_token=${strToken}";
      var map = new Map<String, String>();
      map['route'] = "endpoint/account/address/delete";
      map['secure_token'] = strToken!;
      map['address_id'] = strAddressID;
      // var url = Uri.https(strBaseUrl,'');
      // var response = await http.delete(url, body: map,headers: requestHeaders);
      // print(response.statusCode);
      var response = await Dio().delete(
        strBaseUrl,
        data: map,
        options: Options(
            followRedirects: false,
            headers: requestHeaders,
            validateStatus: (status) {
              return status !< 500;
            }),
      );
      if (response.statusCode.toString() == "302") {
        Fluttertoast.showToast(
            msg: "Address Deleted Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.appSecondaryColor,
            textColor: Colors.black,
            fontSize: 16.0);
        //de.hide();
       // initController();
      } else {
        Fluttertoast.showToast(
            msg: "Address Not Deleted!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.appSecondaryColor,
            textColor: Colors.black,
            fontSize: 16.0);
       // initController();
       // de.hide();
      }

      //de.hide();
      print(response.statusCode);
    } catch (e) {
     // de.hide();
      Fluttertoast.showToast(
          msg: "Address Not Deleted!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.appSecondaryColor,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}