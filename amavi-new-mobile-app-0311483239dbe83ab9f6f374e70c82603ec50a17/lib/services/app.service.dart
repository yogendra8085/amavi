import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

import 'package:intl/intl.dart' as intl;
import 'package:singleton/singleton.dart';

class AppService {
  //

  /// Factory method that reuse same instance automatically
  factory AppService() => Singleton.lazy(() => AppService._()).instance;

  /// Private constructor
  AppService._() {}

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
