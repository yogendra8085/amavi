import '../Model/BrandListModel.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';

class brandapi {
  String? strtoken;
  String ?langcode;

  brandapi(this.strtoken, this.langcode);

  Future<dynamic> getBrandList(BuildContext context) async {
    // ProgressDialog pr = new ProgressDialog(context);
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
    //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    // pr.show();
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

    print("LanguageCOde ===>   $langcode");
    String strBaseUrl;
    //if (intPageNumber == 1)
        {
      strBaseUrl = Constants.GET_BRAND_LIST_URL +
          (strtoken ?? "") +
          "&customer_language=${langcode}";
    }

    print("jigar the response url is we got is " + strBaseUrl);

    final response =
    await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);

    final String responseString = response.body;

    // print("jigar the response brand status we got is " +
    //     response.statusCode.toString());
    // print("jigar the response brand we got is " + response.body.toString());
    var user = convert.jsonDecode(response.body) as Map<String, dynamic>;
    // print("jigar the response brand.toString() we got is " + user.toString());

    if (user['brands'] != null) {
      // var jsonResponse =
      //     convert.jsonDecode(user.toString()) as Map<String, dynamic>;

      // if(pageNumber==1)
      // {
      // brandListModel = BrandListModel.fromJson(user);
      //}
//       else
//       {
// //          rewardHistoryListModel.rewards.addAll(RewardHistoryListModel.fromJson(user));
//         user['rewards'].forEach((v) { rewardHistoryListModel.rewards.add(new Rewards.fromJson(v)); });
//       }

      // print("jigar the response brandListModel.brands length is " +
      //     brandListModel.brands.length.toString());

      // pageNumber++;
      // strFirstName = accountDetailsModel.firstname.sentenceCase;
      // strLastName = accountDetailsModel.lastname.sentenceCase;
      // strEmailID = accountDetailsModel.email;
      // strPhoneNumber = accountDetailsModel.telephone;
      //
      // if (accountDetailsModel.addresses.length > 0) {
      //   strAddress = accountDetailsModel.addresses[0].address;
      // }
      //  setState(() {});
      //  pr.hide();

      return user;
    } else {
      print("jigar the else part with no brand info");
      //pr.hide();

      return "";
    }
  }
}