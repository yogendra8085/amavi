import 'dart:developer';

import 'package:amavinewapp/Pages/homepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/AddAddressModel.dart';
import '../Model/CityListModel.dart';
import '../Model/CountryListModel.dart';
import '../Model/LoginModel.dart';
import '../Model/TokenModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';

class EditAddressScreenPage extends StatefulWidget {
  String strAddressID = "";
  String strFirstName = "";
  String strLastName = "";
  String strAddressLine = "";
  String strEmailID = "";
  String strTelephoneNumber = "";
  String strCountryName = "";
  String strCity = "";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return EditAddressState(strAddressID, strFirstName, strLastName, strEmailID,
        strTelephoneNumber, strCountryName, strCity, strAddressLine);
  }

  EditAddressScreenPage(
      String mAddress,
      String strFirstName,
      String strLastName,
      String strEmailID,
      String strTelephoneNumber,
      String strCountryName,
      String strCity,
      String strAddressLine) {
    strAddressID = mAddress;
    this.strFirstName = strFirstName;
    this.strLastName = strLastName;
    this.strEmailID = strEmailID;
    this.strAddressLine = strAddressLine;
    this.strTelephoneNumber = strTelephoneNumber;
    this.strCountryName = strCountryName;
    this.strCity = strCity;
  }
}

class EditAddressState extends State<EditAddressScreenPage> {
  int _counter = 0;
  var _formKey = GlobalKey<FormState>();
  LoginModel ? loginGlobalResponse;
  bool isSwitched = false;

  bool isValueChanged = false;
  AddAddressModel? addAddressModel;



  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
  final TextEditingController userEmailIDController = TextEditingController();
  final TextEditingController userPhoneNumberController =
      TextEditingController();
  final TextEditingController userAddressController = TextEditingController();
  final TextEditingController userCountryController = TextEditingController();
  final TextEditingController userAreaController = TextEditingController();
  final TextEditingController userCityController = TextEditingController();

  List<String> dataCountryList = []; //edited line
  List<String> dataCountryListID =
      []; //edited line    List<String> dataCountryList = List(); //edited line
  List<String> dataZoneList = []; //edited line
  List<String> dataZoneListID = []; //edited line
  String ?strToken;

  String ?_myCountrySelection;
  String ?_myAreaSelection ;
  String _myOldAreaSelection = "";
  String strCountryName = "";
  String strAddressLine = "";
  String strCity = "";
  String strCountryID = "0";
  String strAgree = "1";
  String strNewsLetter = "1";
  String strZoneID = "0";
  String strAddressID = "0";
  String strFirstName = "";
  String strLastName = "";
  String strEmailID = "";
  String strTelephoneNumber = "";
  String _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  @override
  void initState() {
    super.initState();
    initController();
    //startTime();
  }

  EditAddressState(
      String mAddress,
      String strFirstName,
      String strLastName,
      String strEmailID,
      String strTelephoneNumber,
      String strCountryName,
      String strCity,
      String strAddressLine) {
    this.getCountryList();

    strAddressID = mAddress;
    this.strFirstName = strFirstName;
    this.strLastName = strLastName;
    this.strEmailID = strEmailID;
    this.strTelephoneNumber = strTelephoneNumber;
    this.strCountryName = strCountryName;
    this.strAddressLine = strAddressLine;
    this.strCity = strCity;

    userFirstNameController.text = strFirstName;
    userLastNameController.text = strLastName;
    userEmailIDController.text = strEmailID;
    userPhoneNumberController.text = strTelephoneNumber;
    userAddressController.text = strAddressLine;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _languageCode == Constants.UserDetailsTag.LANG_CODE_EN
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          addAddressModel != null
                              ? (addAddressModel?.textEditAddress).toString():
                          _languageCode ==
                              Constants.UserDetailsTag.LANG_CODE_EN?  'Edit Address Details':"تحرير تفاصيل العنوان",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Poppins",
                            fontSize: 23,
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
                  new Container(

                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage('assets/images/splash_intro_blank.png'),
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      child: Form(
                    key: _formKey,
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(28, 40, 40, 28.0),
                          //   child: Image.asset('assets/images/app_text_logo.png',
                          //       height: 50, fit: BoxFit.fill),
                          // ),

                          SizedBox(
                            height: 5,
                          ),

//            Text(
//              'Login',
//
//              style: TextStyle(
//                color: Colors.purple,
//                fontSize: 20,
//
//
//              ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: new TextFormField(
                              controller: userFirstNameController,
                              decoration: new InputDecoration(
                                focusColor: AppColors.appSecondaryColor,
                                labelText: addAddressModel != null
                                    ? addAddressModel?.entryFirstname
                                    : _languageCode ==
                                            Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter First Name"
                                        : 'أدخل الاسم الأول',
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
                                focusColor: AppColors.black,
                                labelText: addAddressModel != null
                                    ? addAddressModel?.entryLastname
                                    : _languageCode ==
                                            Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Last Name"
                                        : 'إدخال اسم آخر',
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
                                labelText: addAddressModel != null
                                    ? (addAddressModel?.customFields?[1].name).toString()
                                    : _languageCode ==
                                            Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Email ID"
                                        : 'أدخل معرف البريد الإلكتروني',
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
                              controller: userPhoneNumberController,
                              decoration: new InputDecoration(
                                focusColor: AppColors.black,
                                labelText: addAddressModel != null
                                    ?( addAddressModel?.customFields?[0].name).toString()
                                    : _languageCode ==
                                            Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Telephone Number"
                                        : 'أدخل رقم الهاتف',
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
                                  return "Telephone Number cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.phone,
                              style: new TextStyle(
                                color: AppColors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: new TextFormField(
                              controller: userAddressController,
                              decoration: new InputDecoration(
                                focusColor: AppColors.black,
                                labelText: addAddressModel != null
                                    ? addAddressModel?.entryAddress1
                                    : _languageCode ==
                                            Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Address"
                                        : 'أدخل العنوان',
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
                                  return "Address cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                color: AppColors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: Colors.blueGrey)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: new DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text(
                                          addAddressModel != null
                                              ? (addAddressModel?.entryCountry).toString()
                                              : _languageCode ==
                                                      Constants.UserDetailsTag
                                                          .LANG_CODE_EN
                                                  ? "Select Country"
                                                  : 'حدد الدولة',
                                          style: TextStyle(
                                            color: AppColors.black,
                                          )),
                                      dropdownColor: AppColors.white,
                                      items: dataCountryList.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item,
                                              style: TextStyle(
                                                color: AppColors.black,
                                              )),
                                          value: item.toString(),
                                        );
                                      }).toList(),
                                      onChanged: ( val) {
                                        setState(() {
                                          _myCountrySelection = val;
                                          int strIndex = dataCountryList
                                              .indexOf(_myCountrySelection!);
                                          strCountryID =
                                              dataCountryListID[strIndex]
                                                  .toString();

                                          print("jigar the country selected is " +
                                              strCountryID);

                                          isValueChanged = true;
                                          getCityList(strCountryID);
                                        });
                                      },
                                      value: _myCountrySelection,
                                      style: new TextStyle(
                                        color: AppColors.black,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: Colors.blueGrey)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: new DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,


                                      hint: Text(
                                          addAddressModel != null
                                              ? (addAddressModel?.entryZone).toString()
                                              : _languageCode ==
                                                      Constants.UserDetailsTag
                                                          .LANG_CODE_EN
                                                  ? "Select Area"
                                                  : 'حدد المنطقة',
                                          style: TextStyle(
                                            color: AppColors.black,
                                          )),
                                      dropdownColor: AppColors.white,

                                      items: dataZoneList.map((item) {
                                            return new DropdownMenuItem(
                                              child: new Text(item,
                                                  style: TextStyle(
                                                    color: AppColors.black,
                                                  )),
                                              value: item.toString(),
                                            );
                                          }).toList()
                                          ,
                                      onChanged: (newVal) {
                                        setState(() {
                                          _myAreaSelection = newVal!;
                                          strCity = "";
                                          int strIndex = dataZoneList
                                              .indexOf(_myAreaSelection!);
                                          strZoneID = dataZoneListID[strIndex];
                                          // getCityList(strId);
                                        });
                                      },
                                      value: !isValueChanged
                                          ? _myAreaSelection
                                          : dataZoneList.length > 0
                                              ? dataZoneList[0]
                                              : "Select Area" ?? "Select Area",
                                      style: new TextStyle(
                                        color: AppColors.black,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Row(
                            children: [
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                              Text(
                                addAddressModel != null
                                    ? (addAddressModel?.entryDefault).toString()
                                    : _languageCode ==
                                    Constants.UserDetailsTag.LANG_CODE_EN
                                    ? "Make Default Address"
                                    : 'جعل العنوان الافتراضي',
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical !* 1.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black),
                              ),
                            ],
                          ),

                          ElevatedButton(
                          //  textColor: Colors.white,
                            style: ElevatedButton.styleFrom(
                              primary:  AppColors.appSecondaryColor, // background
                              onPrimary: Colors.white, // foreground
                             // disabledTextColor: Colors.white,
                              disabledForegroundColor: Colors.white,
                              //color: AppColors.appSecondaryColor,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: AppColors.appSecondaryColor)),
                              disabledBackgroundColor: Colors.cyan,
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState?.validate()??false) {
                                //pr.show();
                                final String strUserEmail =
                                    userEmailIDController.text;
                                final String strUserFirstName =
                                    userFirstNameController.text;
                                final String strUserLastName =
                                    userLastNameController.text;
                                final String strPhoneNumber =
                                    userPhoneNumberController.text;
                                final String strAddress =
                                    userAddressController.text;
                                final String strCity = userCityController.text;

                                var user1 = await UpdateUserAddress(
                                    strUserEmail,
                                    strUserFirstName,
                                    strUserLastName,
                                    strPhoneNumber,
                                    strAddress,
                                    strCity           ,
                                    isSwitched);
                                if (user1 != null) {
                                  if (user1['error_warning'] != null) {
                                    showFailMsg(
                                      user1['error_warning'].toString(),
                                    );
                                  } else if (user1['logged_in'] != null) {
                                    showSuccessMsg(
                                      'Account Created Successfully',

                                    );


                                    // SharedPreferences sharedPreferenceManager =
                                    //     await SharedPreferences.getInstance();
                                    // sharedPreferenceManager.setString(
                                    //     Constants
                                    //         .UserDetailsTag.TAG_STORED_USER_NAME,
                                    //     strUserEmail);
                                    // sharedPreferenceManager.setString(
                                    //     Constants
                                    //         .UserDetailsTag.TAG_STORED_PASSWORD,
                                    //     strUserPassword);
                                    // print("jigar the we have saved user name " +
                                    //     sharedPreferenceManager.getString(Constants
                                    //         .UserDetailsTag.TAG_STORED_USER_NAME));
                                    // print("jigar the we have saved user password " +
                                    //     sharedPreferenceManager.getString(Constants
                                    //         .UserDetailsTag.TAG_STORED_PASSWORD));

                                    // final String strUserEmail =
                                    // userNameController.text;
                                    // final String strUserPassword =
                                    // passwordController.text;

                                    var user = await loginAuthentication(
                                        strUserEmail, "strUserPassword", context);

                                    if (user['token_error'] == null) {
                                      print(
                                          "jigar the response l_loginMyResponse with new token is  " +
                                              user.toString());

                                      SharedPreferences sharedPreferenceManager =
                                          await SharedPreferences.getInstance();

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
                                            "strUserPassword");
                                        print(
                                            "jigar the we have saved user name " +
                                                ( sharedPreferenceManager.getString(
                                                    Constants.UserDetailsTag
                                                        .TAG_STORED_USER_NAME)).toString());
                                        print(
                                            "jigar the we have saved user password " +
                                                ( sharedPreferenceManager.getString(
                                                    Constants.UserDetailsTag
                                                        .TAG_STORED_PASSWORD)).toString());
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    homepage(
                                                        loginModel, false)));
                                        print(
                                            "jigar the response loginModel.code.toString() with new token is  " +
                                                loginModel.code.toString());
                                      }
                                    } else {
                                      var tokenError = user['token_error'];

                                      if (tokenError == "invalid_token") {

                                        {
                                          String strUserTokenEmail = Constants
                                              .TokenDetailsTag
                                              .TAG_VALUE_USER_NAME;
                                          String strUserTokenPassword = Constants
                                              .TokenDetailsTag.TAG_VALUE_PASSWORD;
                                          TokenModel _tokenMyResponse =
                                              await tokenAuthentication(
                                                  strUserTokenEmail,
                                                  strUserTokenPassword,
                                                  context);
                                          {
                                            SharedPreferences
                                                sharedPreferenceManager =
                                                await SharedPreferences
                                                    .getInstance();


                                            strToken = _tokenMyResponse.token;
                                            print(
                                                "jigar the response new token generated  is  " +
                                                    strToken!);

                                            sharedPreferenceManager.setString(
                                                Constants
                                                    .TokenDetailsTag.TAG_TOKEN,
                                                strToken!);



                                            var _loginMyResponse =
                                                await loginAuthentication(
                                                    strUserEmail,
                                                    "strUserPassword",
                                                    context);



                                            print(
                                                "jigar the response l_loginMyResponse with new token is  " +
                                                    _loginMyResponse.toString());
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
                                                "strUserPassword");
                                            print("jigar the we have saved user name " +
                                                ( sharedPreferenceManager.getString(
                                                    Constants.UserDetailsTag
                                                        .TAG_STORED_USER_NAME)).toString());
                                            print(
                                                "jigar the we have saved user password " +
                                                    ( sharedPreferenceManager
                                                        .getString(Constants
                                                            .UserDetailsTag
                                                            .TAG_STORED_PASSWORD)).toString());

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        homepage(
                                                            loginModel, false)));
                                            print(
                                                "jigar the response loginModel.code.toString() with new token is  " +
                                                    loginModel.code.toString());
                                          }
                                        }
                                      } else {
                                        print(
                                            "jigar the response loginGlobalResponse.data lloginGlobalResponse.code " +
                                                (loginGlobalResponse?.code)
                                                    .toString());
                                      }
                                    }
                                  } else {
                                    print(
                                        "jigar the new else response user1.toString() " +
                                            user1.toString());
                                  }
                                }
                              }
                            },
                            // disabledTextColor: Colors.white,
                            // color: AppColors.appSecondaryColor,
                            // elevation: 3,
                            child: Text(
                              addAddressModel != null
                                  ? (addAddressModel?.buttonContinue).toString()
                                  : _languageCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_EN
                                  ? 'Update Address'
                                  : 'تحديث العنوان',
                              style: TextStyle(fontSize: 18),
                            ),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     side: BorderSide(
                            //         color: AppColors.appSecondaryColor)),
                            // disabledColor: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<CountryListModel> getCountryList() async {
    final String strBaseUrl =
        Constants.PREFIX_LIVE_URL + "index.php?route=restapi/account/register";


//  final msg = jsonEncode({"email":"test3@afrovasresearch.com","pwd":"OpinionSpace2020"});

    final response = await http.get(Uri.parse(strBaseUrl));

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
//    var resBody = json.decode(response.body);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var resBody = CountryListModel.fromJson(jsonResponse);

    print("jigar the data elementAt we zone got is " +
        (resBody.countries?.elementAt(0).name).toString()
    );
    setState(() {
      for (var i = 0; i < (resBody.countries?.length)!.toInt(); i++) {
        print("jigar the data elementAt loop we got is " +
            ( resBody.countries?.elementAt(i).name).toString()
        );
        dataCountryList.add(
            (resBody.countries?.elementAt(i).name).toString()
        );
        dataCountryListID.add(
            (  resBody.countries?.elementAt(i).countryId).toString()
        );

      }

      _myCountrySelection = strCountryName;
      print("jigar the dataCountryListID " + dataCountryListID.toString());
      print("jigar the _myCountrySelection " + _myCountrySelection!);
      int strIndex = dataCountryList.indexOf(_myCountrySelection!);
      print("jigar the strIndex " + strIndex.toString());
      strCountryID = dataCountryListID[strIndex].toString();
      print("jigar the strCountryID " + strCountryID.toString());
      getCityList(strCountryID);

//        this.getCountryName();
    });

//    print(resBody);

    return CountryListModel.fromJson(jsonResponse);
  }

  Future<CityListModel> getCityList(String strCountryID) async {
    final String strBaseUrl = Constants.PREFIX_LIVE_URL +
        "index.php?route=account/account/country&country_id=" +
        strCountryID;

    print("jigar the api we send is " + strCountryID);

    dataZoneList.clear();
    final response = await http.get(Uri.parse(strBaseUrl));

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
//    var resBody = json.decode(response.body);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var resBody = CityListModel.fromJson(jsonResponse);

    //    return loginModelFromJson(responseString);
//
//    var res = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    var resBody = json.decode(res.body);
    print("jigar the data elementAt we zone got is " +
        ( resBody.zone?.elementAt(0).name).toString()
    );
    setState(() {
      for (var i = 0; i < (resBody.zone?.length)!.toInt(); i++) {
        print("jigar the data elementAt loop we got is " +
            (resBody.zone?.elementAt(i).name).toString()
        );

        dataZoneList.add(
            (resBody.zone?.elementAt(i).name).toString()
        );
        dataZoneListID.add
          (
            (resBody.zone?.elementAt(i).zoneId).toString()
        );
//        if (i == 0) {
//          //data.add("Select Country");
//        }
        //  data.add(resBody.data.elementAt(i).countryName);
      }
//        this.getCountryName();
    });

    if (!isValueChanged) {
      _myAreaSelection = strCity;
      _myOldAreaSelection = _myAreaSelection!;
      print("jigar the dataZoneList " + dataZoneList.toString());
      print("jigar the _myAreaSelection " + _myAreaSelection!);
      int strIndex = dataZoneList.indexOf(_myAreaSelection!);
      print("jigar the strIndex " + strIndex.toString());
//    strZoneID = dataZoneList[strIndex].toString();
      strZoneID = dataZoneListID[strIndex];
    }
    print("jigar the strZoneID " + strZoneID.toString());
//    print(resBody);

    return CityListModel.fromJson(jsonResponse);
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE)!;
    getShippingAddress();
    setState(() {});
    //  logoutUser(context);
  }

  //   Future<LogoutModel> logoutUser(BuildContext context) async {
//     ProgressDialog pr = new ProgressDialog(context);
//     pr.style(
//         message: 'Please Waiting...',
//         borderRadius: 10.0,
//         backgroundColor: Colors.white,
//         progressWidget: CircularProgressIndicator(),
//         elevation: 10.0,
//         insetAnimCurve: Curves.easeInOut,
//         progress: 0.0,
//         maxProgress: 100.0,
//         progressTextStyle: TextStyle(
//             color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//         messageTextStyle: TextStyle(
//             color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
//
//     pr.show();
// //    final String strBaseUrl = Constants.LOGOUT_URL+strToken;
//     final String strBaseUrl = Constants.LOGOUT_URL;
//
//     final response = await http.get(Uri.parse(strBaseUrl));
//
//     final String responseString = response.body;
//
//     print("jigar the response status LogoutModel we got is " +
//         response.statusCode.toString());
//     print(
//         "jigar the response LogoutModel we got is " + response.body.toString());
//     var jsonResponse =
//         convert.jsonDecode(response.body) as Map<String, dynamic>;
//
// //    LoginModel loginModel = LoginModel.fromJson(jsonResponse);
//     // Navigator.push(
//     //     context, MaterialPageRoute(builder: (context) => HomeBottomScreen()));
//     pr.hide();
//
// //     if (loginModel.customerinfo.firstname != null) {
// //       if (loginModel.customerinfo.firstname.isNotEmpty) {
// // //        String strMessage = loginModel.msg;
// //         print("jigar the loginModel.data.length we got is " +
// //             loginModel.customerinfo.email);
// //         Fluttertoast.showToast(
// //             msg: "Hello " + loginModel.customerinfo.firstname,
// //             textColor: Colors.red,
// //             backgroundColor: Colors.white,
// //             toastLength: Toast.LENGTH_SHORT,
// //             gravity: ToastGravity.SNACKBAR,
// //             timeInSecForIosWeb: 1);
// //
// //         Navigator.push(context,
// //             MaterialPageRoute(builder: (context) => HomeBottomScreen()));
// //       } else {
// //         Fluttertoast.showToast(
// //             msg: "Invalid User",
// //             textColor: Colors.white,
// //             backgroundColor: Colors.red,
// //             toastLength: Toast.LENGTH_SHORT,
// //             gravity: ToastGravity.SNACKBAR,
// //             timeInSecForIosWeb: 1);
// //       }
// //     } else {
// //       Navigator.push(
// //           context, MaterialPageRoute(builder: (context) => HomeBottomScreen()));
// //     }
//     return LogoutModel.fromJson(jsonResponse);
//   }
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

  Future<dynamic> UpdateUserAddress(
      String strEmail,
      String strFirstName,
      String strLastName,
      String strPhoneNumber,
      String strAddress,
      String strCity,
      bool isSwitched) async {
    var jsonResponse;
    ProgressDialog pr = new ProgressDialog(context);
    // pr.style(
    //     message: 'Please Wait...',
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

    try {
      String strBaseUrl = Constants.PREFIX_LIVE_URL +
          "index.php?route=endpoint/account/address/edit&address_id=" +
          strAddressID +
          "&secure_token=" +
          strToken!;
      var map = new Map<String, String>();
      map['firstname'] = strFirstName;
      map['lastname'] = strLastName;
      map['email'] = strEmail;
      map['telephone'] = strPhoneNumber;
      map['address_1'] = strAddress;
      map['city'] = strAddress;
      map['postcode'] = "";
      map['country_id'] = strCountryID.toString();
      map['zone_id'] = strZoneID.toString();
      if (isSwitched) {
        map['default'] = "1";
      } else {
        map['default'] = "0";
      }

      // firstname:Update
      // lastname:Another
      // address_1:googele
      // city:null
      // postcode:null
      // country_id:114
      // zone_id:4237
      print("jigar the register parameter is " + map.toString());

      var response = await Dio().post(
        strBaseUrl,
        data: map,
        options: Options(
            followRedirects: false,
            headers: requestHeaders,
            validateStatus: (status) {
              return status !< 500;
            }),
      );
      print("jigar the response registration status we got is " +
          response.statusCode.toString());
      print("jigar the response registration we got is " + response.toString());

      if (response.statusCode.toString() == "302") {
        showSuccessMsg(
           "Address Updated Successfully",
        );
        Navigator.pop(context);
//        var user = loginAuthentication(strEmail, strPassword, context);
//         var user = await loginAuthentication(strEmail, strPassword, context);
//         setLoginAuth(user, strEmail, strPassword);

      } else {
//    var jsonResponse;

        // jsonResponse =
        //     convert.jsonDecode(response.toString()) as Map<String, dynamic>;
      }
      // if (response.body.isNotEmpty) {
      //   jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      // } else {
      //   print("jigar the response else registration we got is " +
      //       response.body.toString());
      // }
      // RegistrationModel registrationModel =
      //     RegistrationModel.fromJson(jsonResponse);

      // print("jigar the loginModel.data.length we got is " +
      //     registrationModel.loggedIn.toString());

      pr.hide();

      // if (registrationModel.loggedIn == null) {
      //   String strMessage = registrationModel.errorMessage;
      //
      //   Fluttertoast.showToast(
      //       msg: strMessage,
      //       textColor: Colors.white,
      //       backgroundColor: Colors.black,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.SNACKBAR,
      //       timeInSecForIosWeb: 1);
      //
      //   if (strMessage.isEmpty) {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => HomeBottomScreen(null)));
      //   }
      //   return RegistrationModel.fromJson(jsonResponse);
      // } else {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => HomeBottomScreen(null)));
      //
      //   String strMessage = registrationModel.headingTitle;
      //
      //   Fluttertoast.showToast(
      //       msg: strMessage,
      //       textColor: Colors.white,
      //       backgroundColor: Colors.black,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.SNACKBAR,
      //       timeInSecForIosWeb: 1);
      // }
    } catch (e) {
      // if (e.response.statusCode == 302) {
      //   showSuccessMsg(
      //
      //           "Address Updated Successfully"); //        print(e.response.statusCode);
      // } else {
      //   // print(e.message);
      //   // print(e.request);
      // }
    }
    return jsonResponse;
  }

  Future<void> setLoginAuth(
      var user, String strUserEmail, String strUserPassword) async {
    print("jigar the response setLoginAuth is  " + user.toString());

    if (user['token_error'] == null) {
      print("jigar the response l_loginMyResponse with new token is  " +
          user.toString());

      SharedPreferences sharedPreferenceManager =
          await SharedPreferences.getInstance();

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

      LoginModel loginModel = LoginModel.fromJson(user);

//                                  if (body['token']?.isNotEmpty == true)
      if (user['code'] == null) {
        if (user['error_warning'] != null) {
          showFailMsg( user['error_warning'].toString());
        } else {
          showFailMsg(
             "Something went wrong,Please try again later",
          );
        }
      } else {
        sharedPreferenceManager.setString(
            Constants.UserDetailsTag.TAG_STORED_USER_NAME, strUserEmail);
        sharedPreferenceManager.setString(
            Constants.UserDetailsTag.TAG_STORED_PASSWORD, strUserPassword);
        print("jigar the we have saved user name " +
            (sharedPreferenceManager
                .getString(Constants.UserDetailsTag.TAG_STORED_USER_NAME)).toString()
        );
        print("jigar the we have saved user password " +
            (sharedPreferenceManager
                .getString(Constants.UserDetailsTag.TAG_STORED_PASSWORD)).toString()
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => homepage(loginModel, false)));
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
          String strUserTokenEmail =
              Constants.TokenDetailsTag.TAG_VALUE_USER_NAME;
          String strUserTokenPassword =
              Constants.TokenDetailsTag.TAG_VALUE_PASSWORD;
          TokenModel _tokenMyResponse = await tokenAuthentication(
              strUserTokenEmail, strUserTokenPassword, context);
          {
            SharedPreferences sharedPreferenceManager =
                await SharedPreferences.getInstance();
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => LoginScreenPage()));

            strToken = _tokenMyResponse.token;
            print("jigar the response new token generated  is  " + strToken!);

            sharedPreferenceManager.setString(
                Constants.TokenDetailsTag.TAG_TOKEN, strToken!);

            // final String strUserEmail =
            // userNameController.text;
            // final String strUserPassword =
            // passwordController.text;

            var _loginMyResponse = await loginAuthentication(
                strUserEmail, strUserPassword, context);

            // var jsonResponse =
            // convert.jsonDecode(_loginMyResponse) as Map<String, dynamic>;

            print("jigar the response l_loginMyResponse with new token is  " +
                _loginMyResponse.toString());
            LoginModel loginModel = LoginModel.fromJson(_loginMyResponse);

            sharedPreferenceManager.setString(
                Constants.UserDetailsTag.TAG_STORED_USER_NAME, strUserEmail);
            sharedPreferenceManager.setString(
                Constants.UserDetailsTag.TAG_STORED_PASSWORD, strUserPassword);
            print("jigar the we have saved user name " +
                (  sharedPreferenceManager
                    .getString(Constants.UserDetailsTag.TAG_STORED_USER_NAME).toString())
                );
            print("jigar the we have saved user password " +
                ( sharedPreferenceManager
                    .getString(Constants.UserDetailsTag.TAG_STORED_PASSWORD)).toString());

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => homepage(loginModel, false)));
            print(
                "jigar the response loginModel.code.toString() with new token is  " +
                    loginModel.code.toString());
          }
        }
      } else {
        print(
            "jigar the response loginGlobalResponse.data lloginGlobalResponse.code " +
                (loginGlobalResponse?.code).toString());
      }
    }
  }

  Future<dynamic> loginAuthentication(
      String strEmail, String strPassword, BuildContext context) async {
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
    print("jigar the response login url status we got is " +
        Constants.LOGIN_URL +
        strToken!);

    final String strBaseUrl = Constants.LOGIN_URL + strToken!;
    var map = new Map<String, dynamic>();
    map['email'] = strEmail;
    map['password'] = strPassword;

    final response = await http.post(Uri.parse(strBaseUrl), body: map);

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    // LoginModel loginModel = LoginModel.fromJson(jsonResponse);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomeBottomScreen()));
    pr.hide();

//     if (loginModel.customerinfo.firstname != null) {
//       if (loginModel.customerinfo.firstname.isNotEmpty) {
// //        String strMessage = loginModel.msg;
//         print("jigar the loginModel.data.length we got is " +
//             loginModel.customerinfo.email);
//         Fluttertoast.showToast(
//             msg: "Hello " + loginModel.customerinfo.firstname,
//             textColor: Colors.red,
//             backgroundColor: Colors.white,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.SNACKBAR,
//             timeInSecForIosWeb: 1);
//
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => HomeBottomScreen()));
//       } else {
//         Fluttertoast.showToast(
//             msg: "Invalid User",
//             textColor: Colors.white,
//             backgroundColor: Colors.red,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.SNACKBAR,
//             timeInSecForIosWeb: 1);
//       }
//     } else {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomeBottomScreen()));
//     }
    return jsonResponse;
  }

  Future<TokenModel> tokenAuthentication(
      String strEmail, String strPassword, BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context);
    // pr.style(
    //     message: 'Please Wait...',
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
    final String strBaseUrl = Constants.TokenDetailsTag.TOKEN_LOGIN;

    var map = new Map<String, dynamic>();
    map[Constants.TokenDetailsTag.TAG_USER_NAME] = strEmail;
    map[Constants.TokenDetailsTag.TAG_PASSWORD] = strPassword;

    final response = await http.post(Uri.parse(strBaseUrl), body: map);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strCookie = response.headers['set-cookie'];
    String ?strPhpid = strCookie?.substring(
        strCookie.indexOf("PHPSESSID") + 10, strCookie.indexOf(";"));
    strCookie = strCookie?.substring(strCookie.indexOf(";"));
    String ?strCurrency = strCookie?.substring(strCookie.indexOf("currency") + 9,
        strCookie.indexOf(";", strCookie.indexOf("currency") + 9));
    String ?strDefault = strCookie?.substring(strCookie.indexOf("default") + 8,
        strCookie.indexOf(";", strCookie.indexOf("default") + 8));
    String? strLanguage = strCookie?.substring(strCookie.indexOf("language") + 9,
        strCookie.indexOf(";", strCookie.indexOf("language") + 9));
    prefs.setString(Constants.TokenDetailsTag.TAG_PHPSESSID, strPhpid!);
    prefs.setString(Constants.TokenDetailsTag.TAG_CURRENCY, strCurrency!);
    prefs.setString(Constants.TokenDetailsTag.TAG_DEFAULT, strDefault!);
    prefs.setString(Constants.TokenDetailsTag.TAG_LANGUAGE, strLanguage!);
    String? strHeader = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);

    final String responseString = response.body;

    print("jigar the response  we got is " + response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return TokenModel.fromJson(jsonResponse);
  }

  Future<dynamic> getShippingAddress() async {
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

      log("jigar the response addAddressModel status we got is " +
          response.body.toString());

      String strRespnse = String.fromCharCodes(response.bodyBytes);
      var user = convert.jsonDecode(strRespnse);
      addAddressModel = AddAddressModel.fromJson(user);

      print("jigar the response addAddressModel.headingTitle we got is " +
          (addAddressModel?.headingTitle).toString()
          );
      setState(() {
        pr.hide();
      });
    } catch (e) {
      // if (e.response.statusCode == 302) {
      //   Fluttertoast.showToast(
      //       msg: "Shipping Address Added Successfully",
      //       textColor: Colors.white,
      //       backgroundColor: Colors.black,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.SNACKBAR,
      //       timeInSecForIosWeb: 1);
      print("jigar the error  response" + e.toString());
    }

    // else {
    // print(e.message);
    // print(e.request);
    // }
  }
}
