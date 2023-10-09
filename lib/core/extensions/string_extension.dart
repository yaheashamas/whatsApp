// ignore_for_file: unnecessary_this

extension StringExtension on String {
  String get removeAllCaracter {
   return this.replaceAll(RegExp(r'[\s\(\)-]'), '');
  }
}
