// TODO Implement this library.
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/contact_us_model.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';


class PlaceholderContactUs extends StatefulWidget {
  final String strHeading;

  PlaceholderContactUs(this.strHeading);

  @override
  _PlaceholderContactUsWidgetState createState() =>
      _PlaceholderContactUsWidgetState(strHeading);
}

class _PlaceholderContactUsWidgetState extends State<PlaceholderContactUs> {
  bool isLoading = true;
  String ?strAccessToken;
  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
  final TextEditingController userSubjectController = TextEditingController();
  final TextEditingController userAddressController = TextEditingController();
  final TextEditingController userEmailIDController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  ProgressDialog ?pr;
  String ?strToken;
  String ?strHeading = "";
  ContactUsModel? _contactUsModel = ContactUsModel();
  String? _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  _PlaceholderContactUsWidgetState(this.strHeading);

  @override
  void initState() {
    pr = new ProgressDialog(context);

    super.initState();

    initController();
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    getContactDetails();
    setState(() {});
  }
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Directionality(
      textDirection: _languageCode == Constants.UserDetailsTag.LANG_CODE_EN
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
        //homepage code
        appBar: AppBar(
          backgroundColor: AppColors.appSecondaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(strHeading!),
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: new TextFormField(
                      controller: userFirstNameController,
                      decoration: new InputDecoration(
                        focusColor: AppColors.appSecondaryColor,
                        labelText: _contactUsModel != null
                            ? _contactUsModel?.entryName ?? "Enter First Name"
                            : "Enter First Name",
                        errorStyle: TextStyle(fontSize: 15.0),
                        labelStyle: TextStyle(color: AppColors.black),
                        fillColor: Colors.grey,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val?.length == 0) {
                          return "First Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      style: new TextStyle(
                        color: AppColors.black,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: new TextFormField(
                      controller: userLastNameController,
                      decoration: new InputDecoration(
                        focusColor: AppColors.appSecondaryColor,
                        labelText: _contactUsModel != null
                            ? _contactUsModel?.entryLastname ?? "Enter Last Name"
                            : "Enter Last Name",
                        errorStyle: TextStyle(fontSize: 15.0),
                        labelStyle: TextStyle(color: AppColors.black),
                        fillColor: Colors.grey,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val?.length == 0) {
                          return "Last Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      style: new TextStyle(
                        color: AppColors.black,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: new TextFormField(
                      controller: userEmailIDController,
                      decoration: new InputDecoration(
                        focusColor: AppColors.black,
                        labelText: _contactUsModel != null
                            ? _contactUsModel?.entryEmail ?? "Enter Email ID"
                            : "Enter Email ID",
                        errorStyle: TextStyle(fontSize: 15.0),
                        labelStyle: TextStyle(color: AppColors.black),
                        fillColor: Colors.grey,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val?.length == 0) {
                          return "Email ID cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        color: AppColors.black,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: new TextFormField(
                      controller: userSubjectController,
                      decoration: new InputDecoration(
                        focusColor: AppColors.appSecondaryColor,
                        labelText: _contactUsModel != null
                            ? _contactUsModel?.entrySubject ?? "Enter Subject"
                            : "Enter Subject",
                        errorStyle: TextStyle(fontSize: 15.0),
                        labelStyle: TextStyle(color: AppColors.black),
                        fillColor: Colors.grey,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val?.length == 0) {
                          return "Subject cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      style: new TextStyle(
                        color: AppColors.black,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: new TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: userAddressController,
                      decoration: new InputDecoration(
                        alignLabelWithHint: true,
                        focusColor: AppColors.black,
                        labelText: _contactUsModel != null
                            ? _contactUsModel?.entryEnquiry ?? "Enter Enquiry"
                            : "Enter Enquiry",
                        errorStyle: TextStyle(fontSize: 15.0),
                        labelStyle: TextStyle(color: AppColors.black),
                        fillColor: Colors.grey,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val?.length == 0) {
                          return "Enquiry cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      style: new TextStyle(
                        color: AppColors.black,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    // padding:
                    //     const EdgeInsets.fromLTRB(120.0, 10.0, 120.0, 10.0),
                    // textColor: Colors.white,
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.fromLTRB(120.0, 10.0, 120.0, 10.0),
                      primary: AppColors.appSecondaryColor,
                      onPrimary: Colors.white,
                      elevation: 3,
                      disabledForegroundColor: Colors.white,
                      disabledBackgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: AppColors.appSecondaryColor)),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState?.validate()??false) {
                        //pr.show();
                        final String strUserEmail = userEmailIDController.text;

                        final String strUserFirstName =
                            userFirstNameController.text;
                        final String strUserLastName =
                            userLastNameController.text;
                        final String strUserSubject =
                            userSubjectController.text;
                        final String strAddress = userAddressController.text;

                        var user = await submitContactUS(
                            strUserFirstName,
                            strUserLastName,
                            strUserEmail,
                            strUserSubject,
                            strAddress);
                        if (user != null) {
                          if (user['error_enquiry'] != null) {
                            showFailMsg(
                               user['error_enquiry'].toString()+"ERROR",
                            );
                          } else if (user['success'] != null) {
                            showSuccessMsg(
                              'Enquiry Submitted Successfully',
                            );
                            setState(() {
                              userEmailIDController.clear();
                              userFirstNameController.clear();
                              userLastNameController.clear();
                              userSubjectController.clear();
                              userAddressController.clear();
                            });
                          } else {
                            print(
                                "jigar the new else response user1.toString() " +
                                    user.toString());
                          }
                        }
                      }
                    },
                    // disabledTextColor: Colors.white,
                    // color: AppColors.appSecondaryOrangeColor,
                    // elevation: 3,
                    child: Text(
                      _contactUsModel != null
                          ? _contactUsModel?.buttonSubmit ?? "Submit"
                          : "Submit",
                      style: TextStyle(fontSize: 18),
                    ),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     side: BorderSide(
                    //         color: AppColors.appSecondaryOrangeColor)),
                    // disabledColor: Colors.cyan,
                  ),
                ],
              ),
            )),

        // body: const WebView(
        //   initialUrl: 'https://amavi.com.kw/index.php?route=information/information&information_id=3',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),

        //original code
      ),
    );
  }

  Future<dynamic> submitContactUS(String strFirstName, String strLastName,
      String strEmail, String strSubject, String strEnquiry) async {
    var jsonResponse;

    pr?.show();
    try {
      String strBaseUrl = Constants.CONTACT_US_URL + strToken!;
      var map = new Map<String, String>();
      map['email'] = strEmail;
      map['name'] = strFirstName;
      map['lastname'] = strLastName;
      map['subject'] = strSubject;
      map['enquiry'] = strEnquiry;

      print("jigar the contact parameter is " + map.toString());

      var response = await Dio().post(
        strBaseUrl,
        data: map,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print("jigar the response contact status we got is " +
          response.statusCode.toString());
      print("jigar the response contact we got is " + response.toString());

      if (response.statusCode.toString() == "302") {
//        var user = loginAuthentication(strEmail, strPassword, context);

        setState(() {});
        // var user = await loginAuthentication(strEmail, strPassword, context);
        // setLoginAuth(user, strEmail, strPassword);
      } else {
//    var jsonResponse;
        jsonResponse =
            convert.jsonDecode(response.toString()) as Map<String, dynamic>;
      }

      setState(() {
        pr?.hide();
      });
    } catch (e) {
      // print("jigar the response before contact us we got is " +
      //     e.response.statusCode.toString());

//       if (e.response.statusCode == 302) {
//         setState(() {});
//         // var user = await loginAuthentication(strEmail, strPassword, context);
//         // setLoginAuth(user, strEmail, strPassword);
// //        print(e.response.statusCode);
//       }
    }
    return jsonResponse;
  }

  Future<void> getContactDetails() async {
    var jsonResponse;

    pr?.show();
    try {
      String strBaseUrl = Constants.CONTACT_US_URL + strToken!;

      print("jigar the contact parameter is " + strBaseUrl);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? strPhpSessionID =
          prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
      String? strCurrency =
          prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
      String? strDefault =
          prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
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
      var response = await Dio().get(
        strBaseUrl,
        options: Options(
            headers: requestHeaders,
            followRedirects: false,
            validateStatus: (status) {
              return status !< 500;
            }),
      );
      print("jigar the response contact status we got is " +
          response.statusCode.toString());
      print("jigar the response contact we got is " + response.toString());

      if (response.statusCode.toString() == "302") {
//        var user = loginAuthentication(strEmail, strPassword, context);

        setState(() {});
        // var user = await loginAuthentication(strEmail, strPassword, context);
        // setLoginAuth(user, strEmail, strPassword);
      } else {
//    var jsonResponse;
        _contactUsModel = contactUsModelFromJson(jsonEncode(response.data));
      }
      pr?.hide();

      setState(() {});
    } catch (e) {

    }
    return jsonResponse;
  }
}
