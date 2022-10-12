import 'dart:io';

import 'package:amavinewapp/Pages/loginpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/LoginModel.dart';
import '../Model/LogoutModel.dart';
import '../Model/TokenModel.dart';
import '../Pages/category_list_screen.dart';
import '../Pages/placeholder_about_us.dart';
import '../Pages/placeholder_contact_us.dart';
import '../Pages/placeholder_privacy_policy.dart';
import '../Pages/placeholder_setiing_screen.dart';
import '../Pages/placeholder_terms_conditions.dart';
import '../apicaling/logoutapicallin.dart';
import '../constantpages/colors.dart';
class MyDrawer extends StatefulWidget {
  LoginModel ?placeHolderloginModel;
  Function ?refresh;

  MyDrawer({this.placeHolderloginModel, this.refresh});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String ?strIsGuestLogin = "true";
  String ?strAccessToken;
  String ?_languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strAccessToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strIsGuestLogin =
        prefs.getString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN)!;
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE)!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: Container(
        color: AppColors.appSecondaryOrangeColor,
        child: FutureBuilder(
            //  future: GetHomeData(context),
            builder: (context, snapshot) {
          return ListView(
            // Important: Remove any padding from the ListView.
//          padding: EdgeInsets.zero,

            padding: EdgeInsets.only(top: 40),
            children: <Widget>[
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 20.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel != null
                      ? (widget.placeHolderloginModel?.categories?.length)!>0
                          ? (widget.placeHolderloginModel?.categories?[0].name).toString()
                          : ""
                      : "" ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  //   String strURl=HomeDataModel.categories[0].href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) => CategoryListPage((widget.placeHolderloginModel?.categories?[0].categoryId).toString(),(widget.placeHolderloginModel?.categories?[0].name).toString(),0)),

                  );
                  print("Click event on Container");
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
              (widget.placeHolderloginModel?.categories?.length)! > 1
                      ?( widget.placeHolderloginModel?.categories?[1].name).toString()
                      : "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
//                  String strURl=HomeDataModel.categories[1].href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryListPage(
                            widget
                                .placeHolderloginModel?.categories?[1].categoryId,
                            widget.placeHolderloginModel?.categories?[1].name,
                            1)),
                  );
                  print("Click event on Container");

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
              (widget.placeHolderloginModel?.categories?.length)! > 1
                      ? (widget.placeHolderloginModel?.categories?[2].name).toString()
                      : "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 14,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
//                  String strURl=HomeDataModel.categories[2].href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryListPage(
                            widget
                                .placeHolderloginModel?.categories?[2].categoryId,
                            widget.placeHolderloginModel?.categories?[2].name,
                            2)),
                  );
                  print("Click event on Container");

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
              (widget.placeHolderloginModel?.categories?.length)! > 1
                      ? (widget.placeHolderloginModel?.categories?[3].name).toString()
                      : "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
//                  String strURl=HomeDataModel.categories[3].href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');

                  Navigator.push(
                    context,
//                    MaterialPageRoute(builder: (context) => CategoryListPage(strURl,HomeDataModel.categories[3].name,3)),
                    MaterialPageRoute(
                        builder: (context) => CategoryListPage(
                            widget
                                .placeHolderloginModel?.categories?[3].categoryId,
                            widget.placeHolderloginModel?.categories?[3].name,
                            3)),
                  );
                  print("Click event on Container");
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
              (widget.placeHolderloginModel?.categories?.length)! > 1
                      ? (widget.placeHolderloginModel?.categories?[4].name).toString()
                      : "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
//                  String strURl=HomeDataModel.categories[4].href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');

                  Navigator.push(
                    context,
//                    MaterialPageRoute(builder: (context) => CategoryListPage(strURl,widget.placeHolderloginModel.categories[4].name,4)),
                    MaterialPageRoute(
                        builder: (context) => CategoryListPage(
                            widget
                                .placeHolderloginModel?.categories?[4].categoryId,
                            widget.placeHolderloginModel?.categories?[4].name,
                            4)),
                  );
                  print("Click event on Container");

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
              (widget.placeHolderloginModel?.categories?.length)! > 1
                      ? (widget.placeHolderloginModel?.categories?[5].name).toString()
                      : "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
//                  String strURl=HomeDataModel.categories[5].href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');

                  Navigator.push(
                    context,
//                    MaterialPageRoute(builder: (context) => CategoryListPage(strURl,widget.placeHolderloginModel.categories[5].name,5)),
                    MaterialPageRoute(
                        builder: (context) => CategoryListPage(
                            widget
                                .placeHolderloginModel?.categories?[5].categoryId,
                            widget.placeHolderloginModel?.categories?[5].name,
                            5)),
                  );
                  print("Click event on Container");

                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.informations != null
                      ? (widget.placeHolderloginModel?.informations?[0].title).toString()
                      : 'About Us',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceholderAboutUS(
                              widget.placeHolderloginModel?.informations != null
                                  ?( widget.placeHolderloginModel?.informations?[0]
                                      .title).toString()
                                  : 'About Us')));
                 // Update the state of the app.
                //  ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.informations != null
                      ? (widget.placeHolderloginModel?.informations?[3].title).toString()
                      : 'Privacy Policy',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceholderPrivacyPolicy(
                              widget.placeHolderloginModel?.informations != null
                                  ? (widget.placeHolderloginModel?.informations?[3]
                                      .title).toString()
                                  : 'Privacy Policy')));
                  // Update the state of the app.
                  // ...
                },
              ),
              // ListTile(
              //   dense: true,
              //   contentPadding: EdgeInsets.only(
              //       left: 30, right: 30.0, top: 0.0, bottom: 0.0),
              //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              //   title: Text(
              //     'Notifications',
              //     style: const TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: AppColors.white,
              //         fontSize: 16.0,
              //         fontFamily: "Bordeaux"),
              //   ),
              //   onTap: () {
              //     // Update the state of the app.
              //     // ...
              //   },
              // ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.informations != null
                      ? (widget.placeHolderloginModel?.informations?[2].title).toString()
                          .replaceAll("&amp;", "&").replaceAll("&quot;", '"')
                      : 'Terms and Conditions',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceholderTermsCondition(
                              widget.placeHolderloginModel?.informations != null
                                  ? (widget.placeHolderloginModel?.informations?[2]
                                      .title).toString()
                                      .replaceAll("&amp;", "&").replaceAll("&quot;", '"')
                                  : 'Terms and Conditions')));

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.textContact != ""
                      ? (widget.placeHolderloginModel?.textContact).toString()
                      : 'Contact Us',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlaceholderContactUs(
                              widget.placeHolderloginModel?.textContact != ""
                                  ? (widget.placeHolderloginModel?.textContact).toString()
                                  : 'Contact Us')));

                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.textFaq != ""
                      ? (widget.placeHolderloginModel?.textFaq).toString()
                      : "FAQ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PlaceholderFAQ()));
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 8.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.textReward != ""
                      ?(widget.placeHolderloginModel?.textReward).toString()
                      : 'Rewards Points',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);

                  if (strIsGuestLogin == "true") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => loginpage()));
                  } else {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => RewardHistoryListPage()));
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => RewardHistoryListPage()));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.textVoucher != ""
                      ? (widget.placeHolderloginModel?.textVoucher).toString()
                      : 'Gift Voucher',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);

                  if (strIsGuestLogin == "true") {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             AddNewVoucherScreenPage(strIsGuestLogin)));
                  } else {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CheckVoucherPage(null)));
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => VoucherHistoryListPage()));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.textSettings != ""
                      ? (widget.placeHolderloginModel?.textSettings).toString()
                      : 'Settings',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingPage(
                              (widget.refresh) as Function,
                              widget.placeHolderloginModel?.textSettings != ""
                                  ? (widget.placeHolderloginModel?.textSettings).toString()
                                  : 'Settings')));
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    left: 30, right: 30.0, top: 0.0, bottom: 0.0),
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  widget.placeHolderloginModel?.textLogout != ""
                      ?( widget.placeHolderloginModel?.textLogout).toString()
                      : 'Sign Out',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontFamily: "Bordeaux"),
                ),
                onTap: () {
                  logoutapiloging(). logoutUser(context);
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          );
        }),
      ),
    );
  }
  // Future<void> getFirebaseToken(
  //     BuildContext context, String token,  String type) async {
  //   String strBaseUrl = Constants.FCM_TOKEN + (token ?? "");
  //   String? fcmToken = await FirebaseMessaging.instance.getToken();
  //   var map = new Map<String, dynamic>();
  //   map["notification_token"] = fcmToken;
  //   map["type"] = type;
  //   map["platform"] = Platform.isAndroid ? "android" : "ios";
  //   var deviceId = await PlatformDeviceId.getDeviceId;
  //   map["device_id"] =deviceId ;
  //   try {
  //     final response = await http.post(Uri.parse(strBaseUrl), body: map);
  //
  //     print("jigar the response status we got is " +
  //         response.statusCode.toString());
  //     print("jigar the response we got is " + response.body.toString());
  //   } catch (e) {
  //     print(e);
  //   }
  // }
//   Future<LogoutModel> logoutUser(BuildContext context) async {
//     final String strBaseUrl = Constants.LOGOUT_URL;
//
//     // Map<String, String> requestHeaders = {
//     //   // 'Content-type': 'application/json',
//     //   // 'Accept': 'application/json',
//     //   'Cookie':
//     //       'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
//     // };
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String strPhpSessionID = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
//     String strCurrency = prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
//     String strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
//     String strLanguage = prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);
//    var strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
//
//     Map<String, String> requestHeaders = {
//       'Cookie':
//       'PHPSESSID='+strPhpSessionID+'; currency='+strCurrency+'; default='+strDefault+'; language='+strLanguage+''
//     };
//
//
// //    final response = await http.get(Uri.parse(strBaseUrl));
//     final response =
//         await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);
//
//     print("jigar the response status LogoutModel we got is " +
//         response.statusCode.toString());
//     print(
//         "jigar the response LogoutModel we got is " + response.body.toString());
//     var jsonResponse =
//         convert.jsonDecode(response.body) as Map<String, dynamic>;
//
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String langCode = preferences.getString(Constants.UserDetailsTag.LANG_CODE);
//     await preferences.clear();
//     await preferences.setBool(Constants.UserDetailsTag.ISFIRSTTIME, false);
//     await preferences.setString(Constants.UserDetailsTag.LANG_CODE, langCode);
//     await getFirebaseToken(context, strToken,  "logout");
//
//     // Navigator.pushReplacement(
//     //     context, MaterialPageRoute(builder: (context) => SplashScreenPage()));
//     Navigator.of(context, rootNavigator: true).pushReplacement(
//         MaterialPageRoute(builder: (context) => new SplashScreenPage()));
//     return LogoutModel.fromJson(jsonResponse);
//   }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initController();
  }
}
