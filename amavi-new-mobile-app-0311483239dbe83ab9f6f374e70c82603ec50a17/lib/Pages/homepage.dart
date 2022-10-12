
import 'package:amavinewapp/Pages/search_product_page.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/LoginModel.dart';
import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../widget/my_cart_badge_btn.dart';
import '../widget/my_drawer.dart';
import 'Brandpage.dart';
import 'Profilepage.dart';
import 'favoritepage.dart';
import 'homepage1.dart';


class homepage extends StatefulWidget {
  LoginModel? loginModel1;
  bool? istruefirsttime;
  homepage(this.loginModel1,this.istruefirsttime);

  @override
  State<homepage> createState() => _homepageState(loginModel1,istruefirsttime);
}
class _homepageState extends State<homepage> {
  LoginModel? loginModel1;
  bool? istruefirsttime;

  _homepageState(this.loginModel1, this.istruefirsttime);
  // ignore: prefer_final_fields
  List<Widget> _widgetOptions() {
    return [
      homepage1(loginModel1, istruefirsttime!),
      brandpage(),
      favoritepage(),
      profilepage(),
    ];
  }
int index = 0;
void _onItemTapped(int index1) {
  setState(() {
    index = index1;
  });
}
  refresh() async {
    //setState(() async
    {
      // var _loginMyResponse = await homedata().GetHomeData(context);
      //
      // // var jsonResponse =
      // // convert.jsonDecode(_loginMyResponse) as Map<String, dynamic>;
      //
      // print("jigar the response l_loginMyResponse with new token is  " +
      //     _loginMyResponse.toString());
      // HomePageDataModel = null;
      // HomePageDataModel = LoginModel.fromJson(_loginMyResponse);
      //
      // setState(() {
      //   Constants.loginModelConstant = HomePageDataModel;
      //   Constants.strBottomHProfile = HomePageDataModel.textProfile;
      // });

      //all the reload processes
//       categoryListModel.products.clear();
//       getBrandProductList(context, strCategoryUrl, false);
//       getCartListDetails(context);

      //});

    }
  }
  GlobalKey<ScaffoldState> homeScaffold = new GlobalKey<ScaffoldState>();
@override
Widget build(BuildContext context) {

  var scaffoldKey=new  GlobalKey<ScaffoldState>();
  return Scaffold(
    key:  homeScaffold,
    drawer:   MyDrawer(placeHolderloginModel:loginModel1,),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading:  IconButton(
          iconSize: MediaQuery.of(context).size.height/100* 4.5,
          splashColor: AppColors.appSecondaryOrangeColor,
          icon:Icon(Icons.menu_outlined),


           // progress: _animationController,

          onPressed: () {
            homeScaffold.currentState?.openDrawer();
          },
        ),
        actions: [
          Row(
            children: [
                MyCartBadgeBtn(scaffoldKey: scaffoldKey),
              // Badge(
              //   badgeContent: Text('3'),
              //   child: Icon(MdiIcons.cart),
              // ),
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
                        MaterialPageRoute(builder: (context) {
                          return SearchListPage();
                        }),
                      )
                    }),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
        iconTheme: IconThemeData(color: AppColors.appSecondaryOrangeColor),
        title: Image.asset('assets/images/app_text_logo.png',
            height: 30, width: 100, fit: BoxFit.fill),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.appSecondaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: index, //New

        onTap: (value) {
          // Respond to item press.
          _onItemTapped(value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(MdiIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Brand',
            icon: Icon(MdiIcons.tag),
          ),
          BottomNavigationBarItem(
            label: 'Whishlist',
            icon: Icon(MdiIcons.heart),
          ),
          BottomNavigationBarItem(
            label: 'Profie',
            icon: Icon(MdiIcons.account),
          ),
        ],
      ),
      body:
      // _widgetOptions().elementAt(index)
    IndexedStack(
      index:index ,
      children: _widgetOptions(),
    )


  );
}
}

