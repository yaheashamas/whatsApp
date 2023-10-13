// ignore_for_file: unnecessary_this

extension StringExtension on String {
  String get removeAllCaracter {
    return this.replaceAll(RegExp(r'[\s\(\)-]'), '');
  }

  String get cutText {
    return this.length > 30 ? this.substring(1, 30) + "..." : this;
  }
}
