import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/data_model.dart';

final getDataModelFuture =
    ChangeNotifierProvider<JSONParser>((ref) => JSONParser());

class JSONParser extends ChangeNotifier {
  DataModel? dataModel;
  JSONParser() {
    readJsonData();
  }

  Future<void> readJsonData() async {

  try {
    //Access Json File From Asset
    final jsondata = await rootBundle.loadString('assets/data.json');

    final list = json.decode(jsondata);

    dataModel = DataModel.fromJson(list);
  } on Exception catch (e) {
    throw Exception(e);
  }
  notifyListeners();
}
//Crete ReadjsonData Function

}