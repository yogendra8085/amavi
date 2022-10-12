import 'dart:convert';

import 'package:flutter/material.dart';
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

class PlaceholderAboutUS extends StatefulWidget {
  final String strAboutUs;

  PlaceholderAboutUS(this.strAboutUs);

  @override
  _PlaceholderAboutUsWidgetState createState() =>
      _PlaceholderAboutUsWidgetState();
}

class _PlaceholderAboutUsWidgetState extends State<PlaceholderAboutUS> {
  bool isLoading = true;
  String? strToken;
  String ?_description;
  String ?_headerTitle = "";
  String ?_languageCode = Constants.UserDetailsTag.LANG_CODE_EN;

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _headerTitle = widget.strAboutUs;
    initController();
  }

  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    getAboutUsData();
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
        appBar: AppBar(
          backgroundColor: AppColors.appSecondaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(_headerTitle ?? ""),
          centerTitle: true,
        ),
        body: _description == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Html(
                  data: _description ?? "",
                  style: {
                    "#": Style(
                      fontSize: FontSize(SizeConfig.blockSizeVertical! * 1.8),
                      //     fontWeight: FontWeight.bold,
                    ),
                  },
                ),
              ),
      ),
    );
    //original code
  }


  Future<void> getAboutUsData() async {
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

      String strBaseUrl = Constants.ABOUT_US_URL + (strToken ?? "");

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

