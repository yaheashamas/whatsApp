// ignore_for_file: avoid_print
class Print {
  static void printWarning(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  static void printError(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  static void printInfo(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  static void printSuccess(String text) {
    print('\x1B[32m$text\x1B[0m');
  }
}
