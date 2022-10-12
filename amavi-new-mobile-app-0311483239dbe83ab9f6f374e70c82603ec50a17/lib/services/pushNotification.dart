// import 'dart:convert';
// import 'dart:io';
// import 'dart:math' as math;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:quiver/strings.dart';
//
//
// import 'app.service.dart';
// import 'firebase.service.dart';
// import 'package:http/http.dart' as http;
//
// bool is_Notification = false;
// Map<String, dynamic>? NotificationData;
// bool is_HomeScreenLoaded = false;
//
// /// FCM Background message handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
//
// /// Handles all the push notification related functionality of the application.
// /// Creates and refreshes [deviceToken], register notification handlers.
// abstract class PushNotificationService {
//   /*static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   /// The token to identify the device for push notifications.
//   static String _deviceToken = '';
//
//   /// Getter for deviceToken
//   String get deviceToken => _deviceToken;
//
//   /// Initializes the tasks required to run at application startup or when
//   /// the application is run for the very first time.
//   static Future<void> initialize() async {
//     await registerNotification();
//     await configLocalNotification();
//   }
//
//   /// Request permissions
//   static Future<void> requestPermissions() async {
//     await _firebaseMessaging.requestPermission();
//   }
//
//   /// Initial notification setup on application startup.
//   static Future<void> registerNotification() async {
//     // Force show notification on iOS and Android
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//
//     // Handle notification when the application is in session
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(message);
//
//       String title = 'New Notification';
//       String body = 'You have new notifications, come and check them out.';
//
//       if (message.notification != null) {
//         title = message.notification.title ?? title;
//         body = message.notification.body ?? body;
//       }
//      var data= jsonDecode(message.data["bodyText"]);
//       showNotification(
//         title: title,
//         body: body,
//         payload: data,
//       );
//     });
//
//     // Handle notification when the application is in background or terminated
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("Firebase Messaging ==> onMessageOpenedApp Clicked");
//       print(message);
//       try {
//         var notificationPayloadData = jsonDecode(message.data["bodyText"]);
//         String imageUrl;
//         String productID;
//         String title;
//         String messageNotification;
//
//         try {
//           imageUrl = notificationPayloadData["productImage"];
//           productID = notificationPayloadData["productID"];
//           if (notificationPayloadData["title"] != null) {
//             title = message.notification.title??notificationPayloadData["title"];
//             messageNotification =message.notification.body?? notificationPayloadData["message"];
//           } else {
//             title = message.notification.body??notificationPayloadData["message"];
//             messageNotification = "";
//           }
//         } catch (error) {
//           print("error getting notification image");
//         }
//         //
//         if (imageUrl != null) {
//
//         }
//         ///
//       } catch (error) {
//         print("Notification Show error ===> ${error}");
//       }
//     });
//
//     // Handle background message here
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     /// FCM handler when the application wakes from a terminated state.
//     final RemoteMessage _initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//     print("Firebase Messaging==> initial method");
//     if (_initialMessage != null) {
//       RemoteNotification notification = _initialMessage.notification;
//       if (notification != null && _initialMessage.data != null) {
//         print(_initialMessage.data['category']);
//         NotificationData = _initialMessage.data;
//         is_Notification = true;
//       }
//       print("Firebase Messaging ==> _initialMessage");
//       // It means the application woke up from a terminated state.
//       // Probably add to notifications storage
//     }
//   }
//
//   /// Configure how the local notifications are shown to the user when the
//   /// application is in different states.
//   static Future<void> configLocalNotification() async {
//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     const initializationSettingsIOS = IOSInitializationSettings();
//     const initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (payload) async {
//       print(payload);
//       // var notificationPayloadData =  jsonDecode(jsonDecode(payload)['bodyText'])['productID'];
//       if (payload != null && payload.isNotEmpty) {
//
//         Navigator.push(
//           AppService().navigatorKey.currentContext,
//           MaterialPageRoute(
//               builder: (context) => ProductDetailPage(payload, false, null)),
//         );
//       }
//       return;
//     });
//   }
//  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     final http.Response response = await http.get(Uri.parse(url));
//     final File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }
//   static AndroidNotificationChannel channel = const AndroidNotificationChannel(
//       'app notification', // id
//       'App Related Notification', // title
//       description: '',
//       importance: Importance.high,
//       playSound: true);
//
//    static Future<void> showNotification({
//     @required String title,
//     @required String body,
//     dynamic payload,
//   }) async {
//     const androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'main_notification_channel',
//       'All Notifications',
//       channelDescription: 'Processes all notifications',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.max,
//       visibility: NotificationVisibility.public,
//       ticker: 'Notification',
//     );
//     const iOSPlatformChannelSpecifics = IOSNotificationDetails(
//       presentAlert: true,
//       presentSound: true,
//     );
//     const platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     BigPictureStyleInformation bigPictureStyleInformation;
//
//     var imageUrl = payload["productImage"];
//     var productId = payload["productID"];
//
//     if (imageUrl != null) {
//       String bigPicturePath =
//       await _downloadAndSaveFile(imageUrl, 'bigPicturePath');
//       String largeIconPath =
//       await _downloadAndSaveFile(imageUrl, 'largeIconPath');
//
//       // largeIcon: const DrawableResourceAndroidBitmap('drawable/app_icon'),
//
//       bigPictureStyleInformation = BigPictureStyleInformation(
//         FilePathAndroidBitmap(bigPicturePath),
//         // largeIcon: const DrawableResourceAndroidBitmap('@mipmap/notification_icon'),
//         largeIcon: FilePathAndroidBitmap(largeIconPath),
//         contentTitle: title,
//         htmlFormatContentTitle: true,
//         summaryText:body,
//         htmlFormatSummaryText: true,
//       );
//     }
//     final int _notificationId = math.Random().nextInt(100);
//     await _flutterLocalNotificationsPlugin.show(
//       _notificationId,
//       title,
//       body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           playSound: true,
//           icon: '@mipmap/notification_icon',
//           styleInformation: bigPictureStyleInformation,
//           priority: Priority.high,
//           importance: Importance.max,
//         ),
//       ),
//       payload: productId,
//     );*/
//
//    /* flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             playSound: true,
//             icon: '@mipmap/notification_icon',
//             styleInformation: bigPictureStyleInformation,
//             priority: Priority.high,
//             importance: Importance.max,
//           ),
//         ),
//         payload: message.data == null ? '' : productId);*/
//   // }
// }
