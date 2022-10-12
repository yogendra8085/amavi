import 'dart:developer';

import 'package:amavinewapp/Model/CurrencySettingModel.dart';
import 'package:amavinewapp/Pages/homepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/LoginModel.dart';
import '../Pages/langugepage.dart';
import '../Pages/placeholder_setiing_screen.dart';

class ragisterapi{
  String? strtoke;
 String ?strCountryID;
 String ?strZoneID;
 String ?strAgree;
 String ?strNewsLetter;
 BuildContext ?context;
 ragisterapi(this.strtoke,this.strAgree,this.strCountryID,this.strZoneID,this.strNewsLetter,this.context);



  Future<dynamic> SignUpUser(
      String strEmail,
      String strFirstName,
      String strLastName,
      String strPhoneNumber,
      String strAddress,
      String strCity) async {
    var jsonResponse;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? strPhpSessionID =
      prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
      String? strCurrency =
      prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
      String? strDefault =
      prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
      String? strLanguage =
      prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

      // Map<String, String> requestHeaders = {
      //   'Cookie': 'PHPSESSID=' +
      //       strPhpSessionID +
      //       '; currency=' +
      //       strCurrency +
      //       '; default=' +
      //       strDefault +
      //       '; language=' +
      //       strLanguage +
      //       ''
      // };

      String strBaseUrl = Constants.SOCIAL_REGISTER + strtoke!;
      var map = new Map<String, String>();
      map['email'] = strEmail;
      map['firstname'] = strFirstName;
      map['lastname'] = strLastName;
      map['telephone'] = strPhoneNumber;
      map['address_1'] = strAddress;
      map['city'] = "null";
      map['country_id'] = strCountryID.toString();
      map['zone_id'] = strZoneID.toString();
      // map['password'] = strPassword;
      // map['confirm'] = strConfirmPassword;
      map['agree'] = strAgree!;
      map['newsletter'] = strNewsLetter!;

      log("jigar the register parameter is ${convert.jsonEncode(map)}   $strBaseUrl");

      var response = await Dio().post(
        strBaseUrl,
        data: map,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("jigar the response registration status we got is " +
          response.statusCode.toString());
      log("jigar the response registration we got is " + response.toString());
      jsonResponse = convert.jsonDecode(response.toString());
      if (response.statusCode.toString() == "302") {
        if (jsonResponse["status"] == "logged_in") {
          loginUserWithLogout(strEmail);
        }
      } else {
        if (jsonResponse["status"] == "logged_in") {
          loginUserWithLogout(strEmail);
        }
      }


    } catch (e) {
      // print("jigar the response before login authentication status we got is " +
      //     Response.statusCode.toString());
    }
    return jsonResponse;
  }
  loginUserWithLogout(String emailId) async {
    // LogoutModel user1 = await logoutUser(context);
  //  ProgressDialog pr = ProgressDialog(context);
    try {
      //pr.show();
      SharedPreferences sharedPreferenceManager =
      await SharedPreferences.getInstance();
      sharedPreferenceManager.setString(
          Constants.UserDetailsTag.TAG_STORED_USER_NAME,
          emailId.toString());
      sharedPreferenceManager.setString(
          Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN, "false");

      final String strBaseUrl = Constants.HOME_PAGE_DATA_URL + strtoke!;
      final homeDataRequest = await http.get(Uri.parse(strBaseUrl));
      var homeResponseData = convert.jsonDecode(homeDataRequest.body);
      LoginModel loginModel = LoginModel.fromJson(homeResponseData);

     // pr.hide();
      Navigator.pushAndRemoveUntil(
          context!,
          MaterialPageRoute(
              builder: (context) => LanguagePage1(loginModel,false)),
              (_) => false);
    } catch (e) {

    }
  }
}