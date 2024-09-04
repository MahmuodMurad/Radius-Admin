import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDatabase {
  LocalDatabase._();

  static FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();
  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString(String key, String value) async {

    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {

    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    if (kDebugMode) {
      debugPrint('FlutterSecureStorage : all data has been cleared');
    }

    await flutterSecureStorage.deleteAll();
  }
}
