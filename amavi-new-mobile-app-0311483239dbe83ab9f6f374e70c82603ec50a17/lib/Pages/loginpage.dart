
import 'dart:io';

import 'package:amavinewapp/Pages/homepage.dart';
import 'package:amavinewapp/Pages/ragisterpage.dart';
import 'package:amavinewapp/apicaling/guestlogin.dart';
import 'package:amavinewapp/apicaling/sociallogin.dart';
import 'package:amavinewapp/apicaling/tokenauthentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/LoginModel.dart';
import '../Model/TokenModel.dart';
import '../apicaling/loginapi.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  int _counter = 0;
  var _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final TextEditingController userNameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  LoginModel? loginGlobalResponse;
  String? strToken;
  SharedPreferences? prefs;
  String _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  // final FacebookLogin facebookSignIn = new FacebookLogin();
  final billingAddress1Key = UniqueKey();
  final billingAddress2Key = UniqueKey();
  void initState() {
    super.initState();
    if (kDebugMode) {
      userNameController.text = "john2012007@gmail.com";
      passwordController.text = "john2012007";
    }
    initController();
  }
  initController() async {
    prefs = await SharedPreferences.getInstance();
    _languageCode =
        prefs!.getString((Constants.UserDetailsTag.LANG_CODE)).toString();
    print("_languageCode ==> $_languageCode");
    strToken = prefs?.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    // logoutUser(context);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
      textDirection: _languageCode == Constants.UserDetailsTag.LANG_CODE_EN
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          body: Container(
              height: SizeConfig.blockSizeVertical! * 20,
              width: SizeConfig.blockSizeHorizontal! * 50,
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash_intro_blank.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: AutofillGroup(
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeVertical! * 5,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(28, 10, 28, 10),
                                child: Image.asset(
                                    'assets/images/app_text_logo.png',
                                    height: SizeConfig.blockSizeVertical! * 5,
                                    fit: BoxFit.fill),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical! * 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new TextFormField(

                                  autofillHints: [AutofillHints.email],
                                  controller: userNameController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.appSecondaryColor,
                                    labelText: _languageCode ==
                                        Constants
                                            .UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Email"
                                        : 'أدخل البريد الإلكتروني',
                                    errorStyle: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeVertical! *
                                            1.7),
                                    labelStyle: TextStyle(
                                        color: AppColors.black,
                                        fontSize:
                                        SizeConfig.blockSizeVertical! *
                                            1.7),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                      new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val?.length == 0) {
                                      return "Email cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  style: new TextStyle(
                                    fontSize:
                                    SizeConfig.blockSizeVertical! * 1.7,
                                    color: AppColors.black,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new TextFormField(

                                  autofillHints: [AutofillHints.password],
                                  controller: passwordController,
                                  decoration: new InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeVertical! *
                                            1.7),
                                    focusColor: AppColors.appSecondaryColor,
                                    labelText: _languageCode ==
                                        Constants
                                            .UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Password"
                                        : 'أدخل كلمة المرور',
                                    labelStyle:
                                    TextStyle(color: AppColors.black),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                      new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val?.length == 0) {
                                      return "Password cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                  style: new TextStyle(
                                    fontSize:
                                    SizeConfig.blockSizeVertical! * 1.7,
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                // padding: const EdgeInsets.fromLTRB(
                                //     120.0, 10.0, 120.0, 10.0),
                                // textColor: Colors.white,
                                style: ElevatedButton.styleFrom(
                                  // padding: const EdgeInsets.fromLTRB(
                                  //     120.0, 10.0, 120.0, 10.0),
                                  primary: AppColors.appSecondaryColor,
                                  onPrimary: Colors.white,
                                  elevation: 3,
                                  disabledForegroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.cyan,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: AppColors.appSecondaryColor)),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    //      pr.show();
                                    SharedPreferences sharedPreferenceManager =
                                    await SharedPreferences.getInstance();
                                    sharedPreferenceManager.remove(
                                        Constants.TokenDetailsTag.SOCIAL_DATA);
                                    final String strUserEmail =
                                        userNameController.text;
                                    final String strUserPassword =
                                        passwordController.text;

                                    await await token().setGetCurrencyUpdate(context, _languageCode);

                                    // var user = await loginAuthentication(
                                    //     strUserEmail, strUserPassword, context);
                                    var user = await loginapi(strUserEmail,strUserPassword,strToken,prefs).loginauthentication();


                                    if (user['token_error'] == null) {
                                      print(
                                          "jigar the response l_loginMyResponse with new token is  " +
                                              user.toString());

                                      // Navigator.pushReplacement(
                                      //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

                                      LoginModel loginModel =
                                      LoginModel.fromJson(user);

//                                  if (body['token']?.isNotEmpty == true)
                                      if (user['code'] == null) {
                                        if (user['error_warning'] != null) {
                                          showFailMsg(
                                            user['error_warning'].toString(),
                                          );
                                        } else {
                                          showFailMsg(
                                            "Something went wrong,Please try again later",
                                          );
                                        }
                                      } else {
                                        sharedPreferenceManager.setString(
                                            Constants.UserDetailsTag
                                                .TAG_STORED_USER_NAME,
                                            strUserEmail);
                                        sharedPreferenceManager.setString(
                                            Constants.UserDetailsTag
                                                .TAG_STORED_PASSWORD,
                                            strUserPassword);
                                        print(
                                            "jigar the we have saved user name " +
                                                sharedPreferenceManager
                                                    .getString(Constants
                                                    .UserDetailsTag
                                                    .TAG_STORED_USER_NAME)
                                                    .toString());
                                        print(
                                            "jigar the we have saved user password " +
                                                sharedPreferenceManager
                                                    .getString(Constants
                                                    .UserDetailsTag
                                                    .TAG_STORED_PASSWORD)
                                                    .toString());

                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pushReplacement(MaterialPageRoute(
                                            builder: (context) =>
                                            // new homepage1(
                                            //     loginModel, false)
                                          homepage(loginModel,false),
                                        ));

                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             HomeBottomScreen(
                                        //                 loginModel, false)));
                                        print(
                                            "jigar the response loginModel.code.toString() with new token is  " +
                                                loginModel.code.toString());
                                      }
                                    } else {
                                      var tokenError = user['token_error'];

                                      if (tokenError == "invalid_token") {
                                        // print(
                                        //     "jigar the response loginGlobalResponse.data invalid token is  " +
                                        //         loginGlobalResponse.toString());

                                        // TokenErrorModel tokenErrorModel =
                                        //     loginGlobalResponse as TokenErrorModel;
                                        //
                                        //
                                        //   print(
                                        //       "jigar the response tokenModel.tokenError invalid token is  " +
                                        //           tokenErrorModel.tokenError);
                                        {
                                          TokenModel _tokenMyResponse =
                                         await token().tokenAuthentication(context);
                                          {
                                            SharedPreferences
                                            sharedPreferenceManager =
                                            await SharedPreferences
                                                .getInstance();
                                            // Navigator.pushReplacement(
                                            //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

                                            strToken = _tokenMyResponse.token;
                                            print(
                                                "jigar the response new token generated  is  " +
                                                    strToken!);

                                            sharedPreferenceManager.setString(
                                                Constants
                                                    .TokenDetailsTag.TAG_TOKEN,
                                                strToken!);

                                            final String strUserEmail =
                                                userNameController.text;
                                            final String strUserPassword =
                                                passwordController.text;

                                            await token().setGetCurrencyUpdate(context, _languageCode);
                                            // var _loginMyResponse =
                                            // await loginAuthentication(
                                            //     strUserEmail,
                                            //     strUserPassword,
                                            //     context);
                                            var   _loginMyResponse= await loginapi(strUserEmail,strUserPassword,strToken,prefs).loginauthentication();

                                            // var jsonResponse =
                                            // convert.jsonDecode(_loginMyResponse) as Map<String, dynamic>;

                                            print(
                                                "jigar the response l_loginMyResponse with new token is  " +
                                                    _loginMyResponse
                                                        .toString());
                                            LoginModel loginModel =
                                            LoginModel.fromJson(
                                                _loginMyResponse);

                                            sharedPreferenceManager.setString(
                                                Constants.UserDetailsTag
                                                    .TAG_STORED_USER_NAME,
                                                strUserEmail);
                                            sharedPreferenceManager.setString(
                                                Constants.UserDetailsTag
                                                    .TAG_STORED_PASSWORD,
                                                strUserPassword);
                                            print("jigar the we have saved user name " +
                                                sharedPreferenceManager
                                                    .getString(Constants
                                                    .UserDetailsTag
                                                    .TAG_STORED_USER_NAME)
                                                    .toString());
                                            print(
                                                "jigar the we have saved user password " +
                                                    sharedPreferenceManager
                                                        .getString(Constants
                                                        .UserDetailsTag
                                                        .TAG_STORED_PASSWORD)
                                                        .toString());

                                            Navigator.of(context,
                                                rootNavigator: true)
                                                .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    // new homepage1(
                                                    //     loginModel,
                                                    //     false)
                                                  homepage(loginModel,false),
                                                ));

                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             HomeBottomScreen(
                                            //                 loginModel, false)));
                                            print(
                                                "jigar the response loginModel.code.toString() with new token is  " +
                                                    loginModel.code.toString());
                                          }
                                        }
                                      } else {
                                        print(
                                            "jigar the response loginGlobalResponse.data lloginGlobalResponse.code " +
                                                loginGlobalResponse!.code
                                                    .toString());
                                      }
                                    }
                                  }


                                },
                                // disabledTextColor: Colors.white,
                                // color: AppColors.appSecondaryColor,
                                // elevation: 3,
                                child: Text(
                                  _languageCode ==
                                      Constants.UserDetailsTag.LANG_CODE_EN
                                      ? 'Login'
                                      : 'تسجيل الدخول',
                                  style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeVertical! * 1.9),
                                ),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0),
                                //     side: BorderSide(
                                //         color: AppColors.appSecondaryColor)),
                                // disabledColor: Colors.cyan,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: new InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //            // ForgotPasswordScreenPage()
                                          //     //  homepage()
                                          //     ));
                                        },
                                        child: new Padding(
                                          padding: new EdgeInsets.all(10.0),
                                          child: new Text(
                                            _languageCode ==
                                                Constants.UserDetailsTag
                                                    .LANG_CODE_EN
                                                ? "Forgot Password ?"
                                                : 'هل نسيت كلمة السر ؟',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                    .blockSizeVertical! *
                                                    1.9),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                      height:
                                      SizeConfig.blockSizeVertical! * 4.5,
                                    ),
                                    Expanded(
                                      child: new InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  //    RegisterScreenPage()
                                                ragisterpage(emailId: userNameController.text),
                                              ));
                                        },
                                        child: new Padding(
                                          padding: new EdgeInsets.all(10.0),
                                          child: new Text(
                                            _languageCode ==
                                                Constants.UserDetailsTag
                                                    .LANG_CODE_EN
                                                ? "Create Account"
                                                : 'تسجيل',
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                    .blockSizeVertical! *
                                                    1.9),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      //Center Row contents horizontally,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new Text(
                                            "__________",
                                            style: TextStyle(
                                                fontSize:
                                                SizeConfig.blockSizeVertical! *
                                                    1.7,
                                                color: AppColors.black),
                                          ),
                                          flex: 1,
                                        ),
                                        new Flexible(
                                          child: new Text(
                                            "   Or   ",
                                            style: TextStyle(
                                                fontSize:
                                                SizeConfig.blockSizeVertical! *
                                                    1.7,
                                                color: AppColors.black),
                                          ),
                                          flex: 1,
                                        ),
                                        new Flexible(
                                          child: new Text(
                                            "__________",
                                            style: TextStyle(
                                                fontSize:
                                                SizeConfig.blockSizeVertical! *
                                                    1.7,
                                                color: AppColors.black),
                                          ),
                                          flex: 1,
                                        )
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Container(
                                    //     color: gradientStart.withAlpha(120),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        SizeConfig.blockSizeHorizontal! *
                                            10,
                                        vertical:
                                        SizeConfig.blockSizeVertical! *
                                            1.5),
                                    child: Wrap(
                                      runSpacing: 1,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: SignInButton(
                                            Buttons.Google,
                                            onPressed: () async {
                                              try {
                                                if (await _googleSignIn
                                                    .isSignedIn()) {
                                                  await _googleSignIn.signOut();
                                                }
                                                GoogleSignInAccount?
                                                _googleSignAccount =
                                                await _googleSignIn
                                                    .signIn();

                                                Map<String, String> params = {};
                                                params["name"] =
                                                "${_googleSignAccount?.displayName}";
                                                params["email"] =
                                                "${_googleSignAccount?.email}";
                                                params["so_id"] =
                                                "${_googleSignAccount?.id}";
                                                params["so_platform"] =
                                                "GOOGLE";
                                                sociallogin(context,prefs,strToken).socailogin(params);

                                              } catch (error) {
                                                print(error);
                                              }
                                            },
                                          ),
//                                child: _signInButton()
//                                  (
//                                      () {
//                                    _onSignInWithGoogle();
//                                  },
//                                ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            child: SignInButton(
                                              Buttons.FacebookNew,
                                              onPressed: () {
                                                //_signInWithFacebook();
                                               // sociallogin(context,prefs).signInWithFacebook();
                                              },
                                            ),
                                          ),
                                        ),
                                        if (Platform.isIOS)
                                          SizedBox(
                                            width: double.infinity,
                                            child: SignInButton(
                                              Buttons.AppleDark,
                                              onPressed: () {
                                               // _signInWithApple();
                                              },
                                            ),

//
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      // padding: const EdgeInsets.fromLTRB(
                                      //     120.0, 10.0, 120.0, 10.0),
                                      // textColor: Colors.white,
                                      style: ElevatedButton.styleFrom(
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     120.0, 10.0, 120.0, 10.0),
                                        primary:
                                        AppColors.appSecondaryOrangeColor,
                                        onPrimary: Colors.white,
                                        elevation: 3,
                                        disabledForegroundColor: Colors.white,
                                        disabledBackgroundColor:
                                        AppColors.appSecondaryOrangeColor,
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(5.0),
                                        //     side: BorderSide(
                                        //         color:
                                        //         AppColors.appSecondaryOrangeColor)),
                                      ),

                                      onPressed: () async {
                                       guestlogin(context,_languageCode,strToken,prefs).GuestLogin();
                                      },
                                      // disabledTextColor: AppColors.white,
                                      // color: AppColors.appSecondaryOrangeColor,
                                      // elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: Text(
                                          _languageCode ==
                                              Constants.UserDetailsTag
                                                  .LANG_CODE_EN
                                              ? 'Guest User'
                                              : 'حساب زائر',
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                  .blockSizeVertical! *
                                                  1.9),
                                        ),
                                      ),
                                      // shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.circular(10.0),
                                      //     side: BorderSide(
                                      //         color: AppColors.appSecondaryOrangeColor)),
                                      // disabledColor:
                                      //     AppColors.appSecondaryOrangeColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )))),
    );
  }

  void showFailMsg(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
