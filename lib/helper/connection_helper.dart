import 'dart:io';

class ConnectionHelper {
  static bool haveConnection = false;

  static Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        haveConnection = true;
      } else {
        haveConnection = false;
      }
    } catch (e) {
      haveConnection = false;
    }
  }
}
