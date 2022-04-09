import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';
import 'package:share/share.dart';

import '../constants.dart';

abstract class StoryDetailsRepository {
  Future<StoryDetailsModel> getStoryDetails(String lang, int? storyID);
  Future<void> shareStory(StoryDetailsModel? detailsModel);
}

class StoryDetailsRepositoryImpl extends StoryDetailsRepository {
  late http.Response storyDetailsResponse;

  @override
  Future<StoryDetailsModel> getStoryDetails(String lang, int? storyID) async {
    var url = Uri.parse("$root/story/$storyID?lang=ar");
    storyDetailsResponse = await http.get(url);

    if (storyDetailsResponse.statusCode == 200) {
      print(storyDetailsResponse.body);
      return storyDetailsModelFromJson(storyDetailsResponse.body);
    } else if (storyDetailsResponse.statusCode == 404) {
      print(storyDetailsResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load Details');
    }
  }

  @override
  Future<void> shareStory(StoryDetailsModel? detailsModel) async {
    await Share.share(
        "https://www.cooopnet.com//Story/${detailsModel!.results!.newId}");
  }
}
