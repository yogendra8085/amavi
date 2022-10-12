import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/AddToCartModel.dart';
import '../Model/TokenModel.dart';
import '../constantpages/colors.dart';
import '../controller/cart_controller.dart';

class wishlist {

String? strtoken;
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

wishlist(this.strtoken);
  Future<dynamic> removeProduct(BuildContext context,
      String strProductID) async {
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
    //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    pr.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strPhpSessionID = prefs.getString(
        Constants.TokenDetailsTag.TAG_PHPSESSID);
    String? strCurrency = prefs.getString(
        Constants.TokenDetailsTag.TAG_CURRENCY);
    String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
    String? strLanguage = prefs.getString(
        Constants.TokenDetailsTag.TAG_LANGUAGE);

    Map<String, String> requestHeaders = {
      'Cookie':
      'PHPSESSID=' + strPhpSessionID! + '; currency=' + strCurrency! +
          '; default=' + strDefault! + '; language=' + strLanguage! + ''
    };

    String strBaseUrl;
    //if(intPageNumber==1) {
    strBaseUrl = Constants.REMOVE_WISHLIST_PRODUCT_URL +
        strProductID +
        "&secure_token=" +
        strtoken!;
    print("jigar the response url is we got is " + strBaseUrl);
    var map = new Map<String, dynamic>();
    map['key'] = strProductID;
    // map['quantity'] = strQuantity.toString();

    print("jigar the parameter map is " + map.toString());

    print("jigar the parameter strProductID is " + strProductID.toString());

    final response = await http.get(Uri.parse(strBaseUrl),
        //body: map,
        headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response account status we got is " +
        response.statusCode.toString());

    if (response.statusCode.toString() == "200") {
      //wishListModel = null;

      getWishListDetails(context);
      showSuccessMsg("Remove Product On Wishlist Sucessfuy!");
    }
    else{
      showFailMsg("Not Remove Product On Wishlist!");
    }
  }
Future<dynamic> addToCart(BuildContext context, String strProductID,
    String strQuantity) async {
  ProgressDialog pr = new ProgressDialog(context);
  final CartController _cartController = Get.put( CartController());
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
  //         color: Colors.black,
  //         fontSize: SizeConfig.blockSizeVertical * 1.6,
  //         fontWeight: FontWeight.bold),
  //     messageTextStyle: TextStyle(
  //         color: Colors.black,
  //         fontSize: SizeConfig.blockSizeVertical * 1.8,
  //         fontWeight: FontWeight.w600));

  pr.show();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? strPhpSessionID = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
  String? strCurrency = prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
  String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
  String? strLanguage = prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

  Map<String, String> requestHeaders = {
    'Cookie':
    'PHPSESSID='+strPhpSessionID!+'; currency='+strCurrency!+'; default='+strDefault!+'; language='+strLanguage!+''
  };

  String strBaseUrl;

  strBaseUrl = Constants.ADD_TO_CART_PRODUCT + strtoken!;
  print("jigar the product cart url is we got is " + strBaseUrl);

  var map = new Map<String, dynamic>();
  map['product_id'] = strProductID;
  map['quantity'] = strQuantity;

  try {
    print("jigar the response add to cart map " + map.toString());
    final response = await http.post(Uri.parse(strBaseUrl),
        body: map, headers: requestHeaders);

    print("jigar the response add to cart status we got is " +
        response.toString());
    final String responseString = response.body;

    print("jigar the response add to cart status we got is " +
        response.statusCode.toString());
    print("jigar the response account we got is " + response.body.toString());

    if (responseString != "[]") {
      var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(
          "jigar the response user.toString() we got is " + user.toString());

      if (user['total'] != null) {
        // addToCartModel = AddToCartModel.fromJson(user);

        // print("jigar the response user.toString() we got is " +
        //     addToCartModel.success);

        //setState(()
            {
          if (user['success'] != "") {
           Vibrate.vibrate();
            showSuccessMsg(
               "Product Added to Cart Successfully",
            );
          }
          removeProduct(context, strProductID);
          _cartController.getCartListDetails();
        }
        //);
        pr.hide();

        return user;
      } else {
        print("jigar the else part with no products info");
        pr.hide();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProductDetailPage(
        //             strProductID, false, refresh)));
        return "";
      }
    } else {
      showFailMsg(
         "Something went wrong try again later",
      );
    }
    pr.hide();
    return "";
  } catch (e, stacktrace) {
    print('jigar the Exception: ' + e.toString());
    print('jigar the Stacktrace: ' + stacktrace.toString());
  }
  return "";
}
  Future<Map<String,dynamic>> addToWishList(
      BuildContext context, String strProductID,String strToken) async {
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
    Map<String,dynamic> user1;

    String strBaseUrl;

    strBaseUrl = Constants.ADD_TO_WISHLIST_PRODUCT + strToken;
    print("jigar the product cart url is we got is " + strBaseUrl);

    var map = new Map<String, dynamic>();

    map['product_id'] = strProductID;

    try {
      print("jigar the response add to cart map " + map.toString());
      final response = await http.post(Uri.parse(strBaseUrl),
          body: map, headers: requestHeaders);

      print("jigar the response add to cart status we got is " +
          response.toString());
      final String responseString = response.body;

      print("jigar the response add to cart status we got is " +
          response.statusCode.toString());
      print("jigar the response account we got is " + response.body.toString());

      if (responseString != "[]") {
        var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(
            "jigar the response user.toString() we got is " + user.toString());

        if (user['total'] != null) {
          // addToWishListModel = AddToWishListModel.fromJson(user);
          //
          // print("jigar the response user.toString() we got is " +
          //     addToWishListModel.success.toString());

          //setState(()
          {
            if (user['success'] != "") {
              Vibrate.vibrate();
              showSuccessMsg(
                "Product Added to WishList Successfully",
              );
            }
          }
          //);
          pr.hide();

          return user;
        } else {
          print("jigar the else part with no products info");
          pr.hide();

          return user;
        }
      } else {
        showFailMsg(
           "Something went wrong try again later",
        );
      }
      pr.hide();

    } catch (e, stacktrace) {
      print('jigar the Exception: ' + e.toString());
      print('jigar the Stacktrace: ' + stacktrace.toString());
    }
    return {};
  }
Future<dynamic> updateQuantity(BuildContext context, String strProductID,
    int strQuantity) async {
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
  //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
  //     messageTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

  pr.show();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? strPhpSessionID = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
  String? strCurrency = prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
  String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
  String? strLanguage = prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

  Map<String, String> requestHeaders = {
    'Cookie':
    'PHPSESSID='+strPhpSessionID!+'; currency='+strCurrency!+'; default='+strDefault!+'; language='+strLanguage!+''
  };


  String strBaseUrl;
  //if(intPageNumber==1) {
  strBaseUrl = Constants.UPDATE_QUANTITY_URL + "&secure_token=" + strtoken!;

  print("jigar the response url is we got is " + strBaseUrl);
  var map = new Map<String, dynamic>();
  map['key'] = strProductID;
  map['quantity'] = strQuantity.toString();

  print("jigar the parameter map is " + map.toString());

  print("jigar the parameter strProductID is " + strProductID.toString());
  print("jigar the parameter Quantity is " + strQuantity.toString());

  final response = await http.post(Uri.parse(strBaseUrl),
      body: map, headers: requestHeaders);

  final String responseString = response.body;

  print("jigar the response account status we got is " +
      response.statusCode.toString());

  if (response.statusCode.toString() == "302") {
   // wishListModel = null;

    getWishListDetails(context);
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
//         wishListModel = wishListModel.fromJson(user);
//       }
//       //else {
// //          wishListModel.rewards.addAll(wishListModel.fromJson(user));
// //          user['orders'].forEach((v) { wishListModel..add(new Orders.fromJson(v)); });
//       //}
//
//       print("jigar the response wishListModel.producrs length is " +
//           wishListModel.products.length.toString());

  // strFirstName = accountDetailsModel.firstname.sentenceCase;
  // strLastName = accountDetailsModel.lastname.sentenceCase;
  // strEmailID = accountDetailsModel.email;
  // strPhoneNumber = accountDetailsModel.telephone;
  //
  // if (accountDetailsModel.addresses.length > 0) {
  //   strAddress = accountDetailsModel.addresses[0].address;
  // }

  pr.hide();

  return "";
}
Future<dynamic> getWishListDetails(BuildContext context) async {
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
  //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
  //     messageTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

//  pr.show();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? strPhpSessionID = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
  String? strCurrency = prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
  String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
  String? strLanguage = prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

  Map<String, String> requestHeaders = {
    'Cookie':
    'PHPSESSID='+strPhpSessionID!+'; currency='+strCurrency!+'; default='+strDefault!+'; language='+strLanguage!+''
  };

  String strBaseUrl;
  //if(intPageNumber==1) {
  strBaseUrl = Constants.GET_WISHLIST_URL + strtoken!;

  print("jigar the response url is we got is " + strBaseUrl);
  pr.hide();
  final response =
  await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

  final String responseString = response.body;

  print("jigar the response account status we got is " +
      response.statusCode.toString());
  print("jigar the response account we got is " + response.body.toString());
  var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
  print("jigar the response user.toString() we got is " + user.toString());
  print("jigar the response user['products'] () we got is " +
      user['products'].toString());

  if (user['products'] != null) {
    // setState(() {
    //   wishListModel = WishListModel.fromJson(user);
    //   strHeading = wishListModel.headingTitle;
    //   print("jigar the response wishListModel.producrs length is " +
    //       wishListModel.products.length.toString());
    //
    //   if (wishListModel.products.length > 0) {
    //     intAddQuantity = List.filled(wishListModel.products.length, 0);
    //   } else {
    //     // setState(() {
    //     //   strHeading = wishListModel.headingTitle;
    //     //   strErrorMessage = user['text_empty'];
    //     // });
    //   }
     // pr.hide();

      return user;
   // });
  }
}

}