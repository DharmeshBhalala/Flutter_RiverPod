import 'dart:convert';

import 'package:flutter/services.dart';


import '../model/canada_model.dart';
//Crete ReadjsonData Function
Future<Canada> ReadJsonData() async {

  //Store jsonData in local
  final jsondata = await rootBundle.loadString('assets/data.json');

  final list = json.decode(jsondata);

  return Canada.fromJson(list);
}