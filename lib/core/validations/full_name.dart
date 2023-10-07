import 'package:formz/formz.dart';

class FullName extends FormzInput<String, String> {
  const FullName.pure() : super.pure('');
  const FullName.dirty(String value) : super.dirty(value);

  static final RegExp fullNameRegExp = RegExp(r'^(([a-zA-Z]{3,10})+\s?){3,6}$');

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return "Requed";
    } else if (!fullNameRegExp.hasMatch(value)) {
      return "Please Enter Full Name";
    } else {
      return null;
    }
  }
}
