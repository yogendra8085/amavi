import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;

import 'package:awesome_notifications/awesome_notifications.dart'
    hide NotificationModel;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:singleton/singleton.dart';


import 'app.service.dart';
import 'notification.service.dart';

class FirebaseService {
  //
  /// Factory method that reuse same instance automatically
  // factory FirebaseService() =>
  //     Singleton.lazy(() => FirebaseService._()).instance;
  //
  // /// Private constructor
  //  FirebaseService._() {}=

  //
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Map ?notificationPayloadData;

  setUpFirebaseMessaging() async {
    //Request for notification permission
    /*NotificationSettings settings = */
    await firebaseMessaging.requestPermission();
    //subscribing to all topic
    firebaseMessaging.subscribeToTopic("all");

    //on notification tap tp bring app back to life
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      saveNewNotification(message);

      selectNotification("From onMessageOpenedApp");
      // showNotification(message);
    });

    //normal notification listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().dismissAllNotifications();
      showNotification(message);
    });
  }

  saveNewNotification(RemoteMessage message) {
    notificationPayloadData = jsonDecode(message.data["bodyText"])?? null;
  }

  Future selectNotification(String payload) async {
    if (payload == null) {
      return;
    }
    try {
      log("NotificationPaylod ==> ${jsonEncode(notificationPayloadData)}");
      //
      if (notificationPayloadData != null && notificationPayloadData is Map) {
        var productId = notificationPayloadData?['productID'];

      //   Navigator.push(
      //           AppService().navigatorKey.currentContext,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   ProductDetailPage(productId, false, null)),
      //         );
      }
    } catch (error) {
      print("Error opening Notification ==> $error");
    }
  }

  //
  showNotification(RemoteMessage message) async {
    try {
    notificationPayloadData = jsonDecode(message.data["bodyText"]);
      String? imageUrl;
      String ?title;
      String ?messageNotification;

      try {
        imageUrl = notificationPayloadData?["productImage"];
        if (message.notification?.title != null ) {
          title = message.notification?.title??notificationPayloadData?["title"];
          messageNotification =message.notification?.body?? notificationPayloadData?["body"];
        } else {
          title = message.notification?.body??notificationPayloadData?["body"];
          messageNotification = "";
        }
      } catch (error) {
        print("error getting notification image");
      }

      //
      if (imageUrl != null) {
        //
        AwesomeNotifications().dismissAllNotifications();
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: Random().nextInt(20),
            channelKey: (NotificationService.appNotificationChannel().channelKey).toString(),
            title: title,
            body: messageNotification,
            largeIcon: imageUrl,
            roundedBigPicture: true,
            wakeUpScreen: true,
            //
            // largeIcon: imageUrl,
            // roundedLargeIcon:true,
            icon: "resource://drawable/notification_icon",
            notificationLayout: imageUrl != null
                ? NotificationLayout.BigPicture
                : NotificationLayout.Default,
            payload: Map<String, String>.from(message.data),
          ),
        );
      } else {
        //
        AwesomeNotifications().dismissAllNotifications();
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: Random().nextInt(20),
            channelKey: (NotificationService.appNotificationChannel().channelKey).toString(),
            title: title,
            body: messageNotification,
            icon: "resource://drawable/notification_icon",
            notificationLayout: NotificationLayout.Default,
            payload: Map<String, String>.from(message.data),
          ),
        );
      }

      ///
    } catch (error) {
      print("Notification Show error ===> ${error}");
    }
  }
}
