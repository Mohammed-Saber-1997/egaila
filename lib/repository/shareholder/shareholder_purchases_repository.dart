import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/models/salesInvoice/get_sales_invoice_by_server_key_model.dart';

abstract class ShareholderPurchasesRepository {
  Future<List<ShareholderPurchasesModel>> getShareholderPurchasesList(
      String membershipId);

  Future<List<ShareholderPurchasesModel>> getPurchasesListByDate(
      String? customerId, String? fromDate, String? toDate);

  Future<GetSalesInvoiceByServerKeyModel> getSalesInvoiceByServerKey(
      String serverKey);
}

class ShareholderPurchasesRepositoryImpl
    extends ShareholderPurchasesRepository {
  late http.Response shareholderPurchasesListResponse;
  late http.Response salesInvoiceResponse;
  List<ShareholderPurchasesModel> _list = [];

  @override
  Future<List<ShareholderPurchasesModel>> getShareholderPurchasesList(
      String membershipId) async {
    _list.clear();
    var url = Uri.parse(
        "https://intapi.cooopnet.com/api/v1/Sales/getinvoicesbrieflist/$membershipId");
    shareholderPurchasesListResponse = await http.get(url);

    if (shareholderPurchasesListResponse.statusCode == 200) {
      List<dynamic>? values = [];
      values = json.decode(shareholderPurchasesListResponse.body);
      if (values!.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _list.add(ShareholderPurchasesModel.fromJson(map));
            print(_list[0].locationName);
          }
        }
      }
      return _list;
    } else if (shareholderPurchasesListResponse.statusCode == 404) {
      print(shareholderPurchasesListResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<List<ShareholderPurchasesModel>> getPurchasesListByDate(
      String? customerId, String? fromDate, String? toDate) async {
    _list.clear();
    var url = Uri.parse(
        "https://intapi.cooopnet.com/api/v1/Sales/GetCustomerBriefInvoicesFromDateToDate?Customer_ID=$customerId&F_Date=$fromDate&T_Date=$toDate");
    shareholderPurchasesListResponse = await http.get(url);

    if (shareholderPurchasesListResponse.statusCode == 200) {
      List<dynamic>? values = [];
      values = json.decode(shareholderPurchasesListResponse.body);
      if (values!.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _list.add(ShareholderPurchasesModel.fromJson(map));
            print(_list[0].locationName);
          }
        }
      }
      return _list;
    } else if (shareholderPurchasesListResponse.statusCode == 404) {
      print(shareholderPurchasesListResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<GetSalesInvoiceByServerKeyModel> getSalesInvoiceByServerKey(
      String serverKey) async {
    var url = Uri.parse(
        "https://intapi.cooopnet.com/api/v1/Sales/GetSalesInvoiceByServerKey?SERVER_KEY=$serverKey");
    salesInvoiceResponse = await http.get(url);
    if (salesInvoiceResponse.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>>looooooooooooooooad 200:' +
          salesInvoiceResponse.body);
      return getSalesInvoiceByServerKeyModelFromJson(salesInvoiceResponse.body);
    } else if (salesInvoiceResponse.statusCode == 404) {
      print(salesInvoiceResponse.body);
      throw Exception('Status Code = 404');
    } else {
      print("failed to looooooooooooooooad");
      throw Exception('Failed to load post');
    }
  }
}
