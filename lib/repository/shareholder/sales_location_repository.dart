import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

import '../../constants.dart';

abstract class SalesLocationRepository {
  Future<List<SalesLocationModel>> getSalesLocation();
}

class SalesLocationRepositoryImpl extends SalesLocationRepository {
  late http.Response locationListResponse;
  List<SalesLocationModel> _locationList = [];

  @override
  Future<List<SalesLocationModel>> getSalesLocation() async {
    var url = Uri.parse("$BASE_URL_B/Sales/GetSalesLocationAsync");
    locationListResponse = await http.get(url);

    if (locationListResponse.statusCode == 200) {
      List<dynamic>? values = [];
      values = json.decode(locationListResponse.body);
      if (values!.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _locationList.add(SalesLocationModel.fromJson(map));
            print(_locationList[0].locationName);
          }
        }
      }
      return _locationList;
    } else {
      print('Error: ${locationListResponse.statusCode}');
      throw Exception('Status Code = 404');
    }
  }
}
