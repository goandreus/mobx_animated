import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx_animated/models/city_model.dart';

class CitiesRepository {
  
  Future<List<CityModel>> getCitiesByState(String state) async {
    var jsonFile = await rootBundle.loadString('assets/city.json');
    List<dynamic> cities = json.decode(jsonFile) as List;
    return cities
      .map((c) => CityModel.fromMap(c))
      .where((c) => c.state == state)
      .toList();
  }
}