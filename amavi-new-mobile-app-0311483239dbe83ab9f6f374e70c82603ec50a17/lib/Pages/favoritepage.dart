import 'package:amavinewapp/Model/WishListModel.dart';
import 'package:amavinewapp/apicaling/wishlistapicalling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constantpages/SizeConfig.dart';
import '../constantpages/colors.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';

class favoritepage extends StatefulWidget {
  const favoritepage({super.key});

  @override
  State<favoritepage> createState() => _favoritepageState();
}

class _favoritepageState extends State<favoritepage> {
  String ?strToken;
  String ?strLangCode;
  WishListModel ?wishListModel;
  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strLangCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    setState(() {

    });

   var user= await wishlist(strToken). getWishListDetails(context);
   print(user);
   wishListModel=WishListModel.fromJson(user);
   setState(() {

   });

    // refresh();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 450));

    //startTime();
  }
  @override
  Widget build(BuildContext context) {
    print(strToken);
    print(wishListModel?.products?.length);
    return wishListModel==null?Center(child: CircularProgressIndicator(),):Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("favourites",style :TextStyle(color: AppColors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Bordeaux",),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: Divider(
                color: AppColors.black,
              ),
            ),
         for(int i =0;i<(wishListModel?.products?.length)!.toInt();i++)...[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

            decoration: BoxDecoration(
                color: new Color(0xFFFFFFFF),
              border: Border.all(color: AppColors.appSecondaryColor),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image(image: NetworkImage((wishListModel?.products?[i].thumb).toString()),width: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                   Text((wishListModel?.products?[i].name).toString(),  style: TextStyle(
                     color: AppColors.black,
                     fontWeight: FontWeight.normal,
                     fontFamily: "Poppins",
                     fontSize:MediaQuery.of(context).size.height/100 *
                         1.5,
                   ),

                   ),
                    Text('Model: '+(wishListModel?.products?[i].model).toString(), style: TextStyle(
                      color: AppColors.black,
                      fontWeight:
                      FontWeight.normal,
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.height/100*
                          1.4,
                    ),

                    ),
                    Text('Unit Price: '+(wishListModel?.products?[i].price).toString(),style: TextStyle(
//                  fontFamily: "Viaoda",
                      fontWeight:
                      FontWeight
                          .normal,
                      fontSize: MediaQuery.of(context).size.height/100
                          *
                          1.4,

                      color: AppColors
                          .appSecondaryOrangeColor,
                    ),)
                    ],),
                  )
                ],
              ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color:  AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(5),
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      InkWell(
                        onTap: () async {
                          await  wishlist(strToken).addToCart(context,(wishListModel?.products?[i].productId).toString() ,(wishListModel?.products?[i].quantity).toString() ).then((value) {
                            // wishlist(strToken).getWishListDetails(context);
                            initController();
                            setState(() {

                            });
                          });
                        },
                        child:Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Container(
                           width:MediaQuery.of(context).size.width/100*25 ,
                           height: 40,
                           decoration: BoxDecoration(
                             color: AppColors.appSecondaryColor,
                             borderRadius: BorderRadius.circular(5),

                           ),
                           child: Center(
                             child: Text("Add to Cart"),
                           ),
                         ),
                       ),
                          ),
                        InkWell(
                          onTap: () async {
                          await  wishlist(strToken).removeProduct(context, (wishListModel?.products?[i].productId).toString()).then((value) {
                           // wishlist(strToken).getWishListDetails(context);
                            initController();
                            setState(() {
                              
                            });
                          });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              width:MediaQuery.of(context).size.width/100*25 ,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.appSecondaryOrangeColor,
                                borderRadius: BorderRadius.circular(5),

                              ),
                              child: Center(
                                child: Text("Remove"),
                              ),
                            ),
                          ),
                        )
                     ],
                    )
                  ),

              ],
            ),
          ),

              ),
    ),

         // ListView.builder(
         //   itemCount:wishListModel?.products?.length ,
         //     scrollDirection: Axis.vertical,
         //     shrinkWrap: true,
         //     itemBuilder: (context,index)
         // {
         //   return Container(
         //     decoration: BoxDecoration(
         //         color: new Color(0xFFFFFFFF),
         //       shape: BoxShape.rectangle,
         //       borderRadius: new BorderRadius.circular(8.0),
         //       boxShadow: <BoxShadow>[
         //         new BoxShadow(
         //           color: Colors.black12,
         //           blurRadius: 10.0,
         //           offset: new Offset(0.0, 10.0),
         //         ),
         //       ],
         //     ),
         //
         //   );
         //
         // }
         // ),

          ],
            ]
        ),
      )
    );
  }
}
