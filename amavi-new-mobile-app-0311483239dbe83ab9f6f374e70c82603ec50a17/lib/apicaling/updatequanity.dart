import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../controller/cart_controller.dart';


class updatequanity{
  String? strToken;
  updatequanity(this.strToken);
  final CartController _cartController = Get.put( CartController());
  Future<dynamic> updateQuantity(
      BuildContext context, String strProductID, int strQuantity) async {
    ProgressDialog pr = new ProgressDialog(context);
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
    //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

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

    String strBaseUrl;
    //if(intPageNumber==1) {
    strBaseUrl = Constants.UPDATE_QUANTITY_URL + "&secure_token=" + strToken!;
    print("jigar the response url is we got is " + strBaseUrl);
    var map = new Map<String, dynamic>();
    map['key'] = strProductID;
    map['quantity'] = strQuantity.toString();

    print("jigar the parameter map is " + map.toString());

    print("jigar the parameter strProductID is " + strProductID.toString());
    print("jigar the parameter Quantity is " + strQuantity.toString());

    final response = await http.post(Uri.parse(strBaseUrl),
        body: map, headers: requestHeaders);

    print("jigar the response account status we got is " +
        response.statusCode.toString());

    if (response.statusCode.toString() == "302") {
      // cartListModel = null;
      //
      // getCartListDetails(context);
    }
//     print("jigar the response account we got is " + response.body.toString());
//     var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
//     print("jigar the response user.toString() we got is " + user.toString());
//
//     if (user['products'] != null) {
//       // var jsonResponse =
//       //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;
//
//       //if (pageNumber == 1)
//       {
//         cartListModel = CartListModel.fromJson(user);
//       }
//       //else {
// //          cartListModel.rewards.addAll(cartListModel.fromJson(user));
// //          user['orders'].forEach((v) { cartListModel..add(new Orders.fromJson(v)); });
//       //}
//
//       print("jigar the response cartListModel.producrs length is " +
//           cartListModel.products.length.toString());

    // strFirstName = accountDetailsModel.firstname.sentenceCase;
    // strLastName = accountDetailsModel.lastname.sentenceCase;
    // strEmailID = accountDetailsModel.email;
    // strPhoneNumber = accountDetailsModel.telephone;
    //
    // if (accountDetailsModel.addresses.length > 0) {
    //   strAddress = accountDetailsModel.addresses[0].address;
    // }
    // setState(() {});
    pr.hide();
    _cartController.getCartListDetails();

    return "";
  }

//   Future<dynamic> updateVoucherQuantity(
//       BuildContext context, String strProductID, int strQuantity) async {
//     ProgressDialog pr = new ProgressDialog(context);
//     // pr.style(
//     //     message: 'Please Waiting...',
//     //     borderRadius: 10.0,
//     //     backgroundColor: Colors.white,
//     //     progressWidget: CircularProgressIndicator(),
//     //     elevation: 10.0,
//     //     insetAnimCurve: Curves.easeInOut,
//     //     progress: 0.0,
//     //     maxProgress: 100.0,
//     //     progressTextStyle: TextStyle(
//     //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//     //     messageTextStyle: TextStyle(
//     //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
//
//     pr.show();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String strPhpSessionID =
//     prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
//     String strCurrency =
//     prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
//     String strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
//     String strLanguage =
//     prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);
//
//     Map<String, String> requestHeaders = {
//       'Cookie': 'PHPSESSID=' +
//           strPhpSessionID +
//           '; currency=' +
//           strCurrency +
//           '; default=' +
//           strDefault +
//           '; language=' +
//           strLanguage +
//           ''
//     };
//
//     String strBaseUrl;
//     //if(intPageNumber==1) {
//     strBaseUrl =
//         Constants.UPDATE_VOUCHER_QUANTITY_URL + "&secure_token=" + strToken;
//     print("jigar the response url is we got is " + strBaseUrl);
//     var map = new Map<String, dynamic>();
//     map['key'] = strProductID;
//     map['quantity'] = strQuantity.toString();
//
//     print("jigar the parameter map is " + map.toString());
//
//     print("jigar the parameter strProductID is " + strProductID.toString());
//     print("jigar the parameter Quantity is " + strQuantity.toString());
//
//     final response = await http.post(Uri.parse(strBaseUrl),
//         body: map, headers: requestHeaders);
//
//     print("jigar the response account status we got is " +
//         response.statusCode.toString());
//
//     if (response.statusCode.toString() == "302") {
//       cartListModel = null;
//
//       getCartListDetails(context);
//     }
// //     print("jigar the response account we got is " + response.body.toString());
// //     var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
// //     print("jigar the response user.toString() we got is " + user.toString());
// //
// //     if (user['products'] != null) {
// //       // var jsonResponse =
// //       //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;
// //
// //       //if (pageNumber == 1)
// //       {
// //         cartListModel = CartListModel.fromJson(user);
// //       }
// //       //else {
// // //          cartListModel.rewards.addAll(cartListModel.fromJson(user));
// // //          user['orders'].forEach((v) { cartListModel..add(new Orders.fromJson(v)); });
// //       //}
// //
// //       print("jigar the response cartListModel.producrs length is " +
// //           cartListModel.products.length.toString());
//
//     // strFirstName = accountDetailsModel.firstname.sentenceCase;
//     // strLastName = accountDetailsModel.lastname.sentenceCase;
//     // strEmailID = accountDetailsModel.email;
//     // strPhoneNumber = accountDetailsModel.telephone;
//     //
//     // if (accountDetailsModel.addresses.length > 0) {
//     //   strAddress = accountDetailsModel.addresses[0].address;
//     // }
//     setState(() {});
//     pr.hide();
//     _cartController.getCartListDetails();
//
//     return "";
//   }

}