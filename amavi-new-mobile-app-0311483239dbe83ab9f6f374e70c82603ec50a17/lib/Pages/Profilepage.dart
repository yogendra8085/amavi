import 'package:amavinewapp/Model/AccountListModel.dart';
import 'package:amavinewapp/Model/AddressBookModel.dart';
import 'package:amavinewapp/apicaling/accountdetaisapicallimg.dart';
import 'package:amavinewapp/apicaling/adressapicalling.dart';
import 'package:amavinewapp/apicaling/deleteaddressapicalling.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/AccountDetailsModel.dart';
import '../Model/TokenModel.dart';
import '../constantpages/colors.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';
import 'add_new_user_address_page.dart';
import 'edit_address_page.dart';

class profilepage extends StatefulWidget {
  const profilepage({super.key});

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  String ?strToken;
  String ?strLangCode;
  AccountDetailsModel? accountDetailsModel;
  AddressBookModel ?addressBookModel;
  AccountListModel? accountListModel;
  String rediovalue = "";
  @override
  void initState() {
   initController();
    super.initState();

  }
  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strLangCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    // setState(() {
    //
    // });
   var response=await accountdetailsapicaling(strToken).getAccountDetails(context);
   accountDetailsModel=AccountDetailsModel.fromJson(response);
   // setState(() {
   //
   // });

    // getAccountDetails(context);
   var respnse1=await  adressapicalling(strToken). getAddressDetails(context);
   addressBookModel=AddressBookModel.fromJson(respnse1);
   accountListModel=AccountListModel.fromJson(respnse1);

     setState(() {
       for (int i = 0; i < (accountListModel?.addresses?.length)!.toInt(); i++) {
         if (accountListModel?.addresses?[i].defaults == 1) {
           rediovalue = (accountListModel?.addresses?[i].addressId).toString();
         }
       }
     });
  // });
    // getCartListDetails(context);
    //refresh();
  }
  Future<void> _getData() async {
    var respnse1=await  adressapicalling(strToken). getAddressDetails(context);
    setState(()  {

      addressBookModel=AddressBookModel.fromJson(respnse1);
      accountListModel=AccountListModel.fromJson(respnse1);
    });
  }
  @override
  Widget build(BuildContext context) {
    print(accountDetailsModel?.entryEmail.toString());
    print(addressBookModel?.firstname.toString());
    print(accountListModel?.addresses?[0].address.toString());
    return Scaffold(
      body:accountDetailsModel==null||addressBookModel==null?Center(child: CircularProgressIndicator(),) :SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text( accountDetailsModel != null
                  ? (accountDetailsModel?.headingTitle).toString()
                  : 'My Account', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontFamily: "Poppins",
          fontSize: 23,
        ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Align(
                alignment: strLangCode ==
                    Constants.UserDetailsTag.LANG_CODE_AR
                    ? Alignment.topRight
                    : Alignment.topLeft, // A
                child: Text(
                  (addressBookModel?.firstname).toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        16.0, 0.0, 8.0, 8.0),
                    child: Align(
                      alignment: strLangCode ==
                          Constants.UserDetailsTag.LANG_CODE_AR
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: new InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             ChangePasswordScreenPage()));
                        },
                        child: Text(
                          accountDetailsModel != null
                              ? (accountDetailsModel?.textPassword).toString()
                              :

                                    'Change Password',
                          style: TextStyle(
                            color:
                            AppColors.appSecondaryOrangeColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins",
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          8.0, 0.0, 16.0, 8.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         OrderHistoryListPage(),
                          //   ),
                          // );
                        },
                        child: Align(
                          alignment: strLangCode ==
                              Constants
                                  .UserDetailsTag.LANG_CODE_AR
                              ? Alignment.topLeft
                              : Alignment.topRight, // A
                          child: Text(
                            accountDetailsModel != null
                                ? (accountDetailsModel?.textOrder).toString()
                                :

                            "Viwe Your Order history",
                            style: TextStyle(
                              color:
                              AppColors.appSecondaryOrangeColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )),
                  flex: 3,
                ),
              ],
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              clipBehavior: Clip.antiAlias,
              semanticContainer: false,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Text(
                                accountDetailsModel != null
                                    ? (accountDetailsModel?.textMyAccount).toString()
                                    :
                                'My Account',
                                //'Account Details',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         EditNameScreenPage(
                              //             addressBookModel),
                              //   ),
                              // ).then((value) {
                              //   getAddressDetails(context);
                              // });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: strLangCode ==
                                    Constants
                                        .UserDetailsTag.LANG_CODE_AR
                                    ? Alignment.topLeft
                                    : Alignment.topRight, // A
                                child: Text(
                                  accountDetailsModel != null
                                      ? (accountDetailsModel?.textEdit).toString()
                                      :
                                  'Edit',
                                  style: TextStyle(
                                    color:
                                    AppColors.appSecondaryOrangeColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                      child: Divider(
                        color: AppColors.appSecondaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Text(
                                accountDetailsModel != null
                                    ? (accountDetailsModel?.entryFirstname).toString()
                                    :
                                'First Name*',
                                style: TextStyle(
                                  color:
                                  AppColors.appSecondaryOrangeColor,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Text(
                                accountDetailsModel != null
                                    ? (accountDetailsModel?.entryLastname).toString()
                                    :
                                'Last Name*',
                                style: TextStyle(
                                  color:
                                  AppColors.appSecondaryOrangeColor,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 1.0, 8.0, 8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topRight
                                  : Alignment.topLeft, // A
                              child: Text(
                                  (addressBookModel?.firstname).toString(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 1.0, 8.0, 8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Text(
                                (addressBookModel?.lastname).toString(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Text(
                                // accountDetailsModel != null
                                //     ? accountDetailsModel.entryTelephone
                                //     :
                                'Phone',
                                style: TextStyle(
                                  color:
                                  AppColors.appSecondaryOrangeColor,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 1.0, 8.0, 8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Text(
                                // accountDetailsModel != null
                                //     ? accountDetailsModel.entryEmail
                                //     :
                                'Email*',
                                style: TextStyle(
                                  color:
                                  AppColors.appSecondaryOrangeColor,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 1.0, 8.0, 8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: Text(
                                  (addressBookModel?.telephone).toString(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                8.0, 1.0, 8.0, 8.0),
                            child: Align(
                              alignment: strLangCode ==
                                  Constants
                                      .UserDetailsTag.LANG_CODE_AR
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Text(
    (addressBookModel?.email).toString(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              clipBehavior: Clip.antiAlias,
              semanticContainer: false,
              // child: IntrinsicHeight
              //   (
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: strLangCode ==
                                Constants.UserDetailsTag.LANG_CODE_AR
                                ? Alignment.topRight
                                : Alignment.topLeft, // A
                            child: Text(
                              // accountDetailsModel != null
                              //     ? accountDetailsModel.textAddress
                              //     : '',
                              'Adress Book',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Align(
                      //       alignment: strLangCode ==
                      //           Constants.UserDetailsTag.LANG_CODE_AR
                      //           ? Alignment.topLeft
                      //           : Alignment.topRight,
                      //       child: InkWell(
                      //         onTap: () {
                      //           // Navigator.push(
                      //           //   context,
                      //           //   MaterialPageRoute(
                      //           //     builder: (context) =>
                      //           //         AddressListPage(),
                      //           //   ),
                      //           // ).then((value) {
                      //           //   getAddressDetails(context);
                      //           // });
                      //         },
                      //         child: Text(
                      //           accountDetailsModel != null
                      //               ? (accountDetailsModel?.textEdit).toString()
                      //               :
                      //              "Text Edit",
                      //           style: TextStyle(
                      //             color:
                      //             AppColors.appSecondaryOrangeColor,
                      //             fontWeight: FontWeight.bold,
                      //             fontFamily: "Poppins",
                      //             fontSize: 18,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   flex: 2,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: strLangCode ==
                              Constants.UserDetailsTag.LANG_CODE_AR
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddUserAddressScreenPage(),
                                ),
                              ).then((value) {
                                adressapicalling(strToken).getAddressDetails(context);
                                initController();
                              });
                            },
                            child: Text(
                              accountListModel != null
                                  ?(accountListModel?.buttonNewAddress).toString()
                                  :
                              'Bottom address',
                              style: TextStyle(
                                color: AppColors.appSecondaryOrangeColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding:
                  //   const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  //   child: Divider(
                  //     color: AppColors.appSecondaryColor,
                  //   ),
                  // ),

                  // accountListModel != null
                  //     ? addressListView()
                  //     : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: Divider(
                      color: AppColors.appSecondaryColor,
                    ),
                  ),
                  accountListModel != null ?addrelistviwe1() : Container(),
                ],
              ),
              //   ),
            ),
          ],
        ),
      ),
    );

  }
 Widget addrelistviwe1(){
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 20),
      child: RefreshIndicator(
        onRefresh: _getData,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),

          scrollDirection: Axis.vertical,
          shrinkWrap: true,
//        physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                child: Material(
                  elevation: 2.0,
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child:
                  // : _controller.therapistModel.value.result != null &&
                  // _controller.therapistModel.value.result.length > 0
                  //    ?
                  new InkWell(
                    onTap: () {
//                    "Update Another<br />googele<br />UAE 121212<br />Abdullah Al-Salem<br />Kuwait",
//                       String str = accountListModel.addresses[index].address;
//                       final startIndex = str.lastIndexOf("<br />");
// //                    final endIndex = str.indexOf(end, startIndex + start.length);
//
//                       final endIndexAddress = str.indexOf("<br />");
//                       String strAddress = str.substring(0, endIndexAddress);
//                       String strSecondString = str.substring(
//                           endIndexAddress + 6,
//                           accountListModel.addresses[index].address.length);
//
//                       print("jigar the strAddress name is " + strAddress);
//                       print("jigar the strSecondString  is " + strSecondString);
//
//                       final endIndexSecondAddress =
//                       strSecondString.indexOf("<br />");
//                       String strSecondAddress =
//                       strSecondString.substring(0, endIndexSecondAddress);
//                       String strThirdString = strSecondString.substring(
//                           endIndexSecondAddress + 6, strSecondString.length);
//                       print("jigar the strSecondAddress name is " +
//                           strSecondAddress);
//                       print("jigar the strThirdString  is " + strThirdString);
//
//                       final endIndexThirdAddress =
//                       strThirdString.indexOf("<br />");
//                       String strAddressLine =
//                       strThirdString.substring(0, endIndexThirdAddress);
//                       print(
//                           "jigar the strAddressLine name is " + strAddressLine);
//
//                       // String strFourthString=strThirdString.substring(endIndexThirdAddress+6,strThirdAddress.length);
//                       // print("jigar the strFourthString  is "+strFourthString);
//
//                       print("jigar the country name is " +
//                           str.substring(
//                               startIndex + 6,
//                               accountListModel
//                                   .addresses[index].address.length));
//
//                       String strCountryName = str.substring(startIndex + 6,
//                           accountListModel.addresses[index].address.length);
//                       // String strFirstName = accountListModel.firstname;
//                       // String strLastName = accountListModel.lastname;
//                       // String strEmailID = accountListModel.email;
//                       String strTelephoneNumber = accountListModel.telephone;
//                       String strCity = str.substring(
//                           str
//                               .substring(0, str.lastIndexOf("<br />"))
//                               .lastIndexOf("<br />") +
//                               6,
//                           str.lastIndexOf("<br />"));
//                       // print("jigar the strCity name is " + strCity);
//
//                       // Navigator.push(
//                       //     context,
//                       //
//                       //     MaterialPageRoute(
//                       //         builder: (context) => EditAddressScreenPage(
//                       //             accountListModel.addresses[index].addressId,strFirstName,
//                       //         strLastName,strEmailID,strTelephoneNumber,strCountryName,strCity,strAddressLine).then((value) {
//                       //           getAccountDetails(context);
//                       //         })
//                       //     ));
//
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditAddressScreenPage(
//                               accountListModel.addresses[index].addressId,
//                               strAddress,
//                               strSecondAddress,
//                               strEmailID,
//                               strTelephoneNumber,
//                               strCountryName,
//                               strCity,
//                               strAddressLine),
//                         ),
//                       ).then((value) {
//                         getAccountDetails(context);
//                       });
                    },
                    child: Container(

//                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Colors.blueAccent)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  accountListModel?.addresses?[index].defaults ==
                                      1
                                      ? Radio(
                                      value: accountListModel
                                          ?.addresses?[index].addressId,
                                      groupValue: rediovalue,
                                      activeColor:
                                      AppColors.appSecondaryOrangeColor,
                                      onChanged: (value) {
                                        setState(() {
                                          rediovalue = value!;
                                        });
                                        print(value); //selected value
                                      })
                                      : Container(),
                                  accountListModel?.addresses?[index].defaults ==
                                      1
                                      ? Container()
                                      : Row(
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            String? str = accountListModel
                                                ?.addresses?[index].address;
                                            final startIndex =
                                            str?.lastIndexOf("<br />");
//                    final endIndex = str.indexOf(end, startIndex + start.length);

                                            final endIndexAddress =
                                            str?.indexOf("<br />");
                                            String strAddress =
                                            (str?.substring(
                                                0, endIndexAddress)).toString();
                                            String strSecondString =
                                            (str?.substring(
                                                endIndexAddress !+ 6,
                                                accountListModel
                                                    ?.addresses?[index]
                                                    .address
                                                    ?.length)).toString();

                                            print(
                                                "jigar the strAddress name is " +
                                                    strAddress);
                                            print(
                                                "jigar the strSecondString  is " +
                                                    strSecondString);

                                            final endIndexSecondAddress =
                                            strSecondString
                                                .indexOf("<br />");
                                            String strSecondAddress =
                                            strSecondString.substring(
                                                0,
                                                endIndexSecondAddress);
                                            String strThirdString =
                                            strSecondString.substring(
                                                endIndexSecondAddress +
                                                    6,
                                                strSecondString
                                                    .length);
                                            print(
                                                "jigar the strSecondAddress name is " +
                                                    strSecondAddress);
                                            print(
                                                "jigar the strThirdString  is " +
                                                    strThirdString);

                                            final endIndexThirdAddress =
                                            strThirdString
                                                .indexOf("<br />");
                                            String strAddressLine =
                                            strThirdString.substring(
                                                0,
                                                endIndexThirdAddress);
                                            print(
                                                "jigar the strAddressLine name is " +
                                                    strAddressLine);

                                            // String strFourthString=strThirdString.substring(endIndexThirdAddress+6,strThirdAddress.length);
                                            // print("jigar the strFourthString  is "+strFourthString);

                                            print(
                                                "jigar the country name is " +
                                                    (str?.substring(
                                                        startIndex! + 6,
                                                        accountListModel
                                                            ?.addresses?[
                                                        index]
                                                            .address
                                                            ?.length)).toString());

                                            String strCountryName =
                                            (str?.substring(
                                                startIndex! + 6,
                                                accountListModel
                                                    ?.addresses?[
                                                index]
                                                    .address
                                                    ?.length)).toString();
                                            // String strFirstName = accountListModel.firstname;
                                            // String strLastName = accountListModel.lastname;
                                            // String strEmailID = accountListModel.email;
                                            String? strTelephoneNumber =
                                                accountListModel
                                                    ?.telephone;
                                            String strCity =( str?.substring(
                                                str
                                                    .substring(
                                                    0,
                                                    str.lastIndexOf(
                                                        "<br />"))
                                                    .lastIndexOf(
                                                    "<br />") +
                                                    6,
                                                str.lastIndexOf(
                                                    "<br />"))).toString();
                                            // print("jigar the strCity name is " + strCity);

                                            // Navigator.push(
                                            //     context,
                                            //
                                            //     MaterialPageRoute(
                                            //         builder: (context) => EditAddressScreenPage(
                                            //             accountListModel.addresses[index].addressId,strFirstName,
                                            //         strLastName,strEmailID,strTelephoneNumber,strCountryName,strCity,strAddressLine).then((value) {
                                            //           getAccountDetails(context);
                                            //         })
                                            //     ));

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditAddressScreenPage(
                                                        (accountListModel
                                                            ?.addresses?[
                                                        index]
                                                            .addressId).toString(),
                                                        strAddress,
                                                        strSecondAddress,
                                                        (accountListModel?.email).toString(),
                                                        (strTelephoneNumber).toString(),
                                                        strCountryName,
                                                        strCity,
                                                        strAddressLine),
                                              ),
                                            ).then((value) {

                                              initController();
                                              adressapicalling(strToken).getAddressDetails(context);

                                            });
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.edit,
                                              color: AppColors
                                                  .appSecondaryOrangeColor,
                                            ),
                                          )),
                                      InkWell(
                                          onTap: () async {
                                            await deleteaddres().deletaddress(
                                                ( accountListModel
                                                    ?.addresses?[index]
                                                    .addressId).toString(),strToken).then((value){
                                                      initController();
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: AppColors
                                                  .appSecondaryOrangeColor,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 1.0, 8.0, 8.0),
                                child: Align(
                                  alignment: Alignment.topLeft, // A
                                  child: Html(
                                    data: "<b>" +
                                        (accountListModel
                                            ?.addresses?[index].address).toString() +
                                        "</b>",
                                  ),
                                ),
                              ),

                            ])),
                  ),
                  // : noDataView(true),
                ),
              ),
            );
          },
          itemCount: accountListModel?.addresses?.length,
        ),
      ),
    );
  }
}
