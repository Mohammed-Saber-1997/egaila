import 'dart:convert';

List<ShareholderPurchasesModel> shareholderPurchasesModelFromJson(String str) =>
    List<ShareholderPurchasesModel>.from(
        json.decode(str).map((x) => ShareholderPurchasesModel.fromJson(x)));

String shareholderPurchasesModelToJson(List<ShareholderPurchasesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShareholderPurchasesModel {
  int? serveRKEY;
  int? invoiceID;
  String? locationName;
  double? invoiceTotalAmount;
  String? writtenAt;

  ShareholderPurchasesModel(
      {this.serveRKEY,
      this.invoiceID,
      this.locationName,
      this.invoiceTotalAmount,
      this.writtenAt});

  ShareholderPurchasesModel.fromJson(Map<String, dynamic> json) {
    serveRKEY = json['serveR_KEY'];
    invoiceID = json['invoice_ID'];
    locationName = json['location_Name'];
    invoiceTotalAmount = json['invoice_Total_Amount'];
    writtenAt = json['written_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serveR_KEY'] = this.serveRKEY;
    data['invoice_ID'] = this.invoiceID;
    data['location_Name'] = this.locationName;
    data['invoice_Total_Amount'] = this.invoiceTotalAmount;
    data['written_At'] = this.writtenAt;
    return data;
  }
}
