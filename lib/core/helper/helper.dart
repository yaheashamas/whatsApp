import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:whats_app/core/constants/const_data.dart';
import 'package:whats_app/core/models/code_phone_number_model.dart';

class Helper {
  Future<List<CodePhoneNumberModel>> getAllCountries() async {
    var jsonData = await rootBundle.loadString('assets/data/contries.json');
    final data = json.decode(jsonData);
    // List<CodePhoneNumberModel> allCountries = [];
    for (var element in data['data'] as List) {
      allCountries.add(CodePhoneNumberModel.fromMap(element));
    }
    allCountries.sort((a, b) => a.name.compareTo(b.name));
    return allCountries;
  }
}
