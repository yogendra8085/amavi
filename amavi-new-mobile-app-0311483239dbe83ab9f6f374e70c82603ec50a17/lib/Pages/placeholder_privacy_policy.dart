// TODO Implement this library.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../Model/contact_us_model.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';

class PlaceholderPrivacyPolicy extends StatefulWidget {
  final String strHeading;

  PlaceholderPrivacyPolicy(this.strHeading);

  @override
  _PlaceholderPrivacyPolicyWidgetState createState() => _PlaceholderPrivacyPolicyWidgetState();
}

class _PlaceholderPrivacyPolicyWidgetState extends State<PlaceholderPrivacyPolicy> {
  bool ?isLoading = true;
  String ?strToken;
  String? _description;
  String? _headerTitle = "";
  String? _languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  _PlaceholderPrivacyPolicyWidgetState();

  @override
  void initState() {
    super.initState();
    _headerTitle = widget.strHeading;
    initController();
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    getPrivacyPolicyData();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Directionality(
      textDirection: _languageCode == Constants.UserDetailsTag.LANG_CODE_EN? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
        //homepage code
        appBar: AppBar(
          backgroundColor: AppColors.appSecondaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(_headerTitle??""),
          centerTitle: true,
        ),
        body: _description == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Html(
            data: _description ?? "",
            style: {
              "body": Style(
                fontSize: FontSize(SizeConfig.blockSizeVertical !* 1.8),
                //     fontWeight: FontWeight.bold,
              ),
            },
          ),
        ),
        // body: const WebView(
        //   initialUrl: 'https://amavi.com.kw/index.php?route=information/information&information_id=3',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),

        //original code
      ),
    );
  }

  Widget getListView() {
    var listView = ListView(
      children: <Widget>[],
    );
    return listView;
  }

  Future<void> getPrivacyPolicyData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? strPhpSessionID = prefs.getString(Constants.TokenDetailsTag.TAG_PHPSESSID);
      String? strCurrency = prefs.getString(Constants.TokenDetailsTag.TAG_CURRENCY);
      String? strDefault = prefs.getString(Constants.TokenDetailsTag.TAG_DEFAULT);
      String? strLanguage = prefs.getString(Constants.TokenDetailsTag.TAG_LANGUAGE);

      Map<String, String> requestHeaders = {
        'Cookie':
        'PHPSESSID='+strPhpSessionID!+'; currency='+strCurrency!+'; default='+strDefault!+'; language='+strLanguage!+''
      };

      String strBaseUrl = Constants.PRIVACY_POLICY_URL + (strToken ?? "");

      final response =
      await http.get(Uri.parse(strBaseUrl), headers: requestHeaders);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData["description"] != null) {
          _description = jsonData["description"];
          _headerTitle = jsonData["heading_title"];

          setState(() {});
        }
      } else {}
    } catch (e) {}
  }

}

class HorizontalItem extends StatelessWidget {
  final int position;
  final List<String> data = [
    'https://expertphotography.com/wp-content/uploads/2020/05/product-photography-lighting-watch.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6QTmA82tSN7_LXtuWTdYhvWhaXP9-z4jPmQ&usqp=CAU',
    'https://expertphotography.com/wp-content/uploads/2020/05/product-photography-lighting-watch.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6QTmA82tSN7_LXtuWTdYhvWhaXP9-z4jPmQ&usqp=CAU',
    'https://expertphotography.com/wp-content/uploads/2020/05/product-photography-lighting-watch.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6QTmA82tSN7_LXtuWTdYhvWhaXP9-z4jPmQ&usqp=CAU',
    'https://expertphotography.com/wp-content/uploads/2020/05/product-photography-lighting-watch.jpg',
    'https://expertphotography.com/wp-content/uploads/2020/05/product-photography-lighting-watch.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6QTmA82tSN7_LXtuWTdYhvWhaXP9-z4jPmQ&usqp=CAU',
    'https://expertphotography.com/wp-content/uploads/2020/05/product-photography-lighting-watch.jpg'
  ];

  HorizontalItem(
      this.position, {
        required Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 170,
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

            // child: Padding(
            //   padding: const EdgeInsets.all(1.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                (Center(
                    child: Image.network(data[position],
                        fit: BoxFit.cover, width: 100, height: 130))),
                Center(
                  child: Text(
                    "Sample Product $position",
                    style: new TextStyle(
                      fontFamily: "Viaoda",
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )
                // Image.asset(
                //    'assets/images/app_text_logo.png',
                //    height: 50,
                //    fit: BoxFit.fill),

                // Container(
                //             color: Colors.grey,
                //             height: 40.0,
                //             width: 40.0,
                //           ),
                //           SizedBox(width: 8.0),
                //           Text("Item $position"),
                //         ],
                //       ),
                // Text(
                //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sed vulputate orci. Proin id scelerisque velit. Fusce at ligula ligula. Donec fringilla sapien odio, et faucibus tortor finibus sed. Aenean rutrum ipsum in sagittis auctor. Pellentesque mattis luctus consequat. Sed eget sapien ut nibh rhoncus cursus. Donec eget nisl aliquam, ornare sapien sit amet, lacinia quam."),
              ],
            ),
//      ),
          )),
    );
  }


}
