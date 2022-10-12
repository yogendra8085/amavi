import 'dart:developer';

import 'package:amavinewapp/Pages/homepage.dart';
import 'package:amavinewapp/Pages/loginpage.dart';
import 'package:amavinewapp/Pages/search_product_page.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/CartListModel.dart';
import '../Model/CategoryListModel.dart';
import '../Model/TokenModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';

class CategoryListPage extends StatefulWidget {
  String? strCategoryID;
  String? strCategoryName;
  int ?intIndex;
  CategoryListPage(this.strCategoryID,this.strCategoryName,this.intIndex);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryListState(strCategoryID, strCategoryName, intIndex);
  }



}

class CategoryListState extends State<CategoryListPage> {
  int? pageNumber = 1;
  String? strAccessToken;
  String? strCategoryID;
  String ?strCategoryName = "";
  String ?strToken;
  CategoryListModel ?categoryListModel;
  CartListModel? cartListModel;
  int ?intIndex;

  String ?_mySortSelection;

  //int intIndex;
  var _formKey = GlobalKey<FormState>();
  String _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  // CategoryListState(String strID, String strName, int index) {
  //   // intIndex = index;
  //  String strCategoryID = strID;
  //  String strCategoryName = strName;
  // }
  CategoryListState(this.strCategoryID,this.strCategoryName,this.intIndex);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
    //startTime();
  }

  Future<CartListModel?> getCartListDetails(BuildContext context) async {
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

    strBaseUrl = Constants.GET_CART_LIST_URL + "&secure_token=" + strToken!;

    // print("jigar the response url is we got is " + strBaseUrl);

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    // print("jigar the response account status we got is " +
    //     response.statusCode.toString());
    // print("jigar the response account we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    // print("jigar the response user.toString() we got is " + user.toString());
    // print("jigar the response user['products'] () we got is " +
    //     user['products'].toString());

    if (user['products'] != null) {
      // var jsonResponse =
      //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;

      //if (pageNumber == 1)
      {
        cartListModel = CartListModel.fromJson(user);
        //    strHeading = cartListModel.headingTitle;
      }
      //else {
//          cartListModel.rewards.addAll(cartListModel.fromJson(user));
//          user['orders'].forEach((v) { cartListModel..add(new Orders.fromJson(v)); });
      //}
      //
      // print(
      //     "jigar the response get cart list cartListModel.product length is " +
      //         cartListModel.products.length.toString());
      // print("jigar the response new count is cartListModel.textCount " +
      //     cartListModel.textCount.toString());
      //intAddQuantity = List.filled(cartListModel.products.length, 0);

      // strFirstName = accountDetailsModel.firstname.sentenceCase;
      // strLastName = accountDetailsModel.lastname.sentenceCase;
      // strEmailID = accountDetailsModel.email;
      // strPhoneNumber = accountDetailsModel.telephone;
      //
      // if (accountDetailsModel.addresses.length > 0) {
      //   strAddress = accountDetailsModel.addresses[0].address;
      // }
      setState(() {
        Constants.strCartCount = (cartListModel?.textCount)!.toInt();
      });

      return cartListModel;
    } else {
      setState(() {
        cartListModel = CartListModel.fromJson(user);

        // strHeading = cartListModel.headingTitle;
        // strErrorMessage = user['text_error'];

        // print("jigar the else part with no products info");
        // print("jigar the else part with no cartListModel.headingTitle info" +
        //     cartListModel.headingTitle);
        // print("jigar the else part with no cartListModel.errorWarning info" +
        //     user['text_error']);

        //      pr.hide();
      });

      return cartListModel;
    }
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE)!;
    getCategoryList(context, strCategoryID!);
    getCartListDetails(context);
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
          //  MyCartBadgeBtn(scaffoldKey: null),
            SizedBox(
              width: 10,
            ),
            Center(
              child: InkWell(
                child: Image.asset(
                  'assets/images/nav_bar_search2.png',
                  width: 20,
                  height: 20,
                ),
//              tooltip: 'Search Product',
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchListPage()),
                  )
                },
              ),
            ),

            SizedBox(
              width: 10,
            ),
            // Icon(Icons.add),
            // Icon(Icons.add),
          ],
        ),
        body:categoryListModel==null?Center(child: CircularProgressIndicator(),): Form(
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
                      strCategoryName!
                          .replaceAll("&amp;", "&")
                          .replaceAll("&quot;", '"'),
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
                child: Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: categoryListModel != null
                            ? addressListView()
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ))
            ],
          ),
          //    ),
        ),
      ),
    );
  }

  Widget addressListView() {
    return Padding(
        padding: EdgeInsets.only(top: 2),
        child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                log("fjwenunu ===>   *${categoryListModel?.childCategories?[index].name?.replaceAll("&amp;", "&").replaceAll("&quot;", '"').toString()}*");
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      child: Container(
                        height: SizeConfig.blockSizeVertical !* 13.5,
                        margin: EdgeInsets.symmetric(vertical: 1),

                        decoration: new BoxDecoration(
                          color: new Color(0xFFFFFFFF),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: new Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: Material(
                          elevation: 1.0,
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          child: Center(
                            child: Container(
//                        padding: const EdgeInsets.all(3.0),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(1.0)),
//                         border: Border.all(color: AppColors.appSecondaryColor)),
                                child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //Center Row contents horizontally,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    // FadeInImage.memoryNetwork(
                                    //   placeholder: kTransparentImage,
                                    //   image: categoryListModel
                                    //               .childCategories[index]
                                    //               .image !=
                                    //           null
                                    //       ? categoryListModel
                                    //           .childCategories[index].image
                                    //       : 'assets/images/app_icon.png',
                                    //   imageErrorBuilder: (BuildContext context,
                                    //       Object exception,
                                    //       StackTrace stackTrace) {
                                    //     return Image.asset(
                                    //       'assets/images/app_icon.png',
                                    //       height: 80,
                                    //       width: 80,
                                    //     );
                                    //   },
                                    //   height: 80,
                                    //   width: 80,
                                    //   fit: BoxFit.fill,
                                    // ),
                                   Image(image: NetworkImage((categoryListModel?.childCategories?[index].image).toString()), height: 80,
                                            width: 80,

                                   ),

                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${categoryListModel?.childCategories?[index]?.name?.replaceAll("&amp;", "&").replaceAll("&quot;", '"').toString().trim()}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: AppColors
                                                      .appSecondaryOrangeColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: "Poppins",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical !*
                                                      1.8,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  " (${categoryListModel?.childCategories?[index].count.toString()})",
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .appSecondaryOrangeColor,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontFamily: "Poppins",
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical !*
                                                        1.8,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        flex: 3),
                                  ],
                                ),
                              ),
                            )),
                          ),
                        ),
                        // : noDataView(true),
                      ),
                      onTap: () {
//                        String strURl=products.href.replaceAll("&amp;", "&").replaceAll("&quot;", '"');

                        if (categoryListModel != null) {
                          if (categoryListModel?.childCategories != null)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    // return  CategoryProductListWidget(
                                    //       categoryListModel
                                    //           .childCategories[index]
                                    //           .categoryId,
                                    //       categoryListModel
                                    //           .childCategories[index].count)),
                                    //return null;
                                    return loginpage();
                                  }
                            ));
                        }
                        print("Click event on Container");
                      },
                    ));
              },
              itemCount:
                   categoryListModel?.childCategories?.length
                  ),
        );
  }

  Future<dynamic> getCategoryList(
      BuildContext context, String strCategoryID) async {
    print("jigar the strCategoryID page number is " + strCategoryID.toString());

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

  //  pr.show();
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

    String strBaseUrl = Constants.GET_CHILD_CATEGORY_URL +
        strCategoryID +
        "&secure_token=" +
        strToken!;

    print("jigar the response url is we got is " + strBaseUrl);

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response account status we got is " +
        response.statusCode.toString());
    print("jigar the response account we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response user.toString() we got is " + user.toString());

    if (user['child_categories'] != null) {
      categoryListModel = CategoryListModel.fromJson(user);

      //    dataSortList = categoryListModel.sorts;
//
      // var jsonResponse =
      //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;

//       if (pageNumber == 1) {
//         categoryListModel = CategoryListModel.fromJson(user);
//       } else {
// //          CategoryListModel.rewards.addAll(CategoryListModel.fromJson(user));
//         user['rewards'].forEach((v) {
//           categoryListModel.rewards.add(new Rewards.fromJson(v));
//         });
//       }
//
//       print("jigar the response categoryListModel.rewards length is " +
//           categoryListModel.rewards.length.toString());
//
//       pageNumber++;
      // strFirstName = accountDetailsModel.firstname.sentenceCase;
      // strLastName = accountDetailsModel.lastname.sentenceCase;
      // strEmailID = accountDetailsModel.email;
      // strPhoneNumber = accountDetailsModel.telephone;
      //
      // if (accountDetailsModel.addresses.length > 0) {
      //   strAddress = accountDetailsModel.addresses[0].address;
      // }
      setState(() {});
      pr.hide();

      return user;
    } else {
      print("jigar the else part with no rewards info");
      pr.hide();

      return "";
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
  }
}
