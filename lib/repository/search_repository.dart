import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

import '../constants.dart';

abstract class SearchRepository {
  Future<AdvancedSearchModel> getBySearchWordRequest(
    String lang,
    String searchWord,
    int sectionId,
    String fromDate,
    String toDate,
    int lastId,
  );
}

class SearchRepositoryImpl extends SearchRepository {
  late http.Response advancedSearchResponse;

  @override
  Future<AdvancedSearchModel> getBySearchWordRequest(
    String lang,
    String searchWord,
    int sectionId,
    String fromDate,
    String toDate,
    int lastId,
  ) async {
    var url = Uri.parse(
        "$root/AdvancedSearch?keyWord=$searchWord&sectionID=$sectionId&fromDate=$fromDate&toDate=$toDate&lastId=$lastId&lang=ar");
    advancedSearchResponse = await http.get(url);

    if (advancedSearchResponse.statusCode == 200) {
      print(advancedSearchResponse.body);
      return advancedSearchModelFromJson(advancedSearchResponse.body);
    } else if (advancedSearchResponse.statusCode == 404) {
      print(advancedSearchResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
    //throw UnimplementedError();
  }
}
