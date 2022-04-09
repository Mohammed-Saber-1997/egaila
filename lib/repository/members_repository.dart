import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

import '../constants.dart';

abstract class MembersRepository {
  Future<AllWorkMembersModel> getAllWorkMembers();
  Future<SingleWorkMemberModel> getSingleWorkMember(String lang, int? workerID);
}

class MembersRepositoryImpl extends MembersRepository {
  late http.Response allWorkMembersResponse;
  late http.Response singleWorkMemberResponse;

  @override
  Future<AllWorkMembersModel> getAllWorkMembers() async {
    var url = Uri.parse("$root/Editors");
    allWorkMembersResponse = await http.get(url);

    if (allWorkMembersResponse.statusCode == 200) {
      print(allWorkMembersResponse.body);
      return allWorkMembersModelFromJson(allWorkMembersResponse.body);
    } else if (allWorkMembersResponse.statusCode == 404) {
      print(allWorkMembersResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<SingleWorkMemberModel> getSingleWorkMember(
      String lang, int? workerID) async {
    var url = Uri.parse("$root/Editor/$workerID?lang=ar");
    singleWorkMemberResponse = await http.get(url);

    if (singleWorkMemberResponse.statusCode == 200) {
      print(singleWorkMemberResponse.body);
      return singleWorkMemberModelFromJson(singleWorkMemberResponse.body);
    } else if (singleWorkMemberResponse.statusCode == 404) {
      print(singleWorkMemberResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }
}
