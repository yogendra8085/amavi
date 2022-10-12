import 'package:amavinewapp/apicaling/addnewaddress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/AddAddressModel.dart';
import '../Model/CityListModel.dart';
import '../Model/CountryListModel.dart';
import '../Model/LoginModel.dart';
import '../constantpages/colors.dart';

class AddUserAddressScreenPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return AddUserAddressState();
  }

  AddUserAddressScreenPage() {}

}

class AddUserAddressState extends State<AddUserAddressScreenPage> {
  int _counter = 0;
  var _formKey = GlobalKey<FormState>();
  LoginModel ?loginGlobalResponse;
  bool isSwitched = false;
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
  String? strToken;

  String ?_myCountrySelection;
  String? _myAreaSelection;
  String? strCountryName = "";
  String? strAddressLine = "";
  String? strCity = "";
  String ?strCountryID = "0";
  String? strAgree = "1";
  String? strNewsLetter = "1";
  String? strZoneID = "0";
  String? strAddressID = "0";
  String ?strFirstName = "";
  String? strLastName = "";
  String? strEmailID = "";
  String? strTelephoneNumber = "";
  String? strWholeAddress = "";
  String? _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  @override
  void initState() {
    super.initState();
    initController();
    //startTime();
  }




  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _languageCode == Constants.UserDetailsTag.LANG_CODE_EN
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: WillPopScope(
          onWillPop: () async {
            // Do something here
//          print("After clicking the Android Back Button");
            Navigator.pop(context, strWholeAddress);
            return false;
          },
          child: Stack(children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context, strWholeAddress),
//                Navigator.of(context,strWholeAddress).pop(),
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
                                  ? (addAddressModel?.headingTitle).toString()
                                  : _languageCode ==
                                          Constants.UserDetailsTag.LANG_CODE_EN
                                      ? 'Add Address Details'
                                      : 'أضف تفاصيل العنوان',
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: new TextFormField(
                                  controller: userFirstNameController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.appSecondaryColor,
                                    labelText: addAddressModel != null
                                        ? addAddressModel?.entryFirstname
                                        : _languageCode ==
                                                Constants
                                                    .UserDetailsTag.LANG_CODE_EN
                                            ? "Enter First Name"
                                            : 'أدخل الاسم الأول',
                                    errorStyle: TextStyle(fontSize: 15.0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: new TextFormField(
                                  controller: userLastNameController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.black,
                                    labelText: addAddressModel != null
                                        ? addAddressModel?.entryLastname
                                        : _languageCode ==
                                                Constants
                                                    .UserDetailsTag.LANG_CODE_EN
                                            ? "Enter Last Name"
                                            : 'إدخال اسم آخر',
                                    errorStyle: TextStyle(fontSize: 15.0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: new TextFormField(
                                  controller: userEmailIDController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.black,
                                    labelText: addAddressModel != null
                                        ? (addAddressModel?.customFields?[1].name).toString()
                                        : _languageCode ==
                                                Constants
                                                    .UserDetailsTag.LANG_CODE_EN
                                            ? "Enter Email ID"
                                            : 'أدخل معرف البريد الإلكتروني',
                                    errorStyle: TextStyle(fontSize: 15.0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: new TextFormField(
                                  controller: userPhoneNumberController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.black,
                                    labelText: addAddressModel != null
                                        ? (addAddressModel?.customFields?[0].name).toString()
                                        : _languageCode ==
                                                Constants
                                                    .UserDetailsTag.LANG_CODE_EN
                                            ? "Enter Telephone Number"
                                            : 'أدخل رقم الهاتف',
                                    errorStyle: TextStyle(fontSize: 15.0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: new TextFormField(
                                  controller: userAddressController,
                                  decoration: new InputDecoration(
                                    focusColor: AppColors.black,
                                    labelText: addAddressModel != null
                                        ? addAddressModel?.entryAddress1
                                        : _languageCode ==
                                                Constants
                                                    .UserDetailsTag.LANG_CODE_EN
                                            ? "Enter Address"
                                            : 'أدخل العنوان',
                                    errorStyle: TextStyle(fontSize: 15.0),
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
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        border:
                                            Border.all(color: Colors.blueGrey)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: dataCountryList != null
                                          ? dataCountryList.length > 0
                                              ? new DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                        addAddressModel != null
                                                            ? (addAddressModel
                                                                ?.entryCountry).toString()
                                                            : _languageCode ==
                                                                    Constants
                                                                        .UserDetailsTag
                                                                        .LANG_CODE_EN
                                                                ? "Select Country"
                                                                : 'حدد الدولة',
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.black,
                                                        )),
                                                    dropdownColor:
                                                        AppColors.white,
                                                    items: dataCountryList
                                                        .map((item) {
                                                      return new DropdownMenuItem(
                                                        child: new Text(item,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                            )),
                                                        value: item.toString(),
                                                      );
                                                    }).toList(),
                                                    onChanged: ( val) {
                                                      setState(() {
                                                        _myCountrySelection =
                                                            val;
                                                        int strIndex =
                                                            dataCountryList.indexOf(
                                                                _myCountrySelection!);
                                                        strCountryID =
                                                            dataCountryListID[
                                                                    strIndex]
                                                                .toString();
                                                        getCityList(
                                                            strCountryID!);
                                                      });
                                                    },
                                                    value: _myCountrySelection,
                                                    style: new TextStyle(
                                                      color: AppColors.black,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                          : Container(),
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        border:
                                            Border.all(color: Colors.blueGrey)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: new DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          hint: Text(
                                              addAddressModel != null
                                                  ? (addAddressModel?.entryZone).toString()
                                                  : _languageCode ==
                                                          Constants
                                                              .UserDetailsTag
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
                                          }).toList(),
                                          onChanged: (newVal) {
                                            setState(() {
                                              _myAreaSelection = newVal;
                                              int strIndex = dataZoneList
                                                  .indexOf(_myAreaSelection!);
                                              strZoneID =
                                                  dataZoneListID[strIndex];
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

                              ElevatedButton(
                                // padding: const EdgeInsets.fromLTRB(
                                //     70.0, 10.0, 70.0, 10.0),
                                // textColor: Colors.white,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                         70.0, 10.0, 70.0, 10.0),
                                  primary:  AppColors.appSecondaryColor, // background color
                                  onPrimary: Colors.white, // foreground text color
                                  elevation: 3,
                                  disabledForegroundColor: Colors.white,//disble text color
                                  disabledBackgroundColor: Colors.cyan,//disble color
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: AppColors.appSecondaryColor)),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState?.validate()!=null) {
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
                                    final String strCity =
                                        userCityController.text;

                                    var user1 = await addnewaddres(). AddShippingUserAddress(
                                        strUserEmail,
                                        strUserFirstName,
                                        strUserLastName,
                                        strPhoneNumber,
                                        strAddress,
                                        strCity,
                                      context,
                                      strToken,
                                      (_myCountrySelection).toString(),
                                      ( _myAreaSelection).toString(),
                                      (strCountryID).toString(),
                                      (strZoneID).toString(),
                                    );

                                    strWholeAddress = strUserEmail +
                                        ", " +
                                        strUserFirstName +
                                        ", " +
                                        strUserLastName +
                                        ", " +
                                        strPhoneNumber +
                                        ", " +
                                        strAddress +
                                        ", " +
                                        _myAreaSelection! +
                                        ", " +
                                        _myCountrySelection!;
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
                                          ? 'Submit'
                                          : 'يقدم',
                                  style: TextStyle(fontSize: 16),
                                ),

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
          ])),
    );
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

//    var resBody = json.decode(response.body);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var resBody = CountryListModel.fromJson(jsonResponse);

    //    return loginModelFromJson(responseString);
//
//    var res = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//    var resBody = json.decode(res.body);

    setState(() {
      // dataCountryList.add("Select Country");
      // dataCountryListID.add("0");

      for (var i = 0; i < (resBody.countries?.length)!.toInt(); i++) {
        if (_languageCode == Constants.UserDetailsTag.LANG_CODE_EN) {
          dataCountryList.add(
              ( resBody.countries?.elementAt(i).name).toString()
          );
        } else {
          dataCountryList.add(
              (resBody.countries?.elementAt(i).arName).toString()
          );
        }
        dataCountryListID.add(
            (resBody.countries?.elementAt(i).countryId).toString()
        );
      }

      // _myCountrySelection = dataCountryList.first;
    });

    return CountryListModel.fromJson(jsonResponse);
  }

  Future<CityListModel> getCityList(String strCountryID) async {
    final String strBaseUrl = Constants.PREFIX_LIVE_URL +
        "index.php?route=account/account/country&country_id=" +
        strCountryID;

    dataZoneList.clear();
    final response = await http.get(Uri.parse(strBaseUrl));

    final String responseString = response.body;

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var resBody = CityListModel.fromJson(jsonResponse);

    setState(() {
      // dataZoneList.add("Select City");
      // dataZoneListID.add("0");
      for (var i = 0; i < (resBody.zone?.length)!.toInt(); i++) {
        if (_languageCode == Constants.UserDetailsTag.LANG_CODE_EN) {
          dataZoneList.add(
              ( resBody.zone?.elementAt(i).name).toString()
          );
        } else {
          dataZoneList.add(
              ( resBody.zone?.elementAt(i).arName).toString()
          );
        }
        dataZoneListID.add(
            (resBody.zone?.elementAt(i).zoneId).toString()
        );
      }
    });

    _myAreaSelection = dataZoneList.first;

    int strIndex = dataZoneList.indexOf(_myAreaSelection!);
    strZoneID = dataZoneListID[strIndex];

    return CityListModel.fromJson(jsonResponse);
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    getCountryList();
  var resonse=await addnewaddres().getShippingAddress(context,strToken!);
  addAddressModel=AddAddressModel.fromJson(resonse);
    //  logoutUser(context);
    setState(() {});
  }

}
