import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../helper/theme_pref.dart';

class AppConstants{
  static const String countryCode =   '+2';
  static const double pagePadding = 16;
}
bool isNotNew = CacheHelper.getBoolean(key: 'isNotNew');


///dateTime format
var formatter = NumberFormat("#,##0.00", "en_US");
var format = DateFormat.yMMMEd('ar');

var timeFormat = DateFormat.jm('ar');
///dateTime format
bool isDark = CacheHelper.getBoolean(key: 'isDark');