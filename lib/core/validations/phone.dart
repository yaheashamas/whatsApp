import 'package:formz/formz.dart';

class Phone extends FormzInput<String, String> {
  final dynamic min;
  final dynamic max;

  const Phone.pure()
      : min = 0,
        max = 0,
        super.pure('');

  const Phone.dirty({
    this.min,
    this.max,
    required String value,
  }) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return "Required";
    } else if (value.length < min || value.length > max) {
      return "count number phone number shoud be between $min and $max";
    } else {
      return null;
    }
  }
}
