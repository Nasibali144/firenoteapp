import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DBService {
  static const String dbName = "db_posts";
  static Box box = Hive.box(dbName);

  static Future<void> storeMode(bool isLight) async {
    await box.put("isLight", isLight);
  }

  static bool loadMode() {
    return box.get("isLight", defaultValue: true);
  }

  static Future<void> storeString(StorageKeys key, String value) async {
    await box.put(_getKey(key), value);
  }

  static String? loadString(StorageKeys key) {
    String? value = box.get(_getKey(key));
    return value;
  }

  static Future<void> removeString(StorageKeys key) async {
    await box.delete(_getKey(key));
  }

  static String _getKey(StorageKeys key) {
    switch(key) {
      case StorageKeys.UID: return "uid";
      case StorageKeys.FIRSTNAME: return "firstname";
      case StorageKeys.LASTNAME: return "lastname";
    }
  }
}

enum StorageKeys {
  UID,
  LASTNAME,
  FIRSTNAME,
}