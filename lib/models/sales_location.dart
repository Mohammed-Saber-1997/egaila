import 'dart:convert';

List<SalesLocationModel> salesLocationModelFromJson(String str) =>
    List<SalesLocationModel>.from(
        json.decode(str).map((x) => SalesLocationModel.fromJson(x)));

String salesLocationModelToJson(List<SalesLocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalesLocationModel {
  int? locationID;
  String? locationName;

  SalesLocationModel({this.locationID, this.locationName});

  SalesLocationModel.fromJson(Map<String, dynamic> json) {
    locationID = json['location_ID'];
    locationName = json['location_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_ID'] = this.locationID;
    data['location_Name'] = this.locationName;
    return data;
  }
}
