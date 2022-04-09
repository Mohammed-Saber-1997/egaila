import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

abstract class SignInShareholderRepository {
  Future<List<SignInShareholderModel>> getSignInShareholderData(
      String id, String membershipId);
}

class SignInShareholderRepositoryImpl extends SignInShareholderRepository {
  late http.Response signInShareholderResponse;

  List<SignInShareholderModel> _signInShareholderModel = [];

  @override
  Future<List<SignInShareholderModel>> getSignInShareholderData(
      String id, String membershipId) async {
    var url = Uri.parse(
        "https://intapi.cooopnet.com/api/v1/Shh/GetByCivilIdAndMembership?Shh_Civil_Id=$id&Shh_Membership_Id=$membershipId");
    // "$BASE_URL_B/Shh/GetByCivilIdAndMembership?Shh_Civil_Id=$id&Shh_Membership_Id=$membershipId");
    signInShareholderResponse = await http.get(url);

    if (signInShareholderResponse.statusCode == 200) {
      print(signInShareholderResponse.body);

      List<dynamic>? values = [];
      values = json.decode(signInShareholderResponse.body);
      if (values!.length > 0) {
        for (int i = 0; i < values.length; i++) {
          Map<String, dynamic> map = values[i];
          _signInShareholderModel.add(SignInShareholderModel.fromJson(map));
          print(_signInShareholderModel[0].addressID);
        }
      }
      return _signInShareholderModel; //shareholderModelFromJson(signInShareholderResponse.body);
    } else if (signInShareholderResponse.statusCode == 404) {
      print(signInShareholderResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }
}
