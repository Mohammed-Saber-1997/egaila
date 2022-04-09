import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

import '../constants.dart';

abstract class HomeSliderRepository {
  Future<HomeSliderModel> getSliderRequest(String lang);
  Future<SectionsModel> getSections(String lang);
}

class HomeSliderRepositoryImpl extends HomeSliderRepository {
  late http.Response homesSliderResponse;
  late http.Response sectionsResponse;

  @override
  Future<HomeSliderModel> getSliderRequest(String lang) async {
    var url = Uri.parse("$root/HomeSlider?lang=ar");
    //https://admin.egailacoop.com/HomeSlider?lang=ar
    homesSliderResponse = await http.get(url);

    if (homesSliderResponse.statusCode == 200) {
      print(homesSliderResponse.body);
      return homeSliderModelFromJson(homesSliderResponse.body);
    } else if (homesSliderResponse.statusCode == 404) {
      print(homesSliderResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<SectionsModel> getSections(String lang) async {
    var url = Uri.parse("$root/mainMenu?lang=ar");
    sectionsResponse = await http.get(url);

    if (sectionsResponse.statusCode == 200) {
      print(sectionsResponse.body);
      return sectionsModelFromJson(sectionsResponse.body);
    } else if (sectionsResponse.statusCode == 404) {
      print(sectionsResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class NetworkError extends Error {}
