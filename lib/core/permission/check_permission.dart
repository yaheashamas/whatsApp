import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  static Future<bool> isStoragePermission() async {
    var isStorage = await Permission.storage.status;
    print(isStorage);
    if (isStorage.isDenied) {
      await Permission.storage.request();
      if (isStorage.isGranted) {
        return true;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
