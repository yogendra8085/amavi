import 'dart:convert';
import 'dart:developer';

import 'package:amavinewapp/Pages/loginpage.dart';
import 'package:amavinewapp/Pages/search_product_page.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'dart:convert' as convert;

import '../Model/AddToCartModel.dart';
import '../Model/AddToWishListModel.dart';
import '../Model/ProductDetailModel.dart';
import '../Model/TokenModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import '../controller/cart_controller.dart';
import '../widget/my_cart_badge_btn.dart';
import 'brands_filter_product_list_widget.dart';


class ProductDetailPage extends StatefulWidget {
  String ?strProductID;
  bool? isUrl;
 // GlobalKey<ScaffoldState>? scaffoldKey;
  Function? refresh;

  ProductDetailPage(String mStrProductID, bool mIsUrl, Function mRefresh,
      ) {
    strProductID = mStrProductID;
    isUrl = mIsUrl;
    // if (_scaffoldKey != null) {
    //   scaffoldKey = _scaffoldKey;
    // }
    if (mRefresh != null) {
      refresh = mRefresh;
    }
  }

  @override
  _ProductDetailPageState createState() =>
      _ProductDetailPageState(strProductID!, isUrl!);
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  List<String> imgList = [];
  final CartController _cartController = Get.put( CartController());

  bool isLoading = true;
  TabController ?_tabController;
  String ?strAccessToken;
  ProductDetailModel ?productDetailModel;
  String price = "";
  String discountStrikeOut = "";
  AddToCartModel ?addToCartModel;
  AddToWishListModel? addToWishListModel;
  bool isLoadingVertical = false;
  String strToken = "";
  String strIsGuestLogin = "";

  String strProductID = "";
  int intAddQuantity = 1;
  var option = "";

  var option_id = "";
  var option_value = "";

  bool isLoadingHorizontal = false;
  final CarouselController _controller = CarouselController();

  int ?_current = 0;
  bool ?isUrl1;
  GlobalKey<ScaffoldState>? scaffoldKey;
  String _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  _ProductDetailPageState(String mStrProductID, bool mIsUrl,
      ) {
    strProductID = mStrProductID;
    isUrl1 = mIsUrl;

  }

  @override
  void initState()  {
    _tabController = new TabController(length: 3, vsync: this);

    initController();
    super.initState();
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

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN)!;
    strIsGuestLogin =
        prefs.getString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN)!;
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE)!;

    if (scaffoldKey != null) {
      scaffoldKey?.currentState?.setState(() {
        print('jigar we removed app bar');
       // HomeBottomScreenState.showAppbar = false;
      });
    }
    setState(() {});
    getProductDetails(context, strProductID, isUrl1!);
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
    return WillPopScope(
        onWillPop: () async {
          if (widget.refresh != null) {
            // widget.refresh(); // just refresh() if its statelesswidget
            Navigator.pop(context);
          } else {
            Navigator.of(context).pop();
          }
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return true;
        },
        child: Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),

          appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (widget.refresh != null) {
                    // widget.refresh(); // just refresh() if its statelesswidget
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).pop();
                  }
                }),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    child: Text(
                      productDetailModel != null
                          ? (productDetailModel?.headingTitle).toString()
                          : "",
                      style: TextStyle(
//                  fontFamily: "Viaoda",
                        fontWeight: FontWeight.w300,
                        fontSize: SizeConfig.blockSizeVertical !* 1.9,
                        color: AppColors.black,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 5,
                ),

//            Constants.strCartCount
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        MyCartBadgeBtn(),
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
                                MaterialPageRoute(
                                    builder: (context) => SearchListPage()),
                              )
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 1,
                  ),
                  productDetailModel != null
                      ? Align(
                      alignment: Alignment.center,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 450,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,

                          enlargeCenterPage: true,
//                    onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: imgList
                            .map((item) => Container(
                          child: Center(

                            child: Image.network(item,height: 450,width: 1000,fit: BoxFit.fill,),


                          ),
                        ))
                            .toList(),
                      ))
                      : Container(
                    height: 450,
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      color: Colors.black.withOpacity(0.01),
                      child: imgList != null
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.length > 0
                            ? imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller
                                .animateToPage(entry.key),
                            child: Container(
                              width: 7.0,
                              height: 7.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context)
                                      .brightness ==
                                      Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                      .withOpacity(
                                      _current == entry.key
                                          ? 0.9
                                          : 0.4)),
                            ),
                          );
                        })?.toList() ??
                            []
                            : [],
                      )
                          : Container(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      String strURl = (productDetailModel?.manufacturerHref).toString()
                          .replaceAll("&amp;", "&")
                          .replaceAll("&quot;", '"');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BrandProductListWidget(strURl)))
                          .then((value) {
                        setState(() {});
                      });
                      print("Click event on Container");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          productDetailModel != null
                              ? (productDetailModel?.manufacturer).toString()
                              : "",
                          style: TextStyle(
//                  fontFamily: "Viaoda",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeVertical !* 1.8,
                            color: AppColors.appSecondaryOrangeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        productDetailModel != null
                            ? (productDetailModel?.headingTitle).toString()
                            .replaceAll("&amp;", "&")
                            .replaceAll("&quot;", '"')
                            : "",
                        style: TextStyle(
//                  fontFamily: "Viaoda",
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.blockSizeVertical !* 1.9,

                          color: AppColors.greyName,
                        ),
                      ),
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    productDetailModel != null ? (productDetailModel?.model).toString() : "",
//                    'A-Derma Exomega Emollient Shower OIL 200ml',
                    style: TextStyle(
//                  fontFamily: "Viaoda",
                      fontWeight: FontWeight.w300,
                      fontSize: SizeConfig.blockSizeVertical !* 1.8,
                      color: AppColors.appSecondaryOrangeColor,
                    ),
                  ),
                ),
              ),
                  if( productDetailModel?.dealzadaBadges!=null)
                    Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                        child: Text(
                          (productDetailModel?.dealzadaBadges).toString()
                              .replaceAll("&amp;", "&")
                              .replaceAll("&quot;", '"'),
                          maxLines: 4,
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                            fontSize: SizeConfig.blockSizeVertical! * 1.6,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            price ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical !* 1.6,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(discountStrikeOut ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.blockSizeVertical !* 1.6,
                              color: AppColors.appSecondaryColor,
                              decoration: TextDecoration.lineThrough))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  productDetailModel != null
                                      ? (productDetailModel?.textStock).toString()
//                                  + "  :   "
                                      : '',
                                  //        'Quantity:',
                                  style: TextStyle(
//                  fontFamily: "Viaoda",
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                    SizeConfig.blockSizeVertical !* 1.8,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  productDetailModel != null
                                      ? (productDetailModel?.stock).toString()
                                      : "",
                                  style: productDetailModel != null
                                      ? TextStyle(
//                  fontFamily: "Viaoda",
                                    fontWeight: (productDetailModel
                                        ?.stock ==
                                        "Out Of Stock" ||
                                        productDetailModel?.stock ==
                                            "غير متوفر")
                                        ? FontWeight.w600
                                        : FontWeight.w300,
                                    fontSize: (productDetailModel?.stock ==
                                        "Out Of Stock" ||
                                        productDetailModel?.stock ==
                                            "غير متوفر")
                                        ? SizeConfig.blockSizeVertical !*
                                        1.8
                                        : SizeConfig.blockSizeVertical !*
                                        1.9,
                                    color: AppColors.black,
                                  )
                                      : TextStyle(
//                  fontFamily: "Viaoda",
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                    SizeConfig.blockSizeVertical !*
                                        1.8,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      productDetailModel != null &&
                          productDetailModel?.quantity == "0"
                          ? Container()
                          : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Row(
                              children: [
                                InkWell(
                                  child: Image.asset(
                                    'assets/images/ic_minus_icon.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  onTap: () {
                                    print('jigar i am clicked ' +
                                        intAddQuantity.toString());
                                    print(
                                        'jigar i am productDetailModel.quantity ' +
                                            ( productDetailModel?.quantity).toString());
                                    var intAvailable =
                                        productDetailModel?.quantity;
                                    print('jigar i am intAvailable ' +
                                        intAvailable.toString());

                                    if (intAddQuantity > 1)
                                      // {

                                        {
                                      setState(() {
                                        intAddQuantity--;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  productDetailModel != null
                                      ? productDetailModel?.quantity != "0"
                                      ? intAddQuantity.toString()
                                      : "0"
                                      : "",
                                  style: TextStyle(
//                  fontFamily: "Viaoda",
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                    SizeConfig.blockSizeVertical! *
                                        1.8,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: Image.asset(
                                    'assets/images/ic_plus_icon.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                  onTap: () {
                                    print('jigar i am clicked ' +
                                        intAddQuantity.toString());
                                    print(
                                        'jigar i am productDetailModel.quantity ' +
                                            (productDetailModel?.quantity).toString());
                                    var intAvailable =
                                        productDetailModel?.quantity;
                                    print('jigar i am intAvailable ' +
                                        intAvailable.toString());

                                    if (intAddQuantity.toString() ==
                                        intAvailable) {
                                      showFailMsg(
                                         "Quantity not Available",
                                      );
                                    } else {
                                      setState(() {
                                        intAddQuantity++;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Center(
                            child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/ic_share_icon.png',
                                    width: SizeConfig.blockSizeVertical !* 2.2,
                                    height: SizeConfig.blockSizeVertical! * 2.2,
                                  ),
                                ),
//    Future<void> share(String strTitle,String strModel,String strProductLink) async {
                                //   onTap: share(productDetailModel.headingTitle,productDetailModel.model,productDetailModel.share),

                                onTap: () async {
                                  print("jigar u am clicked for share");
                                  WcFlutterShare.share(
                                      sharePopupTitle:
                                      (productDetailModel?.headingTitle).toString(),
                                      subject: productDetailModel?.model,
                                      text: productDetailModel?.share
                                          ?.replaceAll("&amp;", "&")
                                          .replaceAll("&quot;", '"'),
                                      mimeType: 'text/plain');


                                }
                              //share(),
                            )),
                        flex: 1,
                      ),
                    ],
                  ),
                  if (productDetailModel != null)
                    ListView.builder(
                      itemBuilder: (context, index) {
                        Options ?options = productDetailModel?.options?[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    // child: ProductVarientSelectDialog(
                                    //   options: options,
                                    //   selectedProductOption: (ProductOptionValue
                                    //   selectedOptionValue) {
                                    //     options.selectedProductOption =
                                    //         selectedOptionValue;
                                    //     setState(() {
                                    //       option = "1";
                                    //       option_value = selectedOptionValue
                                    //           .productOptionValueId;
                                    //       option_id = options.productOptionId;
                                    //       intAddQuantity = 1;
                                    //       debugPrint(
                                    //           "jigar the option 12121   " +
                                    //               selectedOptionValue.quantity);
                                    //
                                    //       if (selectedOptionValue.quantity !=
                                    //           null) {
                                    //         productDetailModel?.quantity =
                                    //             selectedOptionValue.quantity;
                                    //       }
                                    //
                                    //       debugPrint(
                                    //           "jigar the option " + option);
                                    //       debugPrint("jigar the option_id " +
                                    //           option_id);
                                    //       debugPrint("jigar the option_value " +
                                    //           option_value);
                                    //       // Fluttertoast.showToast(
                                    //       //     msg: options.selectedProductOption
                                    //       //         .productOptionValueId,
                                    //       //     textColor: Colors.green,
                                    //       //     backgroundColor: Colors.white,
                                    //       //     toastLength: Toast.LENGTH_SHORT,
                                    //       //     gravity: ToastGravity.SNACKBAR,
                                    //       //     timeInSecForIosWeb: 1);
                                    //     });
                                    //   },
                                    //   name: productDetailModel
                                    //       ?.options?[index].name,
                                    // ),
                                  );
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${options?.selectedProductOption == null ? options?.name : options?.selectedProductOption?.name ?? ""}",
                                    style: TextStyle(
                                        color: (options?.selectedProductOption ==
                                            null)
                                            ? Colors.grey
                                            : Colors.black),
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: productDetailModel?.options?.length,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              // padding:
                              //     const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                              // textColor: Colors.white,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                    2.0, 2.0, 2.0, 2.0),
                                primary: AppColors.appSecondaryOrangeColor,
                                onPrimary: Colors.white,
                                elevation: 3,
                                disabledForegroundColor: Colors.white,
                                disabledBackgroundColor:
                                AppColors.appSecondaryOrangeColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        color:
                                        AppColors.appSecondaryOrangeColor)),
                              ),

                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  // if (intAddQuantity != 0) {
                                  if (strIsGuestLogin == "false") {
                                    addToWishList(
                                        context,
                                        ( productDetailModel?.productId).toString()
                                            .toString());
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => loginpage()));
                                    // Fluttertoast.showToast(
                                    //     msg: "Please login",
                                    //     textColor: Colors.green,
                                    //     backgroundColor: Colors.white,
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.SNACKBAR,
                                    //     timeInSecForIosWeb: 1);
                                  }
                                  //}
                                  // else {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please Add Quantity",
                                  //       textColor: Colors.green,
                                  //       backgroundColor: Colors.white,
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       gravity: ToastGravity.SNACKBAR,
                                  //       timeInSecForIosWeb: 1);
                                  // }
                                });
                              },
                              // disabledTextColor: Colors.white,
                              // color: AppColors.appSecondaryOrangeColor,
                              // elevation: 3,
                              child: Text(
                                productDetailModel != null
                                    ? (productDetailModel?.buttonWishlist).toString()
                                    : '',
//                            'Add To Wish List',
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical! * 1.6,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(5.0),
                              //     side: BorderSide(
                              //         color:
                              //             AppColors.appSecondaryOrangeColor)),
                              // disabledColor: AppColors.appSecondaryOrangeColor,
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          intAddQuantity != 0
                              ? Expanded(
                            child: ElevatedButton(
                              // padding:
                              //     const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                              // textColor: Colors.white,
                              style: ElevatedButton.styleFrom(
                                // padding: const EdgeInsets.fromLTRB(
                                //     2.0, 2.0, 2.0, 2.0),
                                primary: AppColors.appSecondaryColor,
                                onPrimary: Colors.white,
                                elevation: 3,
                                disabledForegroundColor: Colors.white,
                                disabledBackgroundColor:
                                AppColors.appSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        color:
                                        AppColors.appSecondaryColor)),
                              ),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  // if (strIsGuestLogin != "false") {
                                  //   Navigator.push(context,
                                  //       MaterialPageRoute(builder: (_) =>
                                  //           LoginScreenPage()));
                                  //   return;
                                  // }
                                  if (intAddQuantity != 0) {
                                    var response = addToCart(context);
                                  } else {
                                    showFailMsg(
                                       "Quantity Not Available",
                                    );
                                  }
                                });
                              },
                              // disabledTextColor: Colors.white,
                              // color: AppColors.appSecondaryColor,
                              // elevation: 3,
                              child: Text(
                                productDetailModel != null
                                    ? (productDetailModel?.buttonCart).toString()
                                    : '',
//                            'Add To Cart',
                                style: TextStyle(
                                  fontSize:
                                  SizeConfig.blockSizeVertical !* 1.6,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius:
                              //         BorderRadius.circular(5.0),
                              //     side: BorderSide(
                              //         color:
                              //             AppColors.appSecondaryColor)),
                              // disabledColor: AppColors.appSecondaryColor,
                            ),
                            flex: 3,
                          )
                              : Expanded(
                            child: ElevatedButton(
                              // padding:
                              //     const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                              // textColor: Colors.white,
                              style: ElevatedButton.styleFrom(
                                // padding: const EdgeInsets.fromLTRB(
                                //     2.0, 2.0, 2.0, 2.0),
                                primary: AppColors.appSecondaryColor,
                                onPrimary: Colors.white,
                                elevation: 3,
                                disabledForegroundColor: Colors.white,
                                disabledBackgroundColor:
                                AppColors.appSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        color:
                                        AppColors.appSecondaryColor)),
                              ),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  if (strIsGuestLogin == "false") {
                                    var response =
                                    getNofityDetails(context);
                                  } else {
                                    //   Fluttertoast.showToast(
                                    //       msg: "Please login",
                                    //       textColor: Colors.green,
                                    //       backgroundColor: Colors.white,
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.SNACKBAR,
                                    //       timeInSecForIosWeb: 1);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                loginpage()));
                                  }
                                });
                              },
                              // disabledTextColor: Colors.white,
                              // color: AppColors.green,
                              // elevation: 3,
                              child: Text(
                                // productDetailModel != null
                                //     ? productDetailModel.buttonCart
                                //     : '',
                                productDetailModel != null
                                    ? (productDetailModel?.buttonNotify).toString()
                                    : 'Notify Me',
                                style: TextStyle(
                                  fontSize:
                                  SizeConfig.blockSizeVertical !* 1.6,
                                ),
                              ),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius:
                              //         BorderRadius.circular(5.0),
                              //     side: BorderSide(
                              //         color:
                              //             AppColors.appSecondaryColor)),
                              // disabledColor: AppColors.appSecondaryColor,
                            ),
                            flex: 3,
                          ),
//                           Expanded(
//                             child: Center(
//                                 child: InkWell(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Image.asset(
//                                         'assets/images/ic_share_icon.png',
//                                         width:
//                                             SizeConfig.blockSizeVertical * 1.7,
//                                         height:
//                                             SizeConfig.blockSizeVertical * 1.7,
//                                       ),
//                                     ),
// //    Future<void> share(String strTitle,String strModel,String strProductLink) async {
//                                     //   onTap: share(productDetailModel.headingTitle,productDetailModel.model,productDetailModel.share),
//
//                                     onTap: () async {
//                                       print("jigar u am clicked for share");
//                                       WcFlutterShare.share(
//                                           sharePopupTitle:
//                                               productDetailModel.headingTitle,
//                                           subject: productDetailModel.model,
//                                           text: productDetailModel.share
//                                               .replaceAll("&amp;", "&")
//                                               .replaceAll("&quot;", '"'),
//                                           mimeType: 'text/plain');
//
//                                       // await share(
//                                       //     productDetailModel.headingTitle,
//                                       //     productDetailModel.model,
//                                       //     productDetailModel.share);
//                                     }
//                                     //share(),
//                                     )),
//                             flex: 1,
//                           ),
                        ],
                      ),
                    ),
                  ),
                  TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.red,
                    tabs: [
                      Tab(
                        text: productDetailModel != null
                            ? productDetailModel?.tabDescription?.toString().capitalize
//                        + "  :   "
                            : '',
//                    'Description',
//                    icon: Icon(Icons.people),
                      ),
                      Tab(
                        text: productDetailModel != null
                            ? productDetailModel?.tabUse?.toString().capitalize
//                        + "  :   "
                            : '',
                        //'Use',
                      ),
                      Tab(
                        text: productDetailModel != null
                            ? productDetailModel?.tabIngredients.toString().capitalize
                        //   + "  :   "
                            : '',
//                    'Ingredients',
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.38,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: productDetailModel != null
                              ? SingleChildScrollView(
                            child: Container(
                              child: Html(
                                data: productDetailModel?.description
                                    ?.toLowerCase(),
                                style: {
                                  "#": Style(
                                    fontSize: FontSize(
                                        SizeConfig.blockSizeVertical !*
                                            1.8),
                                    //     fontWeight: FontWeight.bold,
                                  ),
                                },
                              ),
                            ),
                          )
                              : Container(),
                          // Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed tempus urna et pharetra pharetra massa massa ultricies. Cursus euismod quis viverra nibh cras pulvinar mattis nunc. Felis eget nunc lobortis mattis. Netus et malesuada fames ac turpis egestas. Sed arcu non odio euismod lacinia at quis risus. Tellus mauris a diam maecenas sed. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum. Morbi quis commodo odio aenean sed. Varius duis at consectetur lorem donec massa sapien. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna.'
                          //     ,style: TextStyle(fontSize: 16),),
                        ),
//                         Html(
//                           data: productDetailModel != null
//                               ? productDetailModel.useing.toLowerCase()
//                               : "",
//                           style: {
//                             "body": Style(
//                               fontSize:
//                                   FontSize(SizeConfig.blockSizeVertical * 1.8),
// //                          fontWeight: FontWeight.bold,
//                             ),
//                           },
//                         ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: productDetailModel != null
                              ? SingleChildScrollView(
                            child: Container(
                              child: Html(
                                data: productDetailModel?.useing
                                    ?.toLowerCase(),
                                style: {
                                  "#": Style(
                                    fontSize: FontSize(
                                        SizeConfig.blockSizeVertical !*
                                            1.8),
                                    //     fontWeight: FontWeight.bold,
                                  ),
                                },
                              ),
                            ),
                          )
                              : Container(),
                          // Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed tempus urna et pharetra pharetra massa massa ultricies. Cursus euismod quis viverra nibh cras pulvinar mattis nunc. Felis eget nunc lobortis mattis. Netus et malesuada fames ac turpis egestas. Sed arcu non odio euismod lacinia at quis risus. Tellus mauris a diam maecenas sed. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum. Morbi quis commodo odio aenean sed. Varius duis at consectetur lorem donec massa sapien. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna.'
                          //     ,style: TextStyle(fontSize: 16),),
                        ),
                        // Html(
                        //   data: productDetailModel != null
                        //       ? productDetailModel.ingredients.toLowerCase()
                        //       : "",
                        //   style: {
                        //     "body": Style(
                        //       fontSize:
                        //           FontSize(SizeConfig.blockSizeVertical * 1.8),
                        //       //     fontWeight: FontWeight.bold,
                        //     ),
                        //   },
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: productDetailModel != null
                              ? SingleChildScrollView(
                            child: Container(
                              child: Html(
                                data: productDetailModel?.ingredients
                                    ?.toLowerCase(),
                                style: {
                                  "#": Style(
                                    fontSize: FontSize(
                                        SizeConfig.blockSizeVertical! *
                                            1.8),
                                    //     fontWeight: FontWeight.bold,
                                  ),
                                },
                              ),
                            ),
                          )
                              : Container(),
                          // Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed tempus urna et pharetra pharetra massa massa ultricies. Cursus euismod quis viverra nibh cras pulvinar mattis nunc. Felis eget nunc lobortis mattis. Netus et malesuada fames ac turpis egestas. Sed arcu non odio euismod lacinia at quis risus. Tellus mauris a diam maecenas sed. Vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum. Morbi quis commodo odio aenean sed. Varius duis at consectetur lorem donec massa sapien. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna.'
                          //     ,style: TextStyle(fontSize: 16),),
                        ),
                      ],
                      controller: _tabController,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> share(
      String strTitle, String strModel, String strProductLink) async {
    // Future<void> share() async {
    // await FlutterShare.share(
    //     title: strTitle,
    //     text: '',
    //     linkUrl: strProductLink,
    //     chooserTitle: 'Amavi');
    // title: 'strTitle',
    // text: 'strModel',
    // linkUrl: 'strProductLink',
    // chooserTitle: 'Example Chooser Title');
  }

  Future<dynamic> getProductDetails(
      BuildContext context, String strProductID, bool isUrl) async {
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
    //if(intPageNumber==1) {

    if (isUrl) {
      strBaseUrl = strProductID;
    } else {
      strBaseUrl = Constants.GET_PRODUCT_DETAIL_URL +
          strProductID +
          "&secure_token=" +
          strToken;
    }

    print("jigar the product detail url is we got is " + strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    print("jigar the response account status we got is " +
        response.statusCode.toString());
    log("jigar the response account we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response user.toString() we got is " + user.toString());

    if (user['product_id'] != null) {
      productDetailModel = ProductDetailModel.fromJson(user);

      if (productDetailModel?.brandDisc != false) {
        price = (productDetailModel?.price).toString();
        discountStrikeOut = productDetailModel?.brandDisc;
      } else if (productDetailModel?.special != false) {
        price = productDetailModel?.special;
        discountStrikeOut = (productDetailModel?.price).toString();
      } else {
        price = (productDetailModel?.price).toString();
        discountStrikeOut = "";
      }
      imgList.add((productDetailModel?.thumb).toString());

      if ((productDetailModel?.images?.length)! > 0) {
        for (int i = 0; i < (productDetailModel?.images?.length)!.toInt(); i++) {
          imgList.add((productDetailModel?.images?[i].thumb).toString());
        }
      }

      int intAvailable = int.parse((productDetailModel?.quantity).toString());
      if (intAvailable > 0) {
        intAddQuantity = 1;
      } else {
        intAddQuantity = 0;
      }
      if ((productDetailModel?.options?.isNotEmpty)!) {
        Options ?options = productDetailModel?.options?[0];
        if ((options?.productOptionValue?.isNotEmpty)!) {
          ProductOptionValue? optionValue = options?.productOptionValue?[0];
          intAddQuantity = 1;
          options?.selectedProductOption = optionValue;
          option = "1";

          option_value = (optionValue?.productOptionValueId)??"";
          option_id = options?.productOptionId??"";
          if (optionValue?.quantity != null) {
            productDetailModel?.quantity = optionValue?.quantity;
          }
        }
      }
      setState(() {});
      pr.hide();
      return user;
    } else {
      print("jigar the else part with no products info");
      pr.hide();

      return "";
    }
  }

  Future<dynamic> addToWishList(
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

    strBaseUrl = Constants.ADD_TO_WISHLIST_PRODUCT + strToken;
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
              ( addToWishListModel?.success).toString());

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

  Future<dynamic> addToCart(BuildContext context) async {
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

    strBaseUrl = Constants.ADD_TO_CART_PRODUCT + strToken;
    print("jigar the product cart url is we got is " + strBaseUrl);
    print("jigar the product cart url is we got is requestHeaders    " +
        jsonEncode(requestHeaders));

    var map = new Map<String, dynamic>();
    map['product_id'] = productDetailModel?.productId.toString();
    map['quantity'] = intAddQuantity.toString();
    map['option'] = option;
    map['option_id'] = option_id;
    map['option_value'] = option_value;

    try {
      print("jigar the response add to cart map " + map.toString());
      final response = await http.post(Uri.parse(strBaseUrl),
          body: map, headers: requestHeaders);
      _cartController.getCartListDetails();

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

          setState(() {
            if (user['success'] != "") {
              Vibrate.vibrate();
              showSuccessMsg(
                 "Product Added to Cart Successfully",
              );
            }
          });
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

  Future<dynamic> getNofityDetails(BuildContext context) async {
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
    strBaseUrl = Constants.GET_NOTIFY_ME_URL +
        strProductID +
        "&secure_token=" +
        strToken;

    print("jigar the response url is we got is " + strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    print("jigar the response account status we got is " +
        response.statusCode.toString());
    print("jigar the response account we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print("jigar the response user.toString() we got is " + user.toString());

    if (user['status'] != null) {
      // var jsonResponse =
      //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;

      setState(() {
        showSuccessMsg(
          "Thank you.We will notify you ones stock is available",
        );
      });
      pr.hide();

      return user;
    } else {
      pr.hide();
    }
  }
}