

import 'dart:developer';

import 'package:amavinewapp/apicaling/ragisterapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/CityListModel.dart';
import '../Model/CountryListModel.dart';
import '../Model/LoginModel.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constantpages/colors.dart';

class ragisterpage extends StatefulWidget {
  String? emailId;

  ragisterpage( {this.emailId});


  @override
  State<ragisterpage> createState() => _ragisterpageState();
}

class _ragisterpageState extends State<ragisterpage> {
  var _formKey = GlobalKey<FormState>();
  LoginModel? loginGlobalResponse;

  final TextEditingController userFirstNameController = TextEditingController();
  final TextEditingController userLastNameController = TextEditingController();
   TextEditingController userEmailIDController = TextEditingController();
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
  String? strToken;

  String? _myCountrySelection;
  String? _myAreaSelection;
  String? strCountryName = "";
  String? strCountryID = "0";
  String? strAgree = "1";
  String? strNewsLetter = "1";
  String? strZoneID = "0";
  ProgressDialog? pr;
  String _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  @override
  void initState() {
    super.initState();

    userEmailIDController.text = widget.emailId!;
    log("message  EmailId ===>   ${widget.emailId}");
    this.getCountryList();
    initController();
    pr = new ProgressDialog(context);
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE)!;
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _languageCode == Constants.UserDetailsTag.LANG_CODE_EN
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Stack(children: <Widget>[
        Image.asset(
          "assets/images/splash_intro_blank.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                  // ignore: unnecessary_new
                  new Container(


                      child: Form(
                        key: _formKey,
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(28, 40, 40, 28.0),
                                child: Image.asset(
                                    'assets/images/app_text_logo.png',
                                    height: 50,
                                    fit: BoxFit.fill),
                              ),

                              SizedBox(
                                height: 5,
                              ),

                              // ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 1),
                                child: Center(
                                  child: Text(
                                    _languageCode ==
                                        Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Social Login"
                                        : "تسجيل الدخول الاجتماعي",
                                    style: TextStyle(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: new TextFormField(
                                  controller: userFirstNameController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.appSecondaryColor,
                                    labelText: _languageCode ==
                                        Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter First Name"
                                        : 'الاسم الأول',
                                    errorStyle: TextStyle(fontSize: 15.0),
                                    labelStyle: TextStyle(color: AppColors.black),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
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
                                    labelText: _languageCode ==
                                        Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Last Name"
                                        : ' اسم آخر',
                                    errorStyle: TextStyle(fontSize: 15.0),
                                    labelStyle: TextStyle(color: AppColors.black),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
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
                                  onChanged: (value){
                                    userEmailIDController.text=value;
                                  },
                                 // readOnly: true,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.black,
                                    labelText: _languageCode ==
                                        Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Email ID"
                                        : 'البريد الإلكتروني',
                                    errorStyle: TextStyle(fontSize: 15.0),
                                    labelStyle: TextStyle(color: AppColors.black),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
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
                                    labelText: _languageCode ==
                                        Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Telephone Number"
                                        : ' رقم الهاتف',
                                    errorStyle: TextStyle(fontSize: 15.0),
                                    labelStyle: TextStyle(color: AppColors.black),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
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
                                    labelText: _languageCode ==
                                        Constants.UserDetailsTag.LANG_CODE_EN
                                        ? "Enter Address"
                                        : ' العنوان',
                                    errorStyle: TextStyle(fontSize: 15.0),
                                    labelStyle: TextStyle(color: AppColors.black),
                                    fillColor: Colors.grey,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(4.0),
                                      borderSide:
                                      new BorderSide(color: Colors.grey),
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
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                                              _languageCode ==
                                                  Constants.UserDetailsTag
                                                      .LANG_CODE_EN
                                                  ? "Select Country"
                                                  : ' الدولة',
                                              style: TextStyle(
                                                color: AppColors.black,
                                              )),
                                          dropdownColor: AppColors.white,
                                          items: dataCountryList.map((item) {
                                            return new DropdownMenuItem(
                                              child: Directionality(
                                                textDirection: _languageCode ==
                                                    Constants.UserDetailsTag
                                                        .LANG_CODE_EN
                                                    ? TextDirection.ltr
                                                    : TextDirection.rtl,
                                                child: Row(
                                                  children: [
                                                    new Text(item,
                                                        style: TextStyle(
                                                          color: AppColors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              value: item.toString(),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              _myCountrySelection = val;
                                              int strIndex =
                                              dataCountryList.indexOf(
                                                  _myCountrySelection ?? "");
                                              strCountryID =
                                                  dataCountryListID[strIndex]
                                                      .toString();
                                              getCityList(strCountryID ?? "");
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
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                                              _languageCode ==
                                                  Constants.UserDetailsTag
                                                      .LANG_CODE_EN
                                                  ? "Select Area"
                                                  : ' المنطقة',
                                              style: TextStyle(
                                                color: AppColors.black,
                                              )),
                                          dropdownColor: AppColors.white,
                                          items: dataZoneList.map((item) {
                                            return new DropdownMenuItem(
                                              child: Directionality(
                                                textDirection: _languageCode ==
                                                    Constants.UserDetailsTag
                                                        .LANG_CODE_EN
                                                    ? TextDirection.ltr
                                                    : TextDirection.rtl,
                                                child: Row(
                                                  children: [
                                                    Text(item,
                                                        style: TextStyle(
                                                          color: AppColors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              value: item.toString(),
                                            );
                                          }).toList(),
                                          onChanged: (newVal) {
                                            setState(() {
                                              _myAreaSelection = newVal;
                                              int strIndex = dataZoneList
                                                  .indexOf(_myAreaSelection ?? "");
                                              strZoneID = dataZoneListID[strIndex];
                                              // getCityList(strId);
                                            });
                                          },
                                          value: _myAreaSelection,
                                          style: new TextStyle(
                                            color: AppColors.black,
                                            fontFamily: "Poppins",
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: new TextFormField(
                              //     controller: userCityController,
                              //     decoration: new InputDecoration(
                              //       errorStyle: TextStyle(fontSize: 15.0),
                              //
                              //       focusColor: AppColors.black,
                              //       labelText: _languageCode ==
                              //               Constants.UserDetailsTag.LANG_CODE_EN
                              //           ? "Enter city name"
                              //           : 'أدخل اسم المدينة',
                              //       labelStyle: TextStyle(color: AppColors.black),
                              //       fillColor: Colors.grey,
                              //       border: new OutlineInputBorder(
                              //         borderRadius: new BorderRadius.circular(4.0),
                              //         borderSide:
                              //             new BorderSide(color: Colors.grey),
                              //       ),
                              //       //fillColor: Colors.green
                              //     ),
                              //     validator: (val) {
                              //       if (val.length == 0) {
                              //         return "City name cannot be empty";
                              //       } else {
                              //         return null;
                              //       }
                              //     },
                              //     keyboardType: TextInputType.emailAddress,
                              //     style: new TextStyle(
                              //       color: Colors.black,
                              //       fontFamily: "Poppins",
                              //     ),
                              //   ),
                              // ),

                              ElevatedButton(
                                // padding: const EdgeInsets.fromLTRB(
                                //     120.0, 10.0, 120.0, 10.0),
                                // textColor: Colors.white,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                      120.0, 10.0, 120.0, 10.0),
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
                                  if (_formKey.currentState!.validate()) {
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
                                    var user1 = await ragisterapi(strToken,strAgree,strCountryID,strZoneID,strNewsLetter,context).SignUpUser(
                                      strUserEmail,
                                      strUserFirstName,
                                      strUserLastName,
                                      strPhoneNumber,
                                      strAddress,
                                      strCity,
                                    );
                                  }
                                },
                                child:Text("Ragister")
                                ,

                              ),
                              SizedBox(height: 30),
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

//       var map = new Map<String, dynamic>();
// //  map['email'] = "test3@afrovasresearch.com";
// //  map['pwd'] = "OpinionSpace2020";
// //    map['email'] = strEmail;
// //    map['pwd'] = strPassword;
//       Map<String, String> headers = <String, String>{
//         'http-os-id': 'web',
//         'http-os-user-id': 'spmapiusr_web&6589',
//         'http-os-user-pwd': 'spmapipwd_&666web',
//         'data-format': 'j'
//       };

//  final msg = jsonEncode({"email":"test3@afrovasresearch.com","pwd":"OpinionSpace2020"});

    final response = await http.get(Uri.parse(strBaseUrl));

    final String responseString = response.body;

    print("jigar the response status we got is " +
        response.statusCode.toString());
    log("jigar the response we got is " + response.body.toString());
//    var resBody = json.decode(response.body);
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    var resBody = CountryListModel.fromJson(jsonResponse);

    //    return loginModelFromJson(responseString);
//
//    var res = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    var resBody = json.decode(res.body);
    // ignore: prefer_interpolation_to_compose_strings
    print("jigar the data elementAt we zone got is " +
        (resBody.countries?.elementAt(0).name).toString());
    setState(() {
      for (var i = 0; i < resBody.countries!.length; i++) {
        print("jigar the data elementAt loop we got is " +
            (resBody.countries?.elementAt(i).name).toString());
        if (_languageCode == Constants.UserDetailsTag.LANG_CODE_EN) {
          dataCountryList
              .add((resBody.countries?.elementAt(i).name).toString());
        } else {
          dataCountryList
              .add((resBody.countries?.elementAt(i).arName).toString());
        }
        dataCountryListID
            .add((resBody.countries?.elementAt(i).countryId).toString());
//        if (i == 0) {
//          //data.add("Select Country");
//        }
        //  data.add(resBody.data.elementAt(i).countryName);
      }
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
        (resBody.zone?.elementAt(0).name).toString());
    setState(() {
      for (var i = 0; i < resBody.zone!.length; i++) {
        print("jigar the data elementAt loop we got is " +
            (resBody.zone?.elementAt(i).name).toString());

        if (_languageCode == Constants.UserDetailsTag.LANG_CODE_EN) {
          dataZoneList.add((resBody.zone?.elementAt(i).name).toString());
        } else {
          dataZoneList.add((resBody.zone?.elementAt(i).arName).toString());
        }
        dataZoneListID.add((resBody.zone?.elementAt(i).zoneId).toString());
//        if (i == 0) {
//          //data.add("Select Country");
//        }
        //  data.add(resBody.data.elementAt(i).countryName);
      }
//        this.getCountryName();
    });

//    print(resBody);

    return CityListModel.fromJson(jsonResponse);
  }

}
