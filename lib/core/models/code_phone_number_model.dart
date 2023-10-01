class CodePhoneNumberModel {
  final String name;
  final String code;
  final String flag;
  final String regionalNumber;
  final String minPhoneLength;
  final String maxPhoneLength;

  CodePhoneNumberModel({
    required this.name,
    required this.code,
    required this.flag,
    required this.regionalNumber,
    required this.minPhoneLength,
    required this.maxPhoneLength,
  });
  factory CodePhoneNumberModel.fromMap(Map<String, dynamic> map) {
    return CodePhoneNumberModel(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      flag: map['flag'] ?? '',
      regionalNumber: map['regionalNumber'] ?? '',
      minPhoneLength: map['minPhoneLength'] ?? '',
      maxPhoneLength: map['maxPhoneLength'] ?? '',
    );
  }
}
