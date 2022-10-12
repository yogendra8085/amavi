

import 'package:amavinewapp/Model/CartListModel.dart';
import 'package:amavinewapp/apicaling/getcartapicalling.dart';
import 'package:amavinewapp/apicaling/removecartproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:amavinewapp/constantpages/Constants.dart'as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/TokenModel.dart';
import '../apicaling/updatequanity.dart';
import '../constantpages/colors.dart';

class cartlistpage extends StatefulWidget {
 // const cartlistpage({Key? key}) : super(key: key);

  @override
  State<cartlistpage> createState() => _cartlistpageState();
}

class _cartlistpageState extends State<cartlistpage> {

  String ?strToken;
  String ?strLangCode;
 CartListModel ?cartListModel;
 int quanity=0;
  initController() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    strToken = prefs.getString(Constants.TokenDetailsTag.TAG_TOKEN);
    strLangCode = prefs.getString(Constants.UserDetailsTag.LANG_CODE);
    setState(() {

    });

    var user= await getcartapi().getCartListDetails();
    print(user);
    cartListModel = CartListModel.fromJson(user);

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
    print(cartListModel?.products?.length);
    print(cartListModel?.totals?[0].title
        .toString());
    print(cartListModel?.totals?[0].text
        .toString());

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),

          onPressed: () {
            // if (scaffoldKey != null) {
            //   scaffoldKey.currentState.setState(() {
            //     HomeBottomScreenState.showAppbar = true;
            //   });
            // }
            Navigator.of(context).pop();
          },
          // onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:cartListModel==null?Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((cartListModel?.headingTitle).toString(),style :TextStyle(color: AppColors.black,
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
              for(int i =0;i<(cartListModel?.products?.length)!.toInt();i++)...[

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
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(image: NetworkImage((cartListModel?.products?[i].thumb).toString()),width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text((cartListModel?.products?[i].name).toString(),  style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Poppins",
                                        fontSize:MediaQuery.of(context).size.height/100 *
                                            1.5,
                                      ),

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Model: '+(cartListModel?.products?[i].model).toString(), style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight:
                                        FontWeight.normal,
                                        fontFamily: "Poppins",
                                        fontSize: MediaQuery.of(context).size.height/100*
                                            1.4,
                                      ),

                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('Unit Price: ',style: TextStyle(fontSize: MediaQuery.of(context).size.height/100
                                              *
                                              1.4,),),
                                        ),
                                        Text((cartListModel?.products?[i].price).toString(),style: TextStyle(
//                  fontFamily: "Viaoda",
                                          fontWeight:
                                          FontWeight
                                              .normal,
                                          fontSize: MediaQuery.of(context).size.height/100
                                              *
                                              1.4,

                                          color: AppColors
                                              .appSecondaryOrangeColor,
                                        ),),
                                      ],
                                    ),
                                    Row(

                                      children: [

                                        Text("Quanity",style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight:
                                          FontWeight.normal,
                                          fontFamily: "Poppins",
                                          fontSize: MediaQuery.of(context).size.height/100*
                                              1.4,
                                        ) ,),
                                        InkWell(
                                            onTap: () async {
                                              await updatequanity(strToken).updateQuantity(context,(cartListModel?.products?[i].cartId).toString() , int.parse((cartListModel?.products?[i].quantity).toString())-1).then((value) {
                                                initController();
                                              });
                                            },
                                            child: Image.asset('assets/images/ic_minus_icon.png',width:25,height: 25,)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text((cartListModel?.products?[i].quantity).toString()),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                           await updatequanity(strToken).updateQuantity(context,(cartListModel?.products?[i].cartId).toString() , int.parse((cartListModel?.products?[i].quantity).toString())+1).then((value) {
                                             initController();
                                           });
                                          },

                                            child: Image.asset('assets/images/ic_plus_icon.png',width: 25,height: 25,),


                                        ),
                                      ],
                                    )
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
                                  // Padding(
                                  //   padding: const EdgeInsets.all(3.0),
                                  //   child: Container(
                                  //     width:MediaQuery.of(context).size.width/100*25 ,
                                  //     height: 40,
                                  //     decoration: BoxDecoration(
                                  //       color: AppColors.appSecondaryColor,
                                  //       borderRadius: BorderRadius.circular(5),
                                  //
                                  //     ),
                                  //     child: Center(
                                  //       child: Text("Add to Cart"),
                                  //     ),
                                  //   ),
                                  // ),
                                  Row(
                                    children: [
                                      Text("Total : ",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height/100
                                          *
                                          1.4,),),
                                      Text((cartListModel?.products?[i].price).toString(),style: TextStyle(color: Colors.grey[600],fontSize: MediaQuery.of(context).size.height/100
                                          *
                                          1.4,))
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                    await  removecartroduct(strToken).removeProduct(context, (cartListModel?.products?[i].cartId).toString()).then((value) {
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
                                          child: Text("Remove",style: TextStyle(fontSize: MediaQuery.of(context).size.height/100
                                              *
                                              1.4,
                                            color: Colors.white,

                                          ),),
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
              for(int i =0;i<(cartListModel?.totals?.length)!.toInt();i++)
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   color: new Color(0xFFFFFFFF),
                  // border: Border.all(color: AppColors.appSecondaryColor),
                   shape: BoxShape.rectangle,
                   borderRadius: new BorderRadius.circular(5.0),
                   boxShadow: <BoxShadow>[
                     new BoxShadow(
                       color: Colors.black12,
                       blurRadius: 10.0,
                       offset: new Offset(0.0, 10.0),
                     ),
                   ],
                 ),
                 child:Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                         Text((cartListModel?.totals?[i].title).toString(),
                         style: TextStyle(color:cartListModel?.totals?[i].title=="Total"?AppColors.appSecondaryOrangeColor:Colors.black ),
                         ),
                     Text((cartListModel?.totals?[i].text).toString(),

                 style: TextStyle(color:cartListModel?.totals?[i].title=="Total"?AppColors.appSecondaryOrangeColor:Colors.black ),
                     ),
                     ],
                   ),
                 ) ,
               ),
             ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height/100*5 ,
                  decoration: BoxDecoration(
                    color: AppColors.appSecondaryOrangeColor,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Text(
                      'CONTINUE SHOPING',style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.normal,
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.height/100*
                          1.4,
                    ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.height/100*5 ,
                  decoration: BoxDecoration(
                      color: AppColors.appSecondaryColor,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: Text(
                        'PROCEED TO CHECKOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.normal,
                        fontFamily: "Poppins",
                        fontSize: MediaQuery.of(context).size.height/100*
                            1.4,
                      ),
                    ),
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}
