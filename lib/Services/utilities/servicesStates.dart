import 'dart:convert';

import 'package:covid_tracker/Services/utilities/appUrl.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/Model/worldStatesModel.dart';
class statesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppiUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }


  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppiUrl.countriesApi));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error');
    }
  }
}