library constants;

import 'dart:io';



import '../Model/LoginModel.dart';
// import 'package:device_info_plus/device_info_plus.dart';

int currentIndex2 = 0;
String strBottomHome = "Home";
String strBottomHWishList = "WishList";
String strBottomHBrand = "Brands";
String strBottomHProfile = "Profile";
LoginModel ?loginModelConstant;
/*AndroidDeviceInfo androidDeviceInfo;
IosDeviceInfo iosDeviceInfo;*/

Future<void> setDeviceInfo() async {
  /*if (Platform.isAndroid) {
    androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
  } else {
    iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
  }*/
}

// String getDeviceId() {
//   /*if (Platform.isAndroid) {
//     return androidDeviceInfo.androidId;
//   } else {
//     return iosDeviceInfo.identifierForVendor;
//   }*/
// }

const String SUCCESS_MESSAGE = " You will be contacted by us very soon.";

const PREFIX_LIVE_URL = "https://amavi.com.kw/";
// const PREFIX_LIVE_URL = "https://amavilive.ribox.me/";
// const PREFIX_LIVE_URL = "https://amavi.ribox.me/";
//https://amavi.ribox.me/index.php?

// const LOGIN_URL =
//    "https://amavi.ribox.me/index.php?route=endpoint/account/login&secure_token=";
const LOGIN_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/login&secure_token=";
const HOME_PAGE_DATA_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/common/home&secure_token=";
const String REGISTER_URL =PREFIX_LIVE_URL + "index.php?route=restapi/account/register&secure_token=";
const String SOCIAL_REGISTER =PREFIX_LIVE_URL + "index.php?route=endpoint/account/soregister&secure_token=";
const String CONTACT_US_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/information/contact&secure_token=";
const LOGOUT_URL = PREFIX_LIVE_URL + "index.php?route=endpoint/account/logout";
const FORGOT_PASSWORD_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/account/forgotten&secure_token=";

const GET_WISHLIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/wishlist&secure_token=";
const GET_ACCOUNT_DETAILS_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/account&secure_token=";
const GET_ADDRESS_ACCOUNT_DETAILS_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/address&secure_token=";
const ADD_NEW_VOUCHER_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/voucher&secure_token=";
const EDIT_NAME_DETAILS_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/edit&secure_token=";
const GET_REWARD_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/reward&secure_token=";
const GET_SEARCH_LIST_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/product/search/autocomplete&secure_token=";
const GET_FILTER_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/product/category&category_id=";
//https://amavi.ribox.me/index.php?route=endpoint/product/category&category_id=167&filter_category_id=118,117&secure_token={{api_token}}
const GET_SEARCH_PRODUCT_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/product/search&secure_token=";
const GET_BRAND_LIST_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/product/manufacturer&secure_token=";
const GET_CATEGORY_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/product/category&category_id=";

//https://amavi.ribox.me/index.php?route=endpoint/product/manufacturer&secure_token={{api_token}}
const GET_REWARD_VIEW_MORE_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/reward&page=";
const GET_CURRENCY_DEFAULT_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/common/get_defaults";

const SET_CURRENCY_DEFAULT_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/common/set_defaults";

const GET_ORDER_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/order&secure_token=";
const GET_ORDER_VIEW_MORE_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/order&page=";
const GET_ORDER_DETAIL_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/order/info&order_id=";
const GET_PRODUCT_DETAIL_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/product/product&product_id=";

const ADD_TO_CART_PRODUCT = PREFIX_LIVE_URL +
    "index.php?route=endpoint/checkout/cart/add&secure_token=";
const ADD_TO_WISHLIST_PRODUCT = PREFIX_LIVE_URL +
    "index.php?route=endpoint/account/wishlist/add&secure_token=";
const GET_CHILD_CATEGORY_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/product/childcategory&category_id=";

const UPDATE_PASSWORD_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/password&secure_token=";

//https://amavi.ribox.me/index.php?route=endpoint/account/order/info&order_id=27934&secure_token=zYtvuUXWH5dFBxXjMsJIYsfJNwC4KtFk
//https://amavi.com.kw/index.php?route=endpoint/account/voucher_balance/get_voucher_balance&secure_token={{api_token}}
const CHECK_VOUCHER_BALANCE_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/account/voucher_balance/get_voucher_balance&secure_token=";
const GET_VOUCHER_LIST_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/account/voucher_balance&secure_token=";
const GET_CART_LIST_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/checkout/cart&secure_token=";
const GET_NOTIFY_ME_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/product/product/createStockNotification&product_id=";
const UPDATE_QUANTITY_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/checkout/cart/edit&secure_token=";
const UPDATE_VOUCHER_QUANTITY_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/checkout/cart/voucher_update&secure_token=";

//https://amavi.ribox.me/index.php?route=endpoint/checkout/cart/voucher_update&secure_token={{api_token}}
const REMOVE_PRODUCT_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/checkout/cart/remove&secure_token=";
const REMOVE_WISHLIST_PRODUCT_URL =
    PREFIX_LIVE_URL + "index.php?route=endpoint/account/wishlist&remove=";

const ABOUT_US_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/information/information&information_id=4&secure_token=";

const PRIVACY_POLICY_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/information/information&information_id=3&secure_token=";

const TERMS_AND_CONDITION_URL = PREFIX_LIVE_URL +
    "index.php?route=endpoint/information/information&information_id=5&secure_token=";
 const FCM_TOKEN = PREFIX_LIVE_URL + "index.php?route=endpoint/common/notification_token&secure_token=";

int strCartCount = 0;

class TokenDetailsTag {
  static const TOKEN_LOGIN = PREFIX_LIVE_URL + "index.php?route=endpoint/login";
  static const SOCIAL_LOGIN = PREFIX_LIVE_URL + "index.php?route=endpoint/account/login/so_login&secure_token=";
  static const SOCIAL_DATA = "SOCIAL_DATA";
  static const TAG_USER_NAME = "username";
  static const TAG_PASSWORD = "password";
  static const TAG_VALUE_USER_NAME = "amavi_api";
  static const TAG_TOKEN = "token";
  static const TAG_IS_GUEST_LOGIN = "is_guest_login";
  static const TAG_VALUE_PASSWORD = "cM3qR9iJ4eY3jF2tJ3tN9dO0fS2mQ1mW";

  static const TAG_HEADER_STRING = "Cookies";
  static const TAG_PHPSESSID = "PHPSESSID";
  static const TAG_CURRENCY = "currency";
  static const TAG_DEFAULT = "default";
  static const TAG_LANGUAGE = "language";
}

class UserDetailsTag {
//   String SUCCESS_1MESSAGE=" You will be contacted by us very soon.";
  static const PANEL_LIST_ID = "panel_list_id";
  static const API_ACCESS_TOKEN = "api_access_token";
  static const BIRTH_YEAR_VALUE = "birth_year_value";
  static const GENDER_VALUE = "gender_value";
  static const EMAIL = "email";
  static const ISFIRSTTIME = "isFirstTime";
  static const TAG_STORED_USER_NAME = "email";
  static const TAG_STORED_PASSWORD = "password";
  static const FIRST_NAME = "first_name";
  static const MIDDLE_NAME = "middle_name";
  static const LAST_NAME = "last_name";
  static const LANG_CODE = "lang_code";
  static const LANG_CODE_EN = "en-gb";
  static const LANG_CODE_AR = "ar";
}

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
//   }
// }
