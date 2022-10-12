import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/CartListModel.dart';
import '../Model/TokenModel.dart';
import '../Pages/cartlistppage.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import '../controller/cart_controller.dart';

class MyCartBadgeBtn extends StatefulWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;

  MyCartBadgeBtn({this.scaffoldKey});

  @override
  _MyCartBadgeBtnState createState() => _MyCartBadgeBtnState();
}

class _MyCartBadgeBtnState extends State<MyCartBadgeBtn> {
 // final CartController _cartController = Get.find();
  CartListModel? cartListModel;
  Future<CartListModel>? _futureCartList;
  final CartController _cartController = Get.put( CartController());

  @override
  void initState() {

    super.initState();
    _updateWidget();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      _cartController.getCartListDetails();
    });
  }

  void _updateWidget() {
    // _futureCartList = getCartListDetails();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: InkWell(
        child: GetX<CartController>(builder: (cont) {
          log("cartListModel.value.textCount   ==>  ${cont.cartListModel.value.textCount}");
          if (cont.cartListModel.value.textCount != 0) {
            return Badge(
              toAnimate: true,
              position: BadgePosition.topEnd(top: 1, end: -6),
              animationType: BadgeAnimationType.slide,
              badgeColor: AppColors.appSecondaryOrangeColor,
              // badgeContent: FutureBuilder<CartListModel>(
              //     future: _futureCartList,
              //     builder: (context, snapshot) {
              //       return Text(
              //         Constants.strCartCount != 0
              //             ? Constants.strCartCount.toString()
              //             : "",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: SizeConfig.blockSizeVertical * 1.2,
              //         ),
              //       );
              //     }),
              badgeContent: Text(
                (cont.cartListModel.value.textCount ?? "").toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeVertical !* 1.2,
                ),
              ),
              child: Image.asset(
                'assets/images/nav_bar_cart2.png',
                width: SizeConfig.blockSizeHorizontal! * 5.5,
                height: SizeConfig.blockSizeVertical !* 4.5,
              ),
            );
          }
          return Image.asset(
            'assets/images/nav_bar_cart2.png',
            width: SizeConfig.blockSizeHorizontal !* 5.5,
            height: SizeConfig.blockSizeVertical !* 4.5,
          );
        }),
        onTap: () {
          // pushDynamicScreen(
          //   context,
          //   screen: CartListPage(),
          //   withNavBar: true,
          // );
          // pushNewScreenWithRouteSettings(
          //   context,
          //   settings: RouteSettings(name: "CartListPage"),
          //   withNavBar: true,
          //   screen: CartListPage(widget.scaffoldKey),
          //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          // );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  cartlistpage()),
          );
        },
      ),
    );
  }

  Future<void> getCartListDetails() async {
    String? strAccessToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strAccessToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);

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

    // Map<String, String> requestHeaders = {
    //   'Cookie':
    //       'PHPSESSID=asdsndp8aeabaebb4a291a08cbd76f25314e1af; currency=KWD; default=tpgoe6dn5l67hnrsi0k3e2hheu; language=en-gb'
    // };

    String strBaseUrl;

    strBaseUrl =
        Constants.GET_CART_LIST_URL + "&secure_token=" + strAccessToken!;

    final response =
        await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;

    cartListModel = CartListModel.fromJson(user);
    setState(() {
      Constants.strCartCount = (cartListModel?.textCount)!.toInt();
    });
  }

  @override
  void didUpdateWidget(covariant MyCartBadgeBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateWidget();
  }
}
