
import 'dart:convert';
import 'dart:developer';

import 'package:amavinewapp/Pages/homepage.dart';
import 'package:amavinewapp/Pages/loginpage.dart';
import 'package:amavinewapp/Pages/placeholder_setiing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;

import '../Model/LoginModel.dart';
import '../Model/TokenModel.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  String? strToken;
  String? strLangCode;
  SharedPreferences? prefs;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      starttime();
    });
    super.initState();
  }
  starttime() async {
    prefs = await SharedPreferences.getInstance();
    try{
      bool? isUserFirstTime =
      prefs?.getBool(Constants.UserDetailsTag.ISFIRSTTIME);
      String? socialData =
      prefs?.getString(Constants.TokenDetailsTag.SOCIAL_DATA);
      if (isUserFirstTime == null) {
        isUserFirstTime = true;
      }
      TokenModel _tokenMyResponse = await tokenAuthentication(context);
      if (isUserFirstTime) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingPage(
                      () {},
                  'Settings',
                  isFirstTime: isUserFirstTime,
                )));
      }
      if (socialData != null) {
        _socialLogin();
      }
      else if (prefs?.getString(Constants.TokenDetailsTag.TAG_TOKEN) !=
          null) {
        strToken = prefs?.getString(Constants.TokenDetailsTag.TAG_TOKEN);

        if (prefs?.getString(Constants.UserDetailsTag.TAG_STORED_USER_NAME) !=
            null) {
          String? strUserEmail =
          prefs?.getString(Constants.UserDetailsTag.TAG_STORED_USER_NAME);
          String? strUserPassword =
          prefs?.getString(Constants.UserDetailsTag.TAG_STORED_PASSWORD);

          print("jigar the saved user name is " + strUserEmail!);
          print("jigar the saved user password is " + strUserPassword!);
         // var data = await getFirebaseToken(context, strToken!, "initial");

          var user =
          await getAccountDetails(strUserEmail, strUserPassword, context);

          if (user != "") {
            if (user['firstname'] != null) {
              print("jigar the response l_loginMyResponse with new token is  " +
                  user.toString());

              var data = await loginAuthentication(
                  strUserEmail, strUserPassword, context);

              LoginModel loginModel = LoginModel.fromJson(data);

              if (data['code'] != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        // homepage1(loginModel, false),
                    homepage(loginModel,false),
                  ),
                );
              }
            }
          } else {
            TokenModel _tokenMyResponse = await tokenAuthentication(context);
            SharedPreferences sharedPreferenceManager =
            await SharedPreferences.getInstance();
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

            strToken = _tokenMyResponse.token;
            print("jigar the response new token generated  is  " + strToken!);

            sharedPreferenceManager.setString(
                Constants.TokenDetailsTag.TAG_TOKEN, strToken!);

            var data = await loginAuthentication(
                strUserEmail, strUserPassword, context);

            LoginModel loginModel = LoginModel.fromJson(data);

            if (data['code'] != null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          // homepage1(loginModel, false)
                          //
                      homepage(loginModel,false)
                  ));
            }
          }
        } else {
          print(
              "jigar the saved user name is null and calling token part child ");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  loginpage()

              ));
        }
      } else {
        print("jigar the saved token is  and calling token part parent");
        TokenModel _tokenMyResponse = await tokenAuthentication(context);
        print("jigar the saved token is null " +
            _tokenMyResponse.token.toString());

        route(_tokenMyResponse);
      }
    } catch (e) {
      prefs?.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  loginpage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/splash_intro.jpg"),
    fit: BoxFit.cover),
    ),
    ));
  }

  Future<dynamic> getAccountDetails(
      String strUserName, String strPassword, BuildContext context) async {
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

    final String strBaseUrl =
        Constants.GET_ADDRESS_ACCOUNT_DETAILS_URL + strToken!;
    print("jigar the getAccountDetails url is " + strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    print("jigar the response account status we got is " +
        response.statusCode.toString());
    print("jigar the response account we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response user.toString() we got is " + user.toString());

    if (user['firstname'] != null) {
      print(
          "jigar the if part user['firstname']" + user['firstname'].toString());

      setState(() {});

      return user;
    } else {
      print("jigar the else part with no customer info");

      return "";
    }
  }
  Future<dynamic> loginAuthentication(
      String strEmail, String strPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strLangCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);

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

    print("jigar the response login url status we got is " +
        Constants.LOGIN_URL +
        strToken!);

    final String strBaseUrl =
        Constants.LOGIN_URL + strToken! + "&customer_language=${strLangCode}";
    var map = new Map<String, dynamic>();
    map['email'] = strEmail;
    map['password'] = strPassword;

    final response = await http.post(Uri.parse(strBaseUrl),
        body: map, headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    // pr.hide();
    // LoginModel loginModel = LoginModel.fromJson(jsonResponse);

    return jsonResponse;
  }
  route(TokenModel tokenModel) async {
    SharedPreferences sharedPreferenceManager =
    await SharedPreferences.getInstance();
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

    String? strTokenID = tokenModel.token;
    sharedPreferenceManager.setString(
        Constants.TokenDetailsTag.TAG_TOKEN, strTokenID!);

    print("jigar the saving the route token is" +
        sharedPreferenceManager
            .getString(Constants.TokenDetailsTag.TAG_TOKEN)
            .toString());
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>  loginpage()));
  }
  Future<TokenModel> tokenAuthentication(BuildContext context) async {
    final String strBaseUrl = Constants.TokenDetailsTag.TOKEN_LOGIN;

    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
      // 'Cookie':
      //     'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
    };
    var map = new Map<String, dynamic>();
    map[Constants.TokenDetailsTag.TAG_USER_NAME] =
        Constants.TokenDetailsTag.TAG_VALUE_USER_NAME;
    map[Constants.TokenDetailsTag.TAG_PASSWORD] =
        Constants.TokenDetailsTag.TAG_VALUE_PASSWORD;

    final response = await http.post(Uri.parse(strBaseUrl),
        body: map, headers: requestHeaders);


    print("jigar the response response.headers we got is " +
        response.headers.toString());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strCookie = response.headers['set-cookie'];
    String strPhpid = strCookie!
        .substring(strCookie.indexOf("PHPSESSID") + 10, strCookie.indexOf(";"));
    strCookie = strCookie.substring(strCookie.indexOf(";"));
    String strCurrency = strCookie.substring(strCookie.indexOf("currency") + 9,
        strCookie.indexOf(";", strCookie.indexOf("currency") + 9));
    String strDefault = strCookie.substring(strCookie.indexOf("default") + 8,
        strCookie.indexOf(";", strCookie.indexOf("default") + 8));
    String strLanguage = strCookie.substring(strCookie.indexOf("language") + 9,
        strCookie.indexOf(";", strCookie.indexOf("language") + 9));
    prefs.setString(Constants.TokenDetailsTag.TAG_PHPSESSID, strPhpid);
    prefs.setString(Constants.TokenDetailsTag.TAG_CURRENCY, strCurrency);
    prefs.setString(Constants.TokenDetailsTag.TAG_DEFAULT, strDefault);
    prefs.setString(Constants.TokenDetailsTag.TAG_LANGUAGE, strLanguage);
    String? strHeader =
    prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);

    print(
        "jigar the response response.headers.length strHeader : " + strHeader!);
    print("jigar the response response.headers.length strHeader : " + strPhpid);
    print("jigar the response response.headers.length strCurrency : " +
        strCurrency);
    print("jigar the response response.headers.length strDefault : " +
        strDefault);
    print("jigar the response response.headers.length strLanguage : " +
        strLanguage);
//    final String responseString = response.body;

    print("jigar the response tokenAuthentication we got is " +
        response.statusCode.toString());
    print("jigar the response tokenAuthentication we got is " +
        response.body.toString());
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    var jsonData = TokenModel.fromJson(jsonResponse);

    // var data =
    // await getFirebaseToken(context, jsonData.token.toString(), "initial");

    return jsonData;
  }
  Future<void> _socialLogin() async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      TokenModel _tokenMyResponse = await tokenAuthentication(context);
      strToken = _tokenMyResponse.token;
      String? socialData =
      prefs.getString(Constants.TokenDetailsTag.SOCIAL_DATA);
      var params = jsonDecode(socialData!);
      await prefs.setString(Constants.TokenDetailsTag.TAG_TOKEN,
          _tokenMyResponse.token.toString());
      progressDialog.show();
      String _baseUrl =
          "${Constants.TokenDetailsTag.SOCIAL_LOGIN}${_tokenMyResponse.token}";

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

      final request = await http.post(Uri.parse(_baseUrl),
          body: params, headers: requestHeaders);
      var response = convert.jsonDecode(request.body);
      log("SocialLogin Response ===>   $params       ${request.body}  $response ${request.request?.url}");
      progressDialog.hide();
      prefs.setString(
          Constants.TokenDetailsTag.SOCIAL_DATA, convert.jsonEncode(params));
      if (response["status"] == "new_customer") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) =>  loginpage()),
                (route) => false);
      } else if (response["status"] == "logged_in") {
        loginUserWithLogout(params["email"]);
      }
    } catch (e) {
      log("SocialLogin Response ===>   $e");
      progressDialog.hide();
    }
  }
  loginUserWithLogout(String emailId) async {
    // LogoutModel user1 = await logoutUser(context);
    ProgressDialog pr = ProgressDialog(context);
    try {
      pr.show();
      SharedPreferences sharedPreferenceManager =
      await SharedPreferences.getInstance();
      sharedPreferenceManager.setString(
          Constants.UserDetailsTag.TAG_STORED_USER_NAME, emailId);
      sharedPreferenceManager.setString(
          Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN, "false");

      final String strBaseUrl = Constants.HOME_PAGE_DATA_URL + strToken!;
      final homeDataRequest = await http.get(Uri.parse(strBaseUrl));
      var homeResponseData = convert.jsonDecode(homeDataRequest.body);
      LoginModel loginModel = LoginModel.fromJson(homeResponseData);

      pr.hide();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>
              //homepage1(loginModel, false)
            homepage(loginModel,false)
          ),
              (_) => false);
    } catch (e) {
      log("message   ==>  $e");
      pr.hide();
    }
  }

}
