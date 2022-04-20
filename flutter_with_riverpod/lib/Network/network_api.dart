import 'dart:convert';

import 'package:flutter/services.dart';


import '../model/data_model.dart';
//Crete ReadjsonData Function
Future<DataModel> readJsonData() async {

  try {
    //Access Json File From Asset
    final jsondata = await rootBundle.loadString('assets/data.json');


    final list = json.decode(jsondata);

    return DataModel.fromJson(list);
  } on Exception catch (e) {
    throw Exception(e);

    
  }

  
}