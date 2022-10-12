import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


import '../Model/SearchAutoResponse.dart';
import '../Model/SearchProductListModel.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';

class SearchListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchListState();
  }
}

class SearchListState extends State<SearchListPage> {
  int pageNumber = 1;
  String ?strAccessToken;
  String? strToken;
  String? strCustomerLanguage;
  SearchAutoResponse? searchAutoResponse;
  SearchProductListModel ?_searchProductListModel;
  TextEditingController _typeAheadController = TextEditingController();
  String ?_selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
    //startTime();
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strCustomerLanguage = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    if (strCustomerLanguage == null) {
      strCustomerLanguage = Constants.UserDetailsTag.LANG_CODE_EN;
    }
    getSuggestionProductList(context, "");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          _searchProductListModel != null
              ? (_searchProductListModel?.buttonSearch).toString()
              : "",
          style: new TextStyle(fontSize: 12, color: AppColors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Form(
//        child: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: double.infinity,
                height: 60,
                child: TypeAheadField(

                  textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      textCapitalization:  TextCapitalization.characters,
                      autofocus: true,
                      style: TextStyle(

                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.normal,
                          color: AppColors.black
                      ),
                      decoration: InputDecoration(
                          labelText: _searchProductListModel != null
                              ? _searchProductListModel?.entrySearch
                              : "",
                          labelStyle: TextStyle(

                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Poppins",
                              fontStyle: FontStyle.normal,
                              color: AppColors.black
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                          ))),
                  suggestionsCallback: (pattern) async {
                    if (pattern.length > 3) {
                      List respons=await getSuggestionList(context, pattern);
                      return respons;
                    }
                    List respons=await getSuggestionList(context, pattern);
                    return respons;
                  },
                  itemBuilder: (context, suggestion) {

                    return ListTile(
                      //leading: Icon(Icons.shopping_cart),
                      title: Text(suggestion['name'].toString()),
                       //   subtitle: Text('\$${suggestion?['price']}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _typeAheadController.text =suggestion['name'].toString();
                    });

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => ProductDetailPage(product: suggestion)
                    // ));
                  },
                )),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: ElevatedButton(
                      // padding:
                      //     const EdgeInsets.fromLTRB(120.0, 10.0, 120.0, 10.0),
                      // textColor: Colors.white,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(
                            120.0, 10.0, 120.0, 10.0),
                        primary: AppColors.appSecondaryOrangeColor,
                        onPrimary: Colors.white,
                        elevation: 3,
                        disabledForegroundColor: Colors.white,
                        disabledBackgroundColor: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            side: BorderSide(
                                color:
                                AppColors.appSecondaryOrangeColor)),

                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        if (_typeAheadController.text != null &&
                            _typeAheadController.text != "") {
                          getSuggestionProductList(
                              context, _typeAheadController.text);
                        } else {}
                      },
                      // disabledTextColor: Colors.white,
                      // color: AppColors.appSecondaryOrangeColor,
                      // elevation: 3,
                      child: Text(
                        _searchProductListModel != null
                            ? (_searchProductListModel?.buttonSearch).toString()
                            : "",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: "Poppins",
                            fontSize: SizeConfig.blockSizeVertical! * 1.9),
                      ),
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(3.0),
                      //     side: BorderSide(
                      //         color: AppColors.appSecondaryOrangeColor)),
                      // disabledColor: Colors.cyan,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.black,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                _searchProductListModel != null
                    ? (_searchProductListModel?.headingTitle).toString()
                    : "",
                style: new TextStyle(color: AppColors.appSecondaryColor),
              ),
            ),
            Container(
                child: Form(
              child: Expanded(
                  //    child:
                  child: _searchProductListModel != null
                      ? _searchProductListModel?.products != null
                          ? (_searchProductListModel?.products?.length)! > 0
                              ? cartProductListView()
                              : SizedBox()
                          : SizedBox()
                      : SizedBox()
                  //    _searchProductListModel != null ? cartProductListView() : Container(),
                  ),
            )),
          ],
        ),
        //    ),
      ),
    );
  }

  Widget cartProductListView() {
    return Padding(
        padding: EdgeInsets.only(top: 2),
        child: LazyLoadScrollView(
//          onEndOfPage: () => getOrderList(context, pageNumber),
          onEndOfPage: () {  },
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    String strURl = (_searchProductListModel?.products?[index].href).toString()
                        .replaceAll("&amp;", "&").replaceAll("&quot;", '"');
                    print("Click event on Container " + strURl);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           ProductDetailPage(strURl, true, null)),
                    // );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        decoration: new BoxDecoration(
                          color: new Color(0xFFFFFFFF),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Material(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          //  child:
                          // : _controller.therapistModel.value.result != null &&
                          // _controller.therapistModel.value.result.length > 0
                          //    ?
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                border: Border.all()),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Flexible(
                                    //     child: Align(
                                    //       alignment: Alignment.topLeft, // A
                                    //       child: Center(
                                    //           child: Padding(
                                    //         padding: const EdgeInsets.all(4.0),
                                    //         child: FadeInImage.memoryNetwork(
                                    //             placeholder: kTransparentImage,
                                    //             image: _searchProductListModel
                                    //                 .products[index].thumb,
                                    //             height: SizeConfig
                                    //                     .blockSizeVertical *
                                    //                 12,
                                    //             width: SizeConfig
                                    //                     .blockSizeHorizontal *
                                    //                 24.0,
                                    //             fit: BoxFit.fill,
                                    //             imageErrorBuilder:
                                    //                 (BuildContext context,
                                    //                     Object exception,
                                    //                     StackTrace stackTrace) {
                                    //               return Image.asset(
                                    //                 'assets/images/app_icon.png',
                                    //                 height: SizeConfig
                                    //                         .blockSizeVertical *
                                    //                     12.0,
                                    //                 width: SizeConfig
                                    //                         .blockSizeHorizontal *
                                    //                     11.0,
                                    //               );
                                    //             }),
                                    //
                                    //         // Image.network(productModel.thumb,
                                    //         // fit: BoxFit.fill, width: 160, height: 135),
                                    //       )),
                                    //     ),
                                    //     flex: 1),
                                    Image.network(( _searchProductListModel
                                                     ?.products?[index].thumb).toString(),
                                        height: SizeConfig
                                                          .blockSizeVertical! *
                                                      12,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal! *
                                                      24.0,
                                                  fit: BoxFit.fill,



                                    ),
                                    Flexible(
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              // A
                                              child: Text(
                                                ( _searchProductListModel
                                                    ?.products?[index].name).toString().replaceAll("&amp;", "&").replaceAll("&quot;", '"'),
                                                style: TextStyle(
                                                  color: AppColors
                                                      .appSecondaryOrangeColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "Poppins",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical !*
                                                      1.6,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              // A
                                              child: Text(
                                                (_searchProductListModel
                                                    ?.products?[index]
                                                    .description).toString(),
                                                maxLines: 4,
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "Poppins",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical! *
                                                      1.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        flex: 3),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // : noDataView(true),
                        ),
                      )));
            },
            itemCount:
            _searchProductListModel?.products?.length
                ,
          ),
        ));
  }

  Future<dynamic> getSuggestionList(
      BuildContext context, String strSearchValue) async {
    try{


    print(
        "jigar the strSearchValue page number is " + strSearchValue.toString());

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

    strBaseUrl = Constants.GET_SEARCH_LIST_URL +
        strToken! +
        "&searchValue=" +
        strSearchValue;
    print("jigar the response url is we got is " + strBaseUrl);

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    print("jigar the response response.toString() we got is " +
        response.body.toString());
    if (response.body.toString() != "[]") {
//      var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //    print("jigar the response user.toString() we got is " + user.toString());
      // var usersDataFromJson = parsedJson['data'];
//      List<String> userData = List<String>.from(usersDataFromJson);
      List xs = convert.jsonDecode(response.body)
          as List<dynamic>; //response.body[0];
      //    searchAutoResponse = SearchAutoResponse.fromJson(response.body);
      print("jigar the response xs[0].name.toString() is " + xs[0].toString());

      // strFirstName = accountDetailsModel.firstname.sentenceCase;
      // strLastName = accountDetailsModel.lastname.sentenceCase;
      // strEmailID = accountDetailsModel.email;
      // strPhoneNumber = accountDetailsModel.telephone;
      //
      // if (accountDetailsModel.addresses.length > 0) {
      //   strAddress = accountDetailsModel.addresses[0].address;
      // }
      setState(() {});
      //pr.hide();

      return xs;
    } else {
      //  pr.hide();
      return [];
    }
    // LoginModel loginModel = LoginModel.fromJson(jsonResponse);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomeBottomScreen()));

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
    }catch (e){
      print("message ==>  $e");
    }
  }

  Future<dynamic> getSuggestionProductList(
      BuildContext context, String strSearchValue) async {
    ProgressDialog pr = new ProgressDialog(context);
    try {
      print("jigar the strSearchValue page number is " +
          strSearchValue.toString());

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

      if (strSearchValue != "") {
        strBaseUrl = Constants.GET_SEARCH_PRODUCT_LIST_URL +
            strToken! +
            "&search=" +
            strSearchValue +
            "&sub_category=true&description=true&limit=25&customer_language=" +
            strCustomerLanguage!;
      } else {
        strBaseUrl = Constants.GET_SEARCH_PRODUCT_LIST_URL +
            strToken! +
            "&customer_language=" +
            strCustomerLanguage!;
      }
      print("jigar the response url is we got is " + strBaseUrl);
      final response =
          await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);
      print("jigar the response sarch product list is response.toString() we got is " +
          response.body.toString());
      if (response.body.toString() != "[]") {
        var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
        _searchProductListModel = SearchProductListModel.fromJson(user);
        setState(() {});
        pr.hide();

        return "";
      } else {
        pr.hide();
        return [];
      }
    } catch (e) {
      pr.hide();
      print("message   ==>  $e");
    }
  }
}
