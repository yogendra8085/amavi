

import 'package:amavinewapp/Pages/product_detail_page.dart';
import 'package:amavinewapp/Pages/search_product_page.dart';
import 'package:flutter/material.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/AddToCartModel.dart';
import '../Model/AddToWishListModel.dart';
import '../Model/BrandSubProductList.dart';
import '../Model/TokenModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import '../widget/my_cart_badge_btn.dart';
import 'package:amavinewapp/Model/LoginModel.dart' as login;



class ViewAllGiftProductListWidget extends StatefulWidget {
  List<login.Products> ?productList;
  String ?strHeading;

  ViewAllGiftProductListWidget( List<login.Products> mProductList, String mheading) {
    productList = mProductList;
    strHeading = mheading;
  }

  @override
  _ViewAllGiftProductListWidgetState createState() =>
      _ViewAllGiftProductListWidgetState(productList!, strHeading!);
}

class _ViewAllGiftProductListWidgetState
    extends State<ViewAllGiftProductListWidget> {
  bool isLoading = true;
  String ?strAccessToken;
  String? strToken;
  int pageNumber = 1;
  List<login.Products>? productList;
  String ?strHeading;
  String? _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;
  List<Sorts>? dataFilterList = []; //edited line
  ScrollController? _scrollController;
  String strCategoryUrl = "152";
  int intListLength = 0;


  BrandSubCategoryProductListModel categoryListModel =
  new BrandSubCategoryProductListModel();

  _ViewAllGiftProductListWidgetState(
      List<login.Products> mProductList, String mheading) {
    productList = mProductList;
    strHeading = mheading;
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    getBrandProductList(context, strCategoryUrl, false);

    setState(() {});
  }

  refresh() {
    setState(() {
//all the reload processes
      pageNumber = 1;
      categoryListModel.products?.clear();
      getBrandProductList(context, strCategoryUrl, false);
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    SizeConfig().init(context);

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            MyCartBadgeBtn(scaffoldKey: null),
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
              // Image.asset(
              //   'assets/images/nav_bar_search2.png',
              //   width: 20,
              //   height: 20,
              // ),
            ),

            SizedBox(
              width: 10,
            ),
            // Icon(Icons.add),
            // Icon(Icons.add),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    strHeading!,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 21.0,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
//             Expanded(
//                 child: GridView.builder(
//               //   shrinkWrap: true,
//
//               //    physics: BouncingScrollPhysics(),
//               itemCount: productList != null ? productList.length : 0,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount:
//                     MediaQuery.of(context).orientation == Orientation.landscape
//                         ? 3
//                         : 2,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 childAspectRatio: (SizeConfig.blockSizeHorizontal /
//                     (SizeConfig.blockSizeVertical / 1.5)),
//
// //                          childAspectRatio: (2 / 1),
//               ),
//               itemBuilder: (
//                 context,
//                 index,
//               ) {
//                 return HorizontalItem(
//                     index,
//                     productList != null ? productList[index] : Container(),
//                     strToken,
//                     refresh);
//               },
//             )),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoading &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      if (categoryListModel.products?.length != intListLength) {
                        getBrandProductList(context, strCategoryUrl, false);
                        setState(() {
                          isLoading = true;
                        });
                      }
                      // start loading data

                    }
                    return isLoading;
                  },
                  child: GridView.builder(
                    //   shrinkWrap: true,

                    //    physics: BouncingScrollPhysics(),
                    itemCount: categoryListModel.products != null
                        ? categoryListModel.products?.length
                        : 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                          ? 3
                          : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      // childAspectRatio: MediaQuery.of(context).size.width /
                      //     (MediaQuery.of(context).size.height / 1.5),
                      childAspectRatio: (SizeConfig.blockSizeHorizontal! /
                          (SizeConfig.blockSizeVertical !/ 1.2)),

//                          childAspectRatio: (2 / 1),
                    ),
                    addAutomaticKeepAlives: true,
                    itemBuilder: (
                        context,
                        index,
                        ) {
                      return HorizontaHomeGiftlItem(
                        //globalProductListKey,
                          index,

                               categoryListModel.products![index],

                          strToken!,
                              (){

                          },
                      );
                    },
                  )),
            ),
            Container(
              height: isLoading ? 50.0 : 0,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          ],
        ),
        //original code
      ),
    );
  }

//// ADDING THE SCROLL LISTINER

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> getBrandProductList(
      BuildContext context, String strCategoryID, bool isSorting) async {
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
    //if (intPageNumber == 1)
        {
      if (isSorting) {
        strBaseUrl = strCategoryID;
      } else {
        strBaseUrl = Constants.GET_CATEGORY_LIST_URL +
            strCategoryID +
            "&page=" +
            pageNumber.toString() +
            "&secure_token=" +
            strToken!;
      }
    }

    print("jigar the strCategoryProductListUrl url is we got is " + strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);
    final String responseString = response.body;
    print("jigar the response brand status we got is " +
        response.statusCode.toString());
    print("jigar the response getBrandProductList we got is " +
        response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response getBrandProductList.toString() we got is " +
        user.toString());

    if (user['products'] != null) {
      setState(() {
        if (isSorting) {
          categoryListModel = BrandSubCategoryProductListModel.fromJson(user);
          // strBrandName = categoryListModel.headingTitle;

          print("jigar the response categoryListModel.brands length is " +
              (categoryListModel.products?.length).toString());
          print("jigar the response is wishlist selected " +
              categoryListModel.products![1].wishlist.toString());

          dataFilterList?.clear();
          for (var i = 0; i < (categoryListModel.sorts?.length)!.toInt(); i++) {
            // print("jigar the data elementAt loop we got is " +
            //     categoryListModel.sorts.elementAt(i).text);
            dataFilterList?.add(categoryListModel.sorts!.elementAt(i));
          }

//        if (i == 0) {
//          //data.add("Select Country");
//        }
          //  data.add(resBody.data.elementAt(i).countryName);
        } else {
          if (pageNumber != 1) {
            user['products'].forEach((v) {
              categoryListModel.products!.add(new Products.fromJson(v));
            });
          } else {
            categoryListModel = BrandSubCategoryProductListModel.fromJson(user);
            // strBrandName = categoryListModel.headingTitle;
            print("jigar the response is wishlist selected " +
                categoryListModel.products![1].wishlist.toString());

            // print("jigar the response categoryListModel.brands length is " +
            //     categoryListModel.products.length.toString());

            dataFilterList?.clear();
            for (var i = 0; i < (categoryListModel.sorts?.length)!.toInt(); i++) {
              // print("jigar the data elementAt loop we got is " +
              //     categoryListModel.sorts.elementAt(i).text);
              dataFilterList?.add(categoryListModel.sorts!.elementAt(i));

              // categoryListModel = BrandSubCategoryProductListModel.fromJson(user);
            }
            // strBrandName = categoryListModel.headingTitle;

            print("jigar the response categoryListModel.brands length is " +
                categoryListModel.products!.length.toString());
          }
        }
//        this.getCountryName();
      });
      //    pr.hide();

      isLoading = false;
      pageNumber++;
      return user;
    } else {
      print("jigar the else part with no brand info");
      // pr.hide();

      return "";
    }
  }

  _scrollListener() {
    if ((_scrollController?.offset) !>=
        _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      setState(() {
        print("comes to bottom $isLoading");
        isLoading = true;

        if (isLoading) {
          print("RUNNING LOAD MORE");

          pageNumber = pageNumber + 1;

          getBrandProductList(context, strCategoryUrl, false);
        }
      });
    }
  }
}

class HorizontaHomeGiftlItem extends StatefulWidget {
  int ?position;
  Products ?productModel;

  String? strToken = "";
  Function? refresh;

  HorizontaHomeGiftlItem(
      int mPosition, Products mBrandModel, String mToken, Function mRefresh) {
    position = mPosition;
    productModel = mBrandModel;
    strToken = mToken;
    refresh = mRefresh;
  }

  @override
  HorizontaHomeGiftlItemState createState() =>
      HorizontaHomeGiftlItemState(productModel!, refresh!);
}

class HorizontaHomeGiftlItemState extends State<HorizontaHomeGiftlItem> {
  AddToCartModel? addToCartModel;

  int ?selectedWishlist = 0; //= widget.productModel.wishlist;
  Products? productModel;
  String? strImageUrl = "assets/images/ic_wishlist_empty.png";
  Function ?refresh;
  AddToWishListModel? addToWishListModel;
  String ?price = "";
  String ?discountStrikeOut = "";
  HorizontaHomeGiftlItemState(Products mProductModel, Function mRefresh) {
    productModel = mProductModel;
    // selectedWishlist = productModel.wishlist;
    refresh = mRefresh;
  }
  @override
  void initState() {
    super.initState();
    if (widget.productModel?.brandDisc!=false) {
      price=widget.productModel!.price;
      discountStrikeOut=widget.productModel!.brandDisc;
    }else if (widget.productModel!.special!=false) {
      price=widget.productModel!.special;
      discountStrikeOut=widget.productModel!.price;
    }else{
      price=widget.productModel!.price;
      discountStrikeOut="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal,
//        height: SizeConfig.blockSizeVertical,
        height: double.infinity,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                      (widget.productModel?.productId).toString(), false, refresh!)),
            );
            print("Click event on Container");
          },
          child: Card(
              child: Container(
//          margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1, //                   <--- border width here
                  ),
//          border: Border.all(color: Colors.grey),
                  //        borderRadius: BorderRadius.circular(0.1),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Row(
                          children: [
                            InkWell(
                              child: Image.asset(
                                'assets/images/ic_primary_cart.png',
                                width: SizeConfig.blockSizeHorizontal !* 5,
                                height: SizeConfig.blockSizeVertical !* 5,
                              ),
                              onTap: () {
                                addToCart(
                                    context, (widget.productModel?.productId).toString(), "1");
                              },
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print(
                                        "i ma clicked current after is for selectedWishlist " +
                                            selectedWishlist.toString());

                                    if (selectedWishlist == 0) {
                                      selectedWishlist = 1;
                                      strImageUrl =
                                      "assets/images/ic_wishlist_added.png";
                                      addToWishList(
                                          context, (productModel?.productId).toString()

                                      );
                                      print("i ma clicked for selectedWishlist " +
                                          selectedWishlist.toString());
                                    } else {
                                      selectedWishlist = 0;
                                      strImageUrl =
                                      "assets/images/ic_wishlist_empty.png";
                                      removeFromWishList(
                                          context, (productModel?.productId).toString()

                                      );
                                      print(
                                          "i ma clicked for else selectedWishlist " +
                                              selectedWishlist.toString());
                                    }
                                    //  getBrandProductList(context, "", false);
                                  });

//                                getBrandProductList(context, "", false);
                                },
                                child: Image.asset(
                                  selectedWishlist == 0
                                      ? strImageUrl.toString()
                                      : "assets/images/ic_wishlist_added.png",
                                  //,  'assets/images/ic_wishlist_empty.png',
                                  width: SizeConfig.blockSizeHorizontal !* 5,
                                  height: SizeConfig.blockSizeVertical !* 5,
                                )

                              // child: selectedWishlist == 0
                              //     ? Image.asset(
                              //         'assets/images/ic_wishlist_empty.png',
                              //         //,  'assets/images/ic_wishlist_empty.png',
                              //         width: SizeConfig.blockSizeHorizontal * 5,
                              //         height: SizeConfig.blockSizeVertical * 5,
                              //       )
                              //     : Image.asset(
                              //         'assets/images/ic_wishlist_added.png',
                              //         width: SizeConfig.blockSizeHorizontal * 5,
                              //         height: SizeConfig.blockSizeVertical * 5,
                              //       ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                          child:

                          // CachedNetworkImage(
                          //   imageUrl: productModel.thumb,
                          //   width: 160,
                          //   height: 135,
                          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                          //       CircularProgressIndicator(value: downloadProgress.progress),
                          //   errorWidget: (context, url, error) => Icon(Icons.error),
                          // ),

                          // FadeInImage.memoryNetwork(
                          //   placeholder: kTransparentImage,
                          //   image: widget.productModel.thumb,
                          //   fit: BoxFit.cover,
                          //   height: SizeConfig.blockSizeVertical * 18,
                          //   // width: SizeConfig.blockSizeHorizontal * 26,
                          // ),
                          Image.network((widget.productModel?.thumb).toString(),
                              height: SizeConfig.blockSizeVertical! * 18,
                               width: SizeConfig.blockSizeHorizontal! * 26,

                          )
                          // Image.network(productModel.thumb,
                          //     fit: BoxFit.fill, width: 160, height: 135),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Text(
                        (widget.productModel?.name).toString().replaceAll("&amp;", "&").replaceAll("&quot;", '"'),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: SizeConfig.blockSizeVertical !* 1.8,
                          color: AppColors.greyName,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (widget.productModel?.dealzadaBadges!=null)
                      Container(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          child: Text(
                            (widget.productModel?.dealzadaBadges).toString()
                                .replaceAll("&amp;", "&")
                                .replaceAll("&quot;", '"'),
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                              fontSize: SizeConfig.blockSizeVertical! * 1.6,
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          price ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical! * 1.6,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(discountStrikeOut ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.blockSizeVertical !* 1.6,
                                color: AppColors.appSecondaryColor,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              )),
        ));
  }

  Future<dynamic> addToCart(
      BuildContext context, String strProductID, String strQuantity) async {
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
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.6,
    //         fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.8,
    //         fontWeight: FontWeight.w600));

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

    strBaseUrl = Constants.ADD_TO_CART_PRODUCT + widget.strToken.toString();
    print("jigar the product cart url is we got is " + strBaseUrl);

    var map = new Map<String, dynamic>();
    map['product_id'] = strProductID;
    map['quantity'] = strQuantity;

    try {
      print("jigar the response add to cart map " + map.toString());
      final response = await http.post(Uri.parse(strBaseUrl),
          body: map, headers: requestHeaders);

      print("jigar the response add to cart status we got is " +
          response.toString());
      final String responseString = response.body;

      print("jigar the response add to cart status we got is " +
          response.statusCode.toString());
      print("jigar the response account we got is " + response.body.toString());

      if (responseString != "[]") {
        var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(
            "jigar the response user.toString() we got is " + user.toString());

        if (user['total'] != null) {
          addToCartModel = AddToCartModel.fromJson(user);

          print("jigar the response user.toString() we got is " +
              addToCartModel?.success);

          //setState(()
              {
            if (user['success'] != "") {
              Vibrate.vibrate();
              showSuccessMsg(
                 "Product Added to Cart Successfully",
              );
            }
          }
          //);
          pr.hide();

          return user;
        } else {
          print("jigar the else part with no products info");
          pr.hide();

          return "";
        }
      } else {
        showFailMsg(
          "Something went wrong try again later",
        );
      }
      pr.hide();
      return "";
    } catch (e, stacktrace) {
      print('jigar the Exception: ' + e.toString());
      print('jigar the Stacktrace: ' + stacktrace.toString());
    }
    return "";
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

  Future<dynamic> addToWishList(
      BuildContext context, String strProductID) async {
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
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.6,
    //         fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.8,
    //         fontWeight: FontWeight.w600));

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

    strBaseUrl = Constants.ADD_TO_WISHLIST_PRODUCT + widget.strToken.toString();
    print("jigar the product cart url is we got is " + strBaseUrl);

    var map = new Map<String, dynamic>();
    map['product_id'] = strProductID;

    try {
      print("jigar the response add to cart map " + map.toString());
      final response = await http.post(Uri.parse(strBaseUrl),
          body: map, headers: requestHeaders);

      print("jigar the response add to cart status we got is " +
          response.toString());
      final String responseString = response.body;

      print("jigar the response add to cart status we got is " +
          response.statusCode.toString());
      print("jigar the response account we got is " + response.body.toString());

      if (responseString != "[]") {
        var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(
            "jigar the response user.toString() we got is " + user.toString());

        if (user['total'] != null) {
          addToWishListModel = AddToWishListModel.fromJson(user);

          // print("jigar the response user.toString() we got is " +
          //     addToWishListModel?.success.toString());

          //setState(()
              {
            if (user['success'] != "") {
              Vibrate.vibrate();
              showSuccessMsg(
                 "Product Added to WishList Successfully",
              );
            }
          }
          //);
          pr.hide();

          return user;
        } else {
          print("jigar the else part with no products info");
          pr.hide();

          return "";
        }
      } else {
        showFailMsg(
          "Something went wrong try again later",
        );
      }
      pr.hide();
      return "";
    } catch (e, stacktrace) {
      print('jigar the Exception: ' + e.toString());
      print('jigar the Stacktrace: ' + stacktrace.toString());
    }
    return "";
  }

  Future<dynamic> removeFromWishList(
      BuildContext context, String strProductID) async {
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
    //if(intPageNumber==1) {
    strBaseUrl = Constants.REMOVE_WISHLIST_PRODUCT_URL +
        strProductID +
        "&secure_token=" +
        widget.strToken.toString();
//    127&secure_token={{api_token}}
    print("jigar the response url is we got is " + strBaseUrl);
    var map = new Map<String, dynamic>();
    map['key'] = strProductID;
    // map['quantity'] = strQuantity.toString();

    print("jigar the parameter map is " + map.toString());

    print("jigar the parameter strProductID is " + strProductID.toString());

    final response = await http.get(Uri.parse(strBaseUrl),
        //body: map,
        headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response account status we got is " +
        response.statusCode.toString());

    if (response.statusCode.toString() == "200") {
      //      wishListModel = null;

      //  getCartListDetails(context);
    }

    setState(() {});
    pr.hide();

    return "";
  }
}

class HorizontalItem extends StatefulWidget {
  int ?position;
  Products ?productModel;

  String ?strToken = "";
  Function? refresh;

  HorizontalItem(
      int mPosition, Products mBrandModel, String mToken, Function mRefresh) {
    position = mPosition;
    productModel = mBrandModel;
    strToken = mToken;
    refresh = mRefresh;
  }

  @override
  HorizontalItemState createState() =>
      HorizontalItemState(productModel, refresh!);
}

class HorizontalItemState extends State<HorizontalItem> {
  AddToCartModel? addToCartModel;

  int selectedWishlist = 0; //= widget.productModel.wishlist;
  Products ?productModel;
  String? strImageUrl = "assets/images/ic_wishlist_empty.png";
  Function ?refresh;
  AddToWishListModel ?addToWishListModel;

  HorizontalItemState( mProductModel, Function mRefresh) {
    productModel = mProductModel;
    // selectedWishlist = productModel.wishlist;
    refresh = mRefresh;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal,
//        height: SizeConfig.blockSizeVertical,
        height: double.infinity,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                      (widget.productModel?.productId).toString(), false, refresh!)),
            );
            print("Click event on Container");
          },
          child: Card(
              child: Container(
//          margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1, //                   <--- border width here
                  ),
//          border: Border.all(color: Colors.grey),
                  //        borderRadius: BorderRadius.circular(0.1),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Row(
                          children: [
                            InkWell(
                              child: Image.asset(
                                'assets/images/ic_primary_cart.png',
                                width: SizeConfig.blockSizeHorizontal !* 5,
                                height: SizeConfig.blockSizeVertical !* 5,
                              ),
                              onTap: () {
                                addToCart(
                                    context, (widget.productModel?.productId).toString(), "1");
                              },
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print(
                                        "i ma clicked current after is for selectedWishlist " +
                                            selectedWishlist.toString());

                                    if (selectedWishlist == 0) {
                                      selectedWishlist = 1;
                                      strImageUrl =
                                      "assets/images/ic_wishlist_added.png";
                                      addToWishList(
                                          context,( productModel?.productId).toString()
                                      );
                                      print("i ma clicked for selectedWishlist " +
                                          selectedWishlist.toString());
                                    } else {
                                      selectedWishlist = 0;
                                      strImageUrl =
                                      "assets/images/ic_wishlist_empty.png";
                                      removeFromWishList(
                                          context, (productModel?.productId).toString()

                                      );
                                      print(
                                          "i ma clicked for else selectedWishlist " +
                                              selectedWishlist.toString());
                                    }
                                    //  getBrandProductList(context, "", false);
                                  });

//                                getBrandProductList(context, "", false);
                                },
                                child: Image.asset(
                                  selectedWishlist == 0
                                      ? strImageUrl.toString()
                                      : "assets/images/ic_wishlist_added.png",
                                  //,  'assets/images/ic_wishlist_empty.png',
                                  width: SizeConfig.blockSizeHorizontal! * 5,
                                  height: SizeConfig.blockSizeVertical !* 5,
                                )

                              // child: selectedWishlist == 0
                              //     ? Image.asset(
                              //         'assets/images/ic_wishlist_empty.png',
                              //         //,  'assets/images/ic_wishlist_empty.png',
                              //         width: SizeConfig.blockSizeHorizontal * 5,
                              //         height: SizeConfig.blockSizeVertical * 5,
                              //       )
                              //     : Image.asset(
                              //         'assets/images/ic_wishlist_added.png',
                              //         width: SizeConfig.blockSizeHorizontal * 5,
                              //         height: SizeConfig.blockSizeVertical * 5,
                              //       ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                          child:Image.network(
                              (widget.productModel?.thumb).toString(),
                               height: SizeConfig.blockSizeVertical !* 18,
                            width: SizeConfig.blockSizeHorizontal !* 26,
                          )

                          // CachedNetworkImage(
                          //   imageUrl: productModel.thumb,
                          //   width: 160,
                          //   height: 135,
                          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                          //       CircularProgressIndicator(value: downloadProgress.progress),
                          //   errorWidget: (context, url, error) => Icon(Icons.error),
                          // ),

                          // FadeInImage.memoryNetwork(
                          //   placeholder: kTransparentImage,
                          //   image: widget.productModel.thumb,
                          //   fit: BoxFit.cover,
                          //   height: SizeConfig.blockSizeVertical * 18,
                          //   // width: SizeConfig.blockSizeHorizontal * 26,
                          // ),
                          // Image.network(productModel.thumb,
                          //     fit: BoxFit.fill, width: 160, height: 135),
                        )),
                    Center(
                      child: Text(
                        (widget.productModel?.name).toString().replaceAll("&amp;", "&").replaceAll("&quot;", '"'),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: SizeConfig.blockSizeVertical !* 1.8,
                          color: AppColors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Text(
                        widget.productModel != null
                            ? ((widget.productModel?.special == false)
                            ? ""
                            : (widget.productModel?.price).toString())
                            : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeVertical !* 1.8,
                            color: AppColors.appSecondaryOrangeColor,
                            decoration: TextDecoration.lineThrough)),
                    Text(
                      widget.productModel != null
                          ? (widget.productModel?.special == false
                          ? widget.productModel?.price
                          : widget.productModel?.special)
                          : "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.blockSizeVertical !* 1.8,
                        color: AppColors.appSecondaryOrangeColor,
                      ),
                    ),
                  ],
                ),
              )),
        ));
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

  Future<dynamic> addToCart(
      BuildContext context, String strProductID, String strQuantity) async {
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
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.6,
    //         fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.8,
    //         fontWeight: FontWeight.w600));

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

    strBaseUrl = Constants.ADD_TO_CART_PRODUCT + widget.strToken.toString();
    print("jigar the product cart url is we got is " + strBaseUrl);

    var map = new Map<String, dynamic>();
    map['product_id'] = strProductID;
    map['quantity'] = strQuantity;

    try {
      print("jigar the response add to cart map " + map.toString());
      final response = await http.post(Uri.parse(strBaseUrl),
          body: map, headers: requestHeaders);

      print("jigar the response add to cart status we got is " +
          response.toString());
      final String responseString = response.body;

      print("jigar the response add to cart status we got is " +
          response.statusCode.toString());
      print("jigar the response account we got is " + response.body.toString());

      if (responseString != "[]") {
        var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(
            "jigar the response user.toString() we got is " + user.toString());

        if (user['total'] != null) {
          addToCartModel = AddToCartModel.fromJson(user);

          print("jigar the response user.toString() we got is " +
              addToCartModel?.success);

          //setState(()
              {
            if (user['success'] != "") {
              Vibrate.vibrate();
              showSuccessMsg(
                 "Product Added to Cart Successfully",
              );
            }
          }
          //);
          pr.hide();

          return user;
        } else {
          print("jigar the else part with no products info");
          pr.hide();

          return "";
        }
      } else {
        showFailMsg(
           "Something went wrong try again later",
        );
      }
      pr.hide();
      return "";
    } catch (e, stacktrace) {
      print('jigar the Exception: ' + e.toString());
      print('jigar the Stacktrace: ' + stacktrace.toString());
    }
    return "";
  }

  Future<dynamic> addToWishList(
      BuildContext context, String strProductID) async {
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
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.6,
    //         fontWeight: FontWeight.w400),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: SizeConfig.blockSizeVertical * 1.8,
    //         fontWeight: FontWeight.w600));

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

    strBaseUrl = Constants.ADD_TO_WISHLIST_PRODUCT + widget.strToken.toString();
    print("jigar the product cart url is we got is " + strBaseUrl);

    var map = new Map<String, dynamic>();
    map['product_id'] = strProductID;

    try {
      print("jigar the response add to cart map " + map.toString());
      final response = await http.post(Uri.parse(strBaseUrl),
          body: map, headers: requestHeaders);

      print("jigar the response add to cart status we got is " +
          response.toString());
      final String responseString = response.body;

      print("jigar the response add to cart status we got is " +
          response.statusCode.toString());
      print("jigar the response account we got is " + response.body.toString());

      if (responseString != "[]") {
        var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(
            "jigar the response user.toString() we got is " + user.toString());

        if (user['total'] != null) {
          addToWishListModel = AddToWishListModel.fromJson(user);

          print("jigar the response user.toString() we got is " +
              (addToWishListModel?.success).toString());

          //setState(()
              {
            if (user['success'] != "") {
              Vibrate.vibrate();
              showSuccessMsg(
                "Product Added to WishList Successfully",
              );
            }
          }
          //);
          pr.hide();

          return user;
        } else {
          print("jigar the else part with no products info");
          pr.hide();

          return "";
        }
      } else {
        showFailMsg(
          "Something went wrong try again later",
        );
      }
      pr.hide();
      return "";
    } catch (e, stacktrace) {
      print('jigar the Exception: ' + e.toString());
      print('jigar the Stacktrace: ' + stacktrace.toString());
    }
    return "";
  }

  Future<dynamic> removeFromWishList(
      BuildContext context, String strProductID) async {
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
    //if(intPageNumber==1) {
    strBaseUrl = Constants.REMOVE_WISHLIST_PRODUCT_URL +
        strProductID +
        "&secure_token=" +
        widget.strToken.toString();
//    127&secure_token={{api_token}}
    print("jigar the response url is we got is " + strBaseUrl);
    var map = new Map<String, dynamic>();
    map['key'] = strProductID;
    // map['quantity'] = strQuantity.toString();

    print("jigar the parameter map is " + map.toString());

    print("jigar the parameter strProductID is " + strProductID.toString());

    final response = await http.get(Uri.parse(strBaseUrl),
        //body: map,
        headers: requestHeaders);

    final String responseString = response.body;

    print("jigar the response account status we got is " +
        response.statusCode.toString());

    if (response.statusCode.toString() == "200") {
      //      wishListModel = null;

      //  getCartListDetails(context);
    }

    setState(() {});
    pr.hide();

    return "";
  }
}
