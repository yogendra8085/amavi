import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constantpages/colors.dart';

class addnewaddres{
  showFailMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.appSecondaryColor,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  showSuccessMsg(String string) {
    Fluttertoast.showToast(
        msg: string,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.appSecondaryColor,
        textColor: Colors.black,
        fontSize: 16.0);
  }
  Future<dynamic> AddShippingUserAddress(
      String strEmail,
      String strFirstName,
      String strLastName,
      String strPhoneNumber,
      String strAddress,
      String strCity,BuildContext context,strTkon,String _myCountrySelection,String _myAreaSelection,String strCountryID,String strZoneID ) async {
    if (_myCountrySelection == null) {
      showFailMsg( "Please select country");
      return;
    }
    if (_myAreaSelection == null) {
      showFailMsg( "Please select Area");
      return;
    }

    var jsonResponse;
    ProgressDialog pr = new ProgressDialog(context);
    pr.show();
    // Map<String, String> requestHeaders = {
    //   // 'Content-type': 'application/json',
    //   // 'Accept': 'application/json',
    //   'Cookie':
    //       'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
    // };

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

    try {
      String strBaseUrl = Constants.PREFIX_LIVE_URL +
          "index.php?route=endpoint/account/address/add&secure_token=" +
          strTkon;

//      https://amavi.ribox.me/index.php?route=endpoint/account/address/add&secure_token={{api_token}}
      var map = new Map<String, String>();
      map['firstname'] = strFirstName;
      map['lastname'] = strLastName;
      map['email'] = strEmail;
      map['telephone'] = strPhoneNumber;
      map['address_1'] = strAddress;
      map['city'] = strAddress;
//      map['postcode'] = "";
      map['country_id'] = strCountryID.toString();
      map['zone_id'] = strZoneID.toString();
      map['shipping_address'] = "1";

      var response = await Dio().post(
        strBaseUrl,
        data: map,
        options: Options(
            followRedirects: false,
            headers: requestHeaders,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("Resposne code ===>  ${response.statusCode}");
      if (response.statusCode.toString() == "200") {
        showSuccessMsg( "Shipping Address Added Successfully");
      } else if (response.statusCode.toString() == "302") {
        Navigator.pop(context);
        showSuccessMsg(
          "Shipping Address Added Successfully",
        );
//        print(e.response.statusCode);
      }

      pr.hide();
    } catch (e) {
//       // if (e.response.statusCode.toString() == "302") {
//       //   showSuccessMsg(
//       //     msg: "Shipping Address Added Successfully",
//       //   );
// //        print(e.response.statusCode);
//       } else {
//         print(e.message);
//         print(e.request);
//       }
    }
    return jsonResponse;
  }


  Future<dynamic> getShippingAddress(BuildContext context,String strToken) async {
    ProgressDialog pr = new ProgressDialog(context);

    pr.show();
    // Map<String, String> requestHeaders = {
    //   // 'Content-type': 'application/json',
    //   // 'Accept': 'application/json',
    //   'Cookie':
    //       'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
    // };

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
    print("resqu  ==>  $requestHeaders");
    try {
      String strBaseUrl = Constants.PREFIX_LIVE_URL +
          "index.php?route=endpoint/account/address/add&secure_token=" +
          strToken!;
      final response =
      await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

      print("jigar the response addAddressModel status we got is " +
          response.statusCode.toString());

      String strRespnse = String.fromCharCodes(response.bodyBytes);
      var user = convert.jsonDecode(strRespnse);
      // addAddressModel = AddAddressModel.fromJson(user);
      //
      // print("jigar the response addAddressModel.headingTitle we got is " +
      //     (addAddressModel?.headingTitle).toString()
      // );
      // setState(() {
      //   pr.hide();
      // });
      pr.hide();
      return user;
    } catch (e) {
      // if (e.response.statusCode == 302) {
      //   Fluttertoast.showToast(
      //       msg: "Shipping Address Added Successfully",
      //       textColor: Colors.white,
      //       backgroundColor: Colors.black,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.SNACKBAR,
      //       timeInSecForIosWeb: 1);
      return "";
      print("jigar the error  response" + e.toString());
    }



  }


}