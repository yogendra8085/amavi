
import 'package:amavinewapp/Pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../Model/CurrencySettingModel.dart';
import '../Model/LoginModel.dart';

import 'package:amavinewapp/constantpages/Constants.dart'as Constants;

import 'package:shared_preferences/shared_preferences.dart';

import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';



class SettingPage extends StatefulWidget {
  Function? refresh;
  String? strHeading;
  bool? isFirstTime;


  SettingPage(Function mRefresh, String strHeading,
      {this.isFirstTime = false}) {
   this. refresh = mRefresh;
    this.strHeading = strHeading;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingPageState(strHeading!);
  }
}

class SettingPageState extends State<SettingPage> {
  String? strAccessToken;
  String? strToken;
  CurrencySettingModel? currencySettingModel;
  Currencies? _myCurrencySelection;
  Languages? _myLanguageSelection;

  var _formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController =
      TextEditingController(text: "");
  final TextEditingController newPasswordController =
      TextEditingController(text: "");
  final TextEditingController confirmNewPasswordController =
      TextEditingController(text: "");
  LoginModel? loginGlobalResponse;
  String? strHeading = "";
  ProgressDialog? pr;
  bool _isGuestLogin = true;

  SettingPageState(strHeading) {
    this.strHeading = strHeading;
  }

  bool _isShowNotification = true;
  showFailMsg(String msg) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showSuccessMsg(String string) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   initController();
    SharedPreferences.getInstance().then((value) async {
      bool? isShow = await value.getBool("isNotification");
      if (isShow == null) {
        value.setBool("isNotification", true);
      } else {
        _isShowNotification = isShow ?? false;
      }
      String? isGuestLogin =
          value.getString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN);
      if (isGuestLogin != null) {
        _isGuestLogin = (isGuestLogin.toString().toLowerCase() == "true");
      }
      setState(() {});
    });

  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN)??"";
    print(strToken);
    getCurrencyList(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: () async {
          if (widget.isFirstTime!) {
            return Future.value(false);
          }
          if (widget.refresh != null) {
            widget.refresh!(); // just refresh() if its statelesswidget
          }
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.

          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: widget.isFirstTime!
                ? null
                : IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      if (widget.refresh != null) {
                        Navigator.pop(context);
                        widget
                            .refresh!(); // just refresh() if its statelesswidget

                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Form(
//        child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (currencySettingModel != null ? strHeading : "Setting")
                            .toString(),
//                    'Your Rewards',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: SizeConfig.blockSizeVertical! * 2.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                if (!_isGuestLogin)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Notification",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Switch(
                          value: _isShowNotification,
                          onChanged: (v) async {
                            SharedPreferences sharedPref =
                                await SharedPreferences.getInstance();
                            sharedPref.setBool("isNotification", v);
                            _isShowNotification = v;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                new Container(
                    child: Form(
                  key: _formKey,
                  child: Expanded(
                    child: currencySettingModel != null
                        ? Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  color: Colors.white,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  semanticContainer: false,
                                  child: IntrinsicHeight(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Currency',
//                    'Your Rewards',
                                              style: TextStyle(
                                                color: AppColors
                                                    .appSecondaryOrangeColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                                fontSize: SizeConfig
                                                        .blockSizeVertical! *
                                                    2.3,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 20, 10, 10),
                                              child: Container(
                                                width: double.infinity,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    border: Border.all(
                                                        color:
                                                            Colors.blueGrey)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 10),
                                                  child:
                                                      new DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                        Currencies>(
                                                      isExpanded: true,
                                                      hint: Text(
                                                          "Select Currency",
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                          )),
                                                      dropdownColor:
                                                          AppColors.white,
                                                      items: currencySettingModel
                                                                  ?.currencies !=
                                                              null
                                                          ? currencySettingModel
                                                              ?.currencies
                                                              ?.map((item) {
                                                              return new DropdownMenuItem(
                                                                child: new Text(
                                                                    item.enTitle
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .black,
                                                                    )),
                                                                value: item,
                                                              );
                                                            }).toList()
                                                          : [],
                                                      onChanged: (val) {
                                                        setState(() {
                                                          _myCurrencySelection =
                                                              val!;
                                                        });
                                                      },
                                                      value:
                                                          _myCurrencySelection,
                                                      style: new TextStyle(
                                                        color: AppColors.black,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  )),
                              Card(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  color: Colors.white,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  semanticContainer: false,
                                  child: IntrinsicHeight(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Languages',
//                    'Your Rewards',
                                              style: TextStyle(
                                                color: AppColors
                                                    .appSecondaryOrangeColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                                fontSize: SizeConfig
                                                        .blockSizeVertical! *
                                                    2.3,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 20, 10, 10),
                                              child: Container(
                                                width: double.infinity,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                    border: Border.all(
                                                        color:
                                                            Colors.blueGrey)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 10),
                                                  child:
                                                      new DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                        Languages>(
                                                      isExpanded: true,
                                                      hint: Text(
                                                          "Select Language",
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                          )),
                                                      dropdownColor:
                                                          AppColors.white,
                                                      items: currencySettingModel
                                                                  ?.languages !=
                                                              null
                                                          ? currencySettingModel
                                                              ?.languages!
                                                              .map((item) {
                                                              return new DropdownMenuItem(
                                                                child: new Text(
                                                                    item.name
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .black,
                                                                    )),
                                                                value: item,
                                                              );
                                                            }).toList()
                                                          : [],
                                                      onChanged: (newVal) {
                                                        setState(() {
                                                          _myLanguageSelection =
                                                              newVal!;
                                                        });
                                                      },
                                                      value:
                                                          _myLanguageSelection,
                                                      style: new TextStyle(
                                                        color: AppColors.black,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 20, 0, 20),
                                            child: ElevatedButton(
                                              // padding:
                                              //     const EdgeInsets.fromLTRB(
                                              //         120.0, 10.0, 120.0, 10.0),
                                              // textColor: Colors.white,
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        120.0,
                                                        10.0,
                                                        120.0,
                                                        10.0),
                                                primary:
                                                    AppColors.appSecondaryColor,
                                                onPrimary: Colors.white,
                                                elevation: 3,
                                                disabledForegroundColor:
                                                    Colors.white,
                                                disabledBackgroundColor:
                                                    Colors.cyan,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                        color: AppColors
                                                            .appSecondaryColor)),
                                              ),
                                              onPressed: () async {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  var user1 =
                                                      await setGetCurrencyUpdate(
                                                          context);

                                                  if (user1 != null) {
                                                    if (user1[
                                                            'error_warning'] !=
                                                        null) {
                                                      showFailMsg(
                                                        user1['error_warning']
                                                            .toString(),
                                                      );
                                                    } else if (user1[
                                                            'success'] !=
                                                        null) {
                                                      showFailMsg(
                                                        'Setting Updated Successfully',
                                                      );
                                                    }
                                                  }
                                                }
                                              },
                                              // disabledTextColor: Colors.white,
                                              // color:
                                              //     AppColors.appSecondaryColor,
                                              // elevation: 3,
                                              child: Text(
                                                'Update',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              // shape: RoundedRectangleBorder(
                                              //     borderRadius:
                                              //         BorderRadius.circular(
                                              //             10.0),
                                              //     side: BorderSide(
                                              //         color: AppColors
                                              //             .appSecondaryColor)),
                                              // disabledColor: Colors.cyan,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        : Container(),
                  ),
                )),
              ],
            ),
            //    ),
          ),
        ));
  }

  Future<dynamic> setGetCurrencyUpdate(BuildContext context) async {
    pr = new ProgressDialog(context);

    pr?.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strPhpSessionID =
        prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
    String strCurrency =
        prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY).toString();
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

    String? strCurrencyCode = _myCurrencySelection?.code;
    String? strCustomerLanguage = _myLanguageSelection?.code;
    String strBaseUrl;
    strBaseUrl = Constants.SET_CURRENCY_DEFAULT_URL +
        "&currency_code=" +
        strCurrencyCode! +
        "&customer_language=" +
        strCustomerLanguage!;

    print("jigar the response setGetCurrencyUpdate url is we got is " +
        strBaseUrl);

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response setGetCurrencyUpdate status we got is " +
        response.statusCode.toString());
    print("jigar the response setGetCurrencyUpdate we got is " +
        response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(
        "jigar the response setGetCurrencyUpdate we got is " + user.toString());

    //if (user['languages'] != null)

    setState(() {
      GetHomeData(context);
    });
    //pr.hide();

    return user;
    // else {
    //   print("jigar the else part with no language info");
    //   pr.hide();
    //
    //   return "";
    // }
  }

  Future<dynamic> GetHomeData(BuildContext context) async {
    // ProgressDialog pr = new ProgressDialog(context);

    //  pr.show();
    print("jigar the response login url status we got is " +
        Constants.HOME_PAGE_DATA_URL +
        (strToken ?? ""));
    String? strCustomerLanguage = _myLanguageSelection?.code;
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

    final String strBaseUrl = Constants.HOME_PAGE_DATA_URL +
        (strToken ?? "") +
        "&customer_language=" +
        strCustomerLanguage!;

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    // LoginModel loginModel = LoginModel.fromJson(jsonResponse);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomeBottomScreen()));

    // setState(() {});
    LoginModel loginModel = LoginModel.fromJson(jsonResponse);

    prefs.setString(
        Constants.UserDetailsTag.LANG_CODE,
        _myLanguageSelection?.code == 'en'
            ? 'en-gb'
            : _myLanguageSelection!.code.toString());

    pr?.hide();
    await prefs.setBool(Constants.UserDetailsTag.ISFIRSTTIME, false);
    if (widget.isFirstTime!) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setBool(Constants.UserDetailsTag.ISFIRSTTIME, false);
      Navigator.pop(context);
    } else {
      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
              // new homepage1(loginModel, _isGuestLogin)
            homepage(loginModel,_isGuestLogin),

          ));
    }
    // if (this.mounted) {
    //   setState(() {
    //     // Your state change code goes here
    //   });
    // }

    return jsonResponse;
  }

  Future<dynamic> getCurrencyList(BuildContext context) async {
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
    String strBaseUrl;
    strBaseUrl = Constants.GET_CURRENCY_DEFAULT_LIST_URL;

    print("jigar the response getCurrencyList url is we got is " + strBaseUrl);

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response getCurrencyList status we got is " +
        response.statusCode.toString());
    print("jigar the response getCurrencyList we got is " +
        response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response getCurrencyList we got is " + user.toString());

    if (user['languages'] != null) {
      currencySettingModel = CurrencySettingModel.fromJson(user);

      for (int i = 0; i < currencySettingModel!.currencies!.length; i++) {
        if (currencySettingModel!.currencies?[i].code ==
            currencySettingModel!.currentCurrencyCode) {
          print("jigar the response selected currency is  we got is " +
              currencySettingModel!.currencies![i].code.toString());

          _myCurrencySelection = currencySettingModel!.currencies![i];
        }
      }

      for (int i = 0; i < currencySettingModel!.languages!.length; i++) {
        if (currencySettingModel?.languages?[i].code ==
            currencySettingModel!.currentLanguageCode) {
          print("jigar the response selected currency is  we got is " +
              currencySettingModel!.languages![i].code.toString());

          _myLanguageSelection = currencySettingModel?.languages![i];
        } else {
          _myLanguageSelection = currencySettingModel?.languages![0];
        }
      }

      print(
          "jigar the response currencySettingModel.currentLanguageCode.toString() is " +
              currencySettingModel!.currentLanguageCode.toString());
      print("jigar the response _myCurrencySelection.toString() is " +
          _myCurrencySelection.toString());
      setState(() {});
      pr.hide();

      return user;
    } else {
      print("jigar the else part with no language info");
      pr.hide();

      return "";
    }
  }
}
