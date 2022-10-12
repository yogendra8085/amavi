
import 'package:amavinewapp/Pages/product_detail_page.dart';
import 'package:amavinewapp/Pages/view_all_gift_product_list_widget.dart';
import 'package:amavinewapp/apicaling/homedataapi.dart';
import 'package:amavinewapp/widget/my_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Model/InstaGramModel.dart';
import '../Model/LoginModel.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constantpages/colors.dart';
import 'Brandpage.dart';
import 'brands_filter_product_list_widget.dart';
import 'category_list_screen.dart';
import 'package:amavinewapp/Model/LoginModel.dart' as login;

class homepage1 extends StatefulWidget {
  LoginModel? loginModel;
  bool istrue;
  homepage1(
    this.loginModel,
    this.istrue,
  );

  @override
  State<homepage1> createState() => _homepage1State();
}

class _homepage1State extends State<homepage1> {
  bool isLoading = true;
  String? strAccessToken;
  String? strIsGuestLogin;
  String? strLangCode;
  bool? isLoadingVertical = false;
  bool? isLoadingHorizontal = false;
  List<dynamic>? listEdges;
  List<Edges>? instPostEdge;
  LoginModel? HomePageDataModel;
  GlobalKey<ScaffoldState>? scaffoldKey;
  AnimationController? _animationController;
  bool isPlaying = false;

  Future<dynamic> GetHomeData(BuildContext context) async {
    print(strAccessToken??""+"hhhbebebn");
    final String strBaseUrl =
        "https://amavi.com.kw/index.php?route=endpoint/common/home&secure_token=${strAccessToken}&customer_language=en-gb";
    final response = await http.get(
      Uri.parse(strBaseUrl),
    );

    print("jigar the response status we got is " +
        response.statusCode.toString());
    print("jigar the response we got is " + response.body.toString());
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    setState(() {
      //    pr.hide();
    });

    return jsonResponse;
  }

  getrefresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strAccessToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strIsGuestLogin =
        prefs.getString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN);
    setState(() {

    });

    var res = await homedata(strAccessToken,context). GetHomeData();

    setState(() {});
  }

  @override
  initState() {
    // TODO: implement initState
    //initController();

    HomePageDataModel=widget.loginModel;
    setState(() {

    });

    //getrefresh();
    super.initState();
  }

  TextEditingController userInput = TextEditingController();
  initController() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("Firebase Token:=> $fcmToken");
    userInput.text = fcmToken!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strAccessToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strIsGuestLogin =
        prefs.getString(Constants.TokenDetailsTag.TAG_IS_GUEST_LOGIN);

    setState(() {});
    if (HomePageDataModel?.code != null) {
      prefs.setString(Constants.UserDetailsTag.LANG_CODE,
          (HomePageDataModel?.code).toString());
      strLangCode = HomePageDataModel!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:HomePageDataModel == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
      child:  Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3.5,
                    viewportFraction: 1,
                    initialPage: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    //                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                    disableCenter: true,
                  ),
                  items: HomePageDataModel?.topSlider?.slides
                      ?.map((item) => Container(
                            width: double.infinity,
                            child: Image.network(item.mobileimage_n ?? "",
                                fit: BoxFit.fill, width: double.infinity),
                          ))
                      .toList(),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Brands",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontFamily: "Bordeaux",
                          ),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15,
                                fontFamily: "Bordeaux",
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => brandpage()));
                            },
                          ),
                        ),
                      ),
                    ]),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 100 * 15,
                  child: ListView.builder(
                    itemCount: HomePageDataModel?.brands?.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: (){
                        String strURl = (HomePageDataModel?.brands?[index]?.href!.replaceAll("&amp;", "&").replaceAll("&quot;", '"')).toString();
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return BrandProductListWidget(strURl);
                        }));
                      },
                      child: Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width:
                                    0.1, //                   <--- border width here
                              ),
                              //          border: Border.all(color: Colors.grey),
                              //        borderRadius: BorderRadius.circular(0.1),
                            ),
                            child: Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(HomePageDataModel
                                            ?.brands?[index].image
                                            .toString() ??
                                        "helo")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(HomePageDataModel
                                            ?.brands?[index].name
                                            .toString() ??
                                        "helo"),
                                  ),
                                )
                              ],
                            ))),
                      ),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Gift Sets & Offers",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontFamily: "Bordeaux",
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ViewAllGiftProductListWidget(
                              (HomePageDataModel!.featuredProducts!.products) as List<login.Products>,
                              ( HomePageDataModel?.textGiftSetOffer).toString(),

                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15,
                                fontFamily: "Bordeaux",
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => brandpage()));
                            },
                          ),
                        ),
                      ),
                    ]),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 100 * 25,
                  child: ListView.builder(
                    itemCount:
                        HomePageDataModel?.featuredProducts?.products?.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ProductDetailPage((HomePageDataModel?.featuredProducts?.products?[index].productId).toString(),false,(){});
                        }));
                      },
                      child: Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.9,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width:
                                    0.1, //                   <--- border width here
                              ),
                              //          border: Border.all(color: Colors.grey),
                              //        borderRadius: BorderRadius.circular(0.1),
                            ),
                            child: Center(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Image.network(HomePageDataModel
                                            ?.featuredProducts
                                            ?.products?[index]
                                            ?.thumb ??
                                        ""),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      HomePageDataModel?.featuredProducts
                                              ?.products?[index]?.name ??
                                          "",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontFamily: "Bordeaux",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                      ),
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3.5,
                    viewportFraction: 1,
                    initialPage: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    //                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                    disableCenter: true,
                  ),
                  items: HomePageDataModel?.bottomSlider?.slides
                      ?.map((item) => Container(
                            width: double.infinity,
                            child: Image.network(item.mobileimage_n ?? "",
                                fit: BoxFit.fill, width: double.infinity),
                          ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Wrap(
                    spacing: 20.0,
                    alignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      GridView.count(
                        scrollDirection: Axis.vertical,

                        shrinkWrap: true,

                        physics: ScrollPhysics(),

                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        childAspectRatio: 1.2,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(
                            HomePageDataModel?.categories?.length ?? 6,
                            (index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                               return CategoryListPage(HomePageDataModel?.categories?[index].categoryId,HomePageDataModel?.categories?[index].name,index);
                              }));
                            //  CategoryListPage(HomePageDataModel?.categories?[index].categoryId,HomePageDataModel?.categories?[index].name,index);

                            },
                            child: Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2.9,
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      15,
                                  padding: const EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width:
                                          0.1, //                   <--- border width here
                                    ),
                                    //          border: Border.all(color: Colors.grey),
                                    //        borderRadius: BorderRadius.circular(0.1),
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(HomePageDataModel
                                                ?.categories?[index].appImage ??
                                            ""),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: Text(HomePageDataModel
                                                    ?.categories?[index].name ??
                                                ""),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    ));
  }
}
