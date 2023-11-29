import 'package:hive_flutter/hive_flutter.dart';

import 'local_db_routes.dart';

class LocalDB {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Future.wait(LocalDBRoutes.routes.map((e) => Hive.openBox(e)));
  }

  static String? get userName => Hive.box(LocalDBRoutes.userRoute).get('user_name');

  static Future<void> setUserName(String name) async {
    await Hive.box(LocalDBRoutes.userRoute).put('user_name', name);
  }
}
