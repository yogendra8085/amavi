import 'dart:developer';

import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';

class adressapicalling{
  String ?strtoken;
  adressapicalling(this.strtoken);
  Future<dynamic> getAddressDetails(BuildContext context) async {
    // ProgressDialog pr = new ProgressDialog(context);
    // pr.style(
    //     message: 'Please Waiting...',
    //     borderRadius: 10.0,
    //     backgroundColor: Colors.white,
    //     progressWidget: CircularProgressIndicator(),
    //     elevation: 10.0,
    //     insetAnimCurve: Curves.easeInOut,
    //     progress: 0.0,
    //     maxProgress: 100.0,
    //     progressTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    //   pr.show();
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
      'PHPSESSID='+strPhpSessionID!+'; currency='+strCurrency!+'; default='+strDefault!+'; language='+strLanguage!+''
    };

    final String strBaseUrl =
        Constants.GET_ADDRESS_ACCOUNT_DETAILS_URL + strtoken!;
    print("jigar the response getAddressDetails url we got is " + strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response getAddressDetails status we got is " + response.statusCode.toString());
    log("jigar the response account we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response user.toString() we got is " + user.toString());

    if (user['firstname'] != null) {
      print(
          "jigar the if part user['firstname']" + user['firstname'].toString());

      // var jsonResponse =
      //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;

      // addressBookModel = AddressBookModel.fromJson(user);
      // strFirstName = addressBookModel.firstname.sentenceCase;
      // strLastName = addressBookModel.lastname.sentenceCase;
      // strEmailID = addressBookModel.email;
      // strPhoneNumber = addressBookModel.telephone;
      //
      // if (addressBookModel.addresses.length > 0) {
      //   strAddress = addressBookModel.addresses[0].address;
      // }
      //
      // accountListModel = AccountListModel.fromJson(user);
      //
      // setState(() {});
      // //pr.hide();

      return user;
    // } else {
    //   print("jigar the else part with no customer info");
    //   //  pr.hide();
    //
    //   return "";
    }
  }
}