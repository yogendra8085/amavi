// TODO Implement this library.
import 'dart:convert';

import 'package:amavinewapp/Model/AddToWishListModel.dart';
import 'package:amavinewapp/Model/BrandListModel.dart';
import 'package:amavinewapp/Pages/product_detail_page.dart';
import 'package:amavinewapp/Pages/search_product_page.dart';
import 'package:amavinewapp/apicaling/wishlistapicalling.dart';
import 'package:badges/badges.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/AddToCartModel.dart';
import '../Model/CartListModel.dart';
import '../Model/FilterListModel.dart';
import '../Model/WishListModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import '../widget/my_cart_badge_btn.dart';



class BrandProductListWidget extends StatefulWidget {
  String strBrandListUrl = "";

  BrandProductListWidget(String mBrandListUrl) {
    strBrandListUrl = mBrandListUrl;
  }

  @override
  _BrandProductListWidgetState createState() =>
      _BrandProductListWidgetState(strBrandListUrl);
}

class _BrandProductListWidgetState extends State<BrandProductListWidget> {
  bool isLoading = true;
  String? strAccessToken;
  String? strToken;
  int ?pageNumber = 1;
  ScrollController ?_scrollController;
  String ?strBrandListUrl;
  String? strBrandName = "";
  String? strBrandManufacturerID = "";
  FilterListModel? brandSubListModel;
  CartListModel? cartListModel;
  int ?selectedWishlist; //= widget.productModel.wishlist;
//   Products productModel;
  String strImageUrl = "assets/images/ic_wishlist_empty.png";

  AddToWishListModel ?addToWishListModel;
  _BrandProductListWidgetState(String mBrandListUrl) {
    strBrandListUrl = mBrandListUrl;
    print("jigar the strBrandManufacturerID  strBrandListUrl have us1 " +
        strBrandListUrl!);
    strBrandManufacturerID = (strBrandListUrl?.substring(
        (strBrandListUrl?.indexOf("_id="))! + 4, strBrandListUrl?.lastIndexOf("&")).toString());
    print("jigar the strBrandManufacturerID have us " + strBrandManufacturerID!);
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    setState(() {

    });
    getBrandProductList(context, pageNumber!);

  }

  refresh() {
    setState(() {
//all the reload processes
      pageNumber = 1;
      brandSubListModel?.products?.clear();
      getBrandProductList(context, 1);
    });
  }

  refreshCartList() {
    setState(() {
      getCartListDetails(context);
    });
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

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (user['products'] != null) {
      cartListModel = CartListModel.fromJson(user);

      setState(() {
        Constants.strCartCount = (cartListModel?.textCount)!.toInt();
      });

      return cartListModel;
    } else {
      setState(() {
        cartListModel = CartListModel.fromJson(user);
      });

      return cartListModel;
    }
  }
  int ? selectedWishlist1;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
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
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                strBrandName!,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 21.0,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),

          Expanded(
            // child:
            // NotificationListener<ScrollNotification>(
            //     onNotification: (ScrollNotification scrollInfo) {
            //       if (!isLoading &&
            //           scrollInfo.metrics.pixels ==
            //               scrollInfo.metrics.maxScrollExtent) {}
            //     },
              child: GridView.builder(
                itemCount: brandSubListModel?.products != null
                    ? brandSubListModel?.products?.length
                    : 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 3
                      : 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,

                  // childAspectRatio:(MediaQuery.of(context).size.height * 0.006),
                  childAspectRatio: (SizeConfig.blockSizeHorizontal !/
                      (SizeConfig.blockSizeVertical !/ 1.2)),
                ),
                itemBuilder: (
                    context,
                    index,
                    ) {
                  selectedWishlist1=brandSubListModel?.products?[index].wishlist;
                  return  SizedBox(
                      width: SizeConfig.blockSizeHorizontal,
                      height: double.infinity,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ProductDetailPage((brandSubListModel?.products?[index].productId).toString(), false, refresh);
                          }));
                        },
                        child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.1, //                   <--- border width here
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            child: brandSubListModel?.products?[index].quantity.toString() != "0"
                                                ? InkWell(
                                              child: Image.asset(
                                                'assets/images/ic_primary_cart.png',
                                                width:
                                                SizeConfig.blockSizeHorizontal !*
                                                    5,
                                                height:
                                                SizeConfig.blockSizeVertical !* 5,
                                              ),
                                              onTap: () {
                                                wishlist(strToken). addToCart(
                                                    context,
                                                    (brandSubListModel?.products?[index].productId).toString(),
                                                    (brandSubListModel?.products?[index].quantity).toString() );
                                              },
                                            )
                                                : Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                color:
                                                AppColors.appSecondaryOrangeColor,
                                                child: Text(
                                                  (brandSubListModel?.products?[index].stock).toString(),
                                                  style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 11.0,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.topLeft,
                                          ),
                                        ),
                                        new Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Align(
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              setState(() {

                                                              });
                                                              //  setState(() async {
                                                              print(
                                                                  "i ma clicked current after is for selectedWishlist " +
                                                                      (selectedWishlist1).toString());

                                                              if (selectedWishlist1 == 0) {
                                                                selectedWishlist1 = 1;
                                                                strImageUrl =
                                                                "assets/images/ic_wishlist_added.png";
                                                                await   addToWishList(
                                                                    context, (brandSubListModel?.products?[index]?.productId).toString());
                                                                //initController();
                                                                // print(
                                                                //     "i ma clicked for selectedWishlist " +
                                                                //         selectedWishlist.toString());

                                                                // var response=await wishlist(strToken).addToWishList(context, (brandSubListModel?.products?[index]?.productId).toString(),(brandSubListModel?.products?[index]?.quantity).toString());
                                                                // print(response);
                                                                // addToWishListModel=AddToWishListModel.fromJson(response);
                                                                // setState(() {
                                                                //
                                                                // });

                                                              } else {
                                                                selectedWishlist1 = 0;
                                                                strImageUrl =
                                                                "assets/images/ic_wishlist_empty.png";
                                                                await  wishlist(strToken).removeProduct(context, (brandSubListModel?.products?[index]?.productId).toString());
                                                                // wishlist. removeFromWishList(
                                                                //      context, brandSubListModel?.products?[index]?.productId);
                                                                //  print(
                                                                //      "i ma clicked for else selectedWishlist " +
                                                                //          selectedWishlist.toString());
                                                              }

                                                              //  getBrandProductList(context, "", false);
                                                              // });


//                                getBrandProductList(context, "", false);
                                                            },
                                                            child: Image.asset(
                                                              selectedWishlist1 == 0
                                                                  ? strImageUrl
                                                                  : "assets/images/ic_wishlist_added.png",
                                                              //,  'assets/images/ic_wishlist_empty.png',
                                                              width: SizeConfig.blockSizeHorizontal !* 5,
                                                              height: SizeConfig.blockSizeVertical !* 5,
                                                            )

                                                          // child: selectedWishlist == 0
                                                          //     ? Image.asset(
                                                          //         'assets/images/ic_wishlist_empty.png',
                                                          //         //,  'assets/images/ic_wishlist_empty.png',
                                                          //         width: SizeConfig.blockSizeHorizontal !* 5,
                                                          //         height: SizeConfig.blockSizeVertical !* 5,
                                                          //       )
                                                          //     : Image.asset(
                                                          //         'assets/images/ic_wishlist_added.png',
                                                          //         width: SizeConfig.blockSizeHorizontal !* 5,
                                                          //         height: SizeConfig.blockSizeVertical! * 5,
                                                          //       ),
                                                        ),
                                                        alignment: Alignment.topRight,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  new Expanded(
                                      child: Center(
                                          child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                                              // child: FadeInImage.memoryNetwork(
                                              //   placeholder: kTransparentImage,
                                              //   image: widget.productModel.thumb,
                                              //   fit: BoxFit.cover,
                                              //   height: SizeConfig.blockSizeVertical * 18,
                                              //   // width: SizeConfig.blockSizeHorizontal * 26,
                                              // ),
                                              child: Image.network((brandSubListModel?.products?[index]?.thumb).toString(),
                                                height: SizeConfig.blockSizeVertical! * 18,
                                                width: SizeConfig.blockSizeHorizontal !* 26,
                                              )
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.bottomCenter,
                                    child: Text(
                                      (brandSubListModel?.products?[index].name
                                          ?.replaceAll("&amp;", "&")
                                          .replaceAll("&quot;", '"')).toString(),
                                      maxLines: 4,
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: SizeConfig.blockSizeVertical! * 1.8,
                                        color: AppColors.greyName,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // if (brandSubListModel?.products?[index].dealzadaBadges.isNullOrBlank)
                                  if (brandSubListModel?.products?[index].dealzadaBadges!=null)

                                    Container(
                                      color: Colors.grey,
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 5.0),
                                        child: Text(
                                          (brandSubListModel?.products?[index].dealzadaBadges
                                              ?.replaceAll("&amp;", "&")
                                              .replaceAll("&quot;", '"')).toString(),
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
                                        brandSubListModel?.products?[index].price ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: SizeConfig.blockSizeVertical !* 1.6,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      brandSubListModel?.products?[index].brandDisc==false?Container():
                                      Text((brandSubListModel?.products?[index].brandDisc).toString() ?? "",
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
                },
              )),
          //  ),
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
    );
  }

//// ADDING THE SCROLL LISTINER
  _scrollListener() {
    if ((_scrollController?.offset)! >=
        ( _scrollController?.position.maxScrollExtent)!.toInt()
    ) {
      setState(() {
        print("comes to bottom $isLoading");
        isLoading = true;

        if (isLoading) {
          print("RUNNING LOAD MORE");

          pageNumber = pageNumber! + 1;

          getBrandProductList(context, pageNumber!);
        }
      });
    }
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

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }
  Future<dynamic> addToWishList(
      BuildContext context, String strProductID) async {
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

    strBaseUrl = Constants.ADD_TO_WISHLIST_PRODUCT + strToken!;
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
  Future< Map<String, dynamic>> getBrandProductList(
      BuildContext context, int intPageNumber) async {
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

    print("jigar the strBrandListUrl url pre is we got is " + strBrandListUrl!);

    int intIndex = (strBrandListUrl?.indexOf("&secure_token"))!.toInt();

    String strBrandListUrlPrefix = (strBrandListUrl?.substring(0, intIndex)).toString();
    String strBrandListUrlPostfix =
    ( strBrandListUrl?.substring(intIndex, strBrandListUrl?.length)).toString();

    strBrandListUrl = strBrandListUrlPrefix +
        "&page=" +
        intPageNumber.toString() +
        strBrandListUrlPostfix;

    print("jigar the strBrandListUrl url is we got is " + strBrandListUrl!);

    final response =
    await http.get(Uri.parse(strBrandListUrl!), headers: requestHeaders);

    print("jigar the response brand status we got is " +
        response.statusCode.toString());
    print("jigar the response brand we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response brand.toString() we got is " + user.toString());

    if (user['products'] != null) {
      setState(() {
        brandSubListModel = FilterListModel.fromJson(user);

        strBrandName = brandSubListModel?.headingTitle;

        print("jigar the response brandSubListModel.brands length is " +
            (brandSubListModel?.products?.length).toString());

        // user['products'].forEach((v) {
        //   brandSubListModel.products.add(new Products.fromJson(v));
        // });
        // pr.hide();
        //  pageNumber++;
        isLoading = false;

      });
      return user;
    } else {
      print("jigar the else part with no brand info");
      //   pr.hide();

      return user;
    }
  }
}


// class HorizontalItem extends StatefulWidget {
//   int position;
//   Products  productModel;
//
//   CartListModel cartListModel;
//   String strToken = "";
//   Function refresh;
//   Function refreshCartList;
//
//   HorizontalItem(int mPosition, Products mBrandModel, String mToken,
//       Function mRefresh, Function refreshCartList) {
//     position = mPosition;
//     productModel = mBrandModel;
//     strToken = mToken;
//     refresh = mRefresh;
//   }
//
//   @override
//   HorizontalItemState createState() =>
//       HorizontalItemState(productModel, refresh, refreshCartList);
// }
//
// class HorizontalItemState extends State<HorizontalItem> {
//   AddToCartModel addToCartModel;
//
//   int selectedWishlist; //= widget.productModel.wishlist;
//   Products productModel;
//   String strImageUrl = "assets/images/ic_wishlist_empty.png";
//   Function refresh;
//   Function refreshCartList;
//   AddToWishListModel addToWishListModel;
//   String price = "";
//   String discountStrikeOut = "";
//
//   HorizontalItemState(
//       Products mProductModel, Function mRefresh, Function mRefreshCartList) {
//     productModel = mProductModel;
//     selectedWishlist = productModel.wishlist;
//     refresh = mRefresh;
//     refreshCartList = mRefreshCartList;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.productModel.brandDisc != false) {
//       price = widget.productModel.price;
//       discountStrikeOut = widget.productModel.brandDisc;
//     } else if (widget.productModel.special != false) {
//       price = widget.productModel.special;
//       discountStrikeOut = widget.productModel.price;
//     } else {
//       price = widget.productModel.price;
//       discountStrikeOut = "";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: SizeConfig.blockSizeHorizontal,
//         height: double.infinity,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ProductDetailPage(
//                       widget.productModel.productId, false, refresh)),
//             );
//           },
//           child: Card(
//               child: Container(
//             padding: const EdgeInsets.all(1.0),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 0.1, //                   <--- border width here
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 new Expanded(
//                     flex: 1,
//                     child: Container(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Align(
//                                 child: productModel.quantity.toString() != "0"
//                                     ? InkWell(
//                                         child: Image.asset(
//                                           'assets/images/ic_primary_cart.png',
//                                           width:
//                                               SizeConfig.blockSizeHorizontal *
//                                                   5,
//                                           height:
//                                               SizeConfig.blockSizeVertical * 5,
//                                         ),
//                                         onTap: () {
//                                           addToCart(
//                                               context,
//                                               widget.productModel.productId,
//                                               "1");
//                                         },
//                                       )
//                                     : Padding(
//                                         padding: const EdgeInsets.all(4.0),
//                                         child: Container(
//                                           color:
//                                               AppColors.appSecondaryOrangeColor,
//                                           child: Text(
//                                             productModel.stock,
//                                             style: TextStyle(
//                                               color: AppColors.white,
//                                               fontSize: 11.0,
//                                               fontFamily: "Poppins",
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                 alignment: Alignment.topLeft,
//                               ),
//                             ),
//                             Expanded(
//                               child: Align(
//                                 child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         print(
//                                             "i ma clicked current after is for selectedWishlist " +
//                                                 selectedWishlist.toString());
//
//                                         if (selectedWishlist == 0) {
//                                           selectedWishlist = 1;
//                                           strImageUrl =
//                                               "assets/images/ic_wishlist_added.png";
//                                           addToWishList(
//                                               context, productModel.productId);
//                                           print(
//                                               "i ma clicked for selectedWishlist " +
//                                                   selectedWishlist.toString());
//                                         } else {
//                                           selectedWishlist = 0;
//                                           strImageUrl =
//                                               "assets/images/ic_wishlist_empty.png";
//                                           removeFromWishList(
//                                               context, productModel.productId);
//                                           print(
//                                               "i ma clicked for else selectedWishlist " +
//                                                   selectedWishlist.toString());
//                                         }
//                                         //  getBrandProductList(context, "", false);
//                                       });
//
// //                                getBrandProductList(context, "", false);
//                                     },
//                                     child: Image.asset(
//                                       selectedWishlist == 0
//                                           ? strImageUrl
//                                           : "assets/images/ic_wishlist_added.png",
//                                       //,  'assets/images/ic_wishlist_empty.png',
//                                       width: SizeConfig.blockSizeHorizontal * 5,
//                                       height: SizeConfig.blockSizeVertical * 5,
//                                     )
//
//                                     // child: selectedWishlist == 0
//                                     //     ? Image.asset(
//                                     //         'assets/images/ic_wishlist_empty.png',
//                                     //         //,  'assets/images/ic_wishlist_empty.png',
//                                     //         width: SizeConfig.blockSizeHorizontal * 5,
//                                     //         height: SizeConfig.blockSizeVertical * 5,
//                                     //       )
//                                     //     : Image.asset(
//                                     //         'assets/images/ic_wishlist_added.png',
//                                     //         width: SizeConfig.blockSizeHorizontal * 5,
//                                     //         height: SizeConfig.blockSizeVertical * 5,
//                                     //       ),
//                                     ),
//                                 alignment: Alignment.topRight,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )),
//                 new Expanded(
//                     child: Center(
//                         child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
//                   child: FadeInImage.memoryNetwork(
//                     placeholder: kTransparentImage,
//                     image: widget.productModel.thumb,
//                     fit: BoxFit.cover,
//                     height: SizeConfig.blockSizeVertical * 18,
//                     // width: SizeConfig.blockSizeHorizontal * 26,
//                   ),
//                 ))),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional.bottomCenter,
//                   child: Text(
//                     widget.productModel.name
//                         .replaceAll("&amp;", "&")
//                         .replaceAll("&quot;", '"'),
//                     maxLines: 4,
//                     textAlign: TextAlign.center,
//                     style: new TextStyle(
//                       fontFamily: "Poppins",
//                       fontSize: SizeConfig.blockSizeVertical * 1.8,
//                       color: AppColors.greyName,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 if (!widget.productModel.dealzadaBadges.isNullOrBlank)
//                   Container(
//                     color: Colors.grey,
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0, vertical: 5.0),
//                       child: Text(
//                         widget.productModel.dealzadaBadges
//                             .replaceAll("&amp;", "&")
//                             .replaceAll("&quot;", '"'),
//                         maxLines: 4,
//                         textAlign: TextAlign.center,
//                         style: new TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: SizeConfig.blockSizeVertical * 1.6,
//                           color: AppColors.white,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       price ?? "",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: SizeConfig.blockSizeVertical * 1.6,
//                         color: AppColors.black,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(discountStrikeOut ?? "",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: SizeConfig.blockSizeVertical * 1.6,
//                             color: AppColors.appSecondaryColor,
//                             decoration: TextDecoration.lineThrough)),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           )),
//         ));
//   }
//
//   Future<dynamic> addToCart(
//       BuildContext context, String strProductID, String strQuantity) async {
//     ProgressDialog pr = new ProgressDialog(context);
//     pr.show();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String strPhpSessionID =
//         prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
//     String strCurrency =
//         prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
//     String strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
//     String strLanguage =
//         prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);
//
//     Map<String, String> requestHeaders = {
//       'Cookie': 'PHPSESSID=' +
//           strPhpSessionID +
//           '; currency=' +
//           strCurrency +
//           '; default=' +
//           strDefault +
//           '; language=' +
//           strLanguage +
//           ''
//     };
//
//     String strBaseUrl;
//
//     strBaseUrl = Constants.ADD_TO_CART_PRODUCT + widget.strToken;
//     print("jigar the product cart url is we got is " + strBaseUrl);
//
//     var map = new Map<String, dynamic>();
//     map['product_id'] = strProductID;
//     map['quantity'] = strQuantity;
//
//     try {
//       print("jigar the response add to cart map " + map.toString());
//       final response = await http.post(Uri.parse(strBaseUrl),
//           body: map, headers: requestHeaders);
//
//       print("jigar the response add to cart status we got is " +
//           response.toString());
//       final String responseString = response.body;
//
//       print("jigar the response add to cart status we got is " +
//           response.statusCode.toString());
//       print("jigar the response account we got is " + response.body.toString());
//
//       if (responseString != "[]") {
//         var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
//         print(
//             "jigar the response user.toString() we got is " + user.toString());
//
//         if (user['total'] != null) {
//           addToCartModel = AddToCartModel.fromJson(user);
//
//           print("jigar the response user.toString() we got is " +
//               addToCartModel.success);
//
//           if (user['success'] != "") {
//             Vibrate.vibrate();
//             showSuccessMsg(
//               msg: "Product Added to Cart Successfully",
//             );
//             pr.hide();
//           }
//
//           return user;
//         } else {
//           print("jigar the else part with no products info");
//           pr.hide();
//
//           return "";
//         }
//       } else {
//         showFailMsg(
//           msg: "Something went wrong try again later",
//         );
//       }
//       pr.hide();
//       return "";
//     } catch (e, stacktrace) {
//       print('jigar the Exception: ' + e.toString());
//       print('jigar the Stacktrace: ' + stacktrace.toString());
//     }
//     return "";
//   }
//

//
//   Future<dynamic> removeFromWishList(
//       BuildContext context, String strProductID) async {
//     ProgressDialog pr = new ProgressDialog(context);
//     // pr.style(
//     //     message: 'Please Waiting...',
//     //     borderRadius: 10.0,
//     //     backgroundColor: Colors.white,
//     //     progressWidget: CircularProgressIndicator(),
//     //     elevation: 10.0,
//     //     insetAnimCurve: Curves.easeInOut,
//     //     progress: 0.0,
//     //     maxProgress: 100.0,
//     //     progressTextStyle: TextStyle(
//     //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//     //     messageTextStyle: TextStyle(
//     //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
//
//     pr.show();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String strPhpSessionID =
//         prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
//     String strCurrency =
//         prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
//     String strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
//     String strLanguage =
//         prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);
//
//     Map<String, String> requestHeaders = {
//       'Cookie': 'PHPSESSID=' +
//           strPhpSessionID +
//           '; currency=' +
//           strCurrency +
//           '; default=' +
//           strDefault +
//           '; language=' +
//           strLanguage +
//           ''
//     };
//
//     String strBaseUrl;
//     //if(intPageNumber==1) {
//     strBaseUrl = Constants.REMOVE_WISHLIST_PRODUCT_URL +
//         strProductID +
//         "&secure_token=" +
//         widget.strToken;
//
//     print("jigar the response url is we got is " + strBaseUrl);
//     var map = new Map<String, dynamic>();
//     map['key'] = strProductID;
//     // map['quantity'] = strQuantity.toString();
//
//     print("jigar the parameter map is " + map.toString());
//
//     print("jigar the parameter strProductID is " + strProductID.toString());
//
//     final response = await http.get(Uri.parse(strBaseUrl),
//         //body: map,
//         headers: requestHeaders);
//
//     final String responseString = response.body;
//
//     print("jigar the response account status we got is " +
//         response.statusCode.toString());
//
//     if (response.statusCode.toString() == "200") {
//       //      wishListModel = null;
//
//       //  getCartListDetails(context);
//     }
//
//     setState(() {});
//     pr.hide();
//
//     return "";
//   }
// }