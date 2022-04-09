import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

import '../constants.dart';

abstract class SocialNewsRepository {
  Future<CategoryModel> getSocialNews(String lang, int? sectionId);
}

class SocialNewsRepositoryImpl extends SocialNewsRepository {
  late http.Response socialNewsResponse;

  @override
  Future<CategoryModel> getSocialNews(String lang, int? sectionId) async {
    var url = Uri.parse("$root/section/$sectionId?lang=ar");
    socialNewsResponse = await http.get(url);

    if (socialNewsResponse.statusCode == 200) {
      print(socialNewsResponse.body);
      return categoryModelFromJson(socialNewsResponse.body);
    } else if (socialNewsResponse.statusCode == 404) {
      print(socialNewsResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load');
    }
  }
}
