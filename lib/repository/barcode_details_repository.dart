import 'package:http/http.dart' as http;
import 'package:eqaila_app/models/models.dart';

abstract class BarcodeDetailsRepository {
  Future<List<BarcodeModel>> getBarcodeItem(String barcode);
}

class BarcodeDetailsRepositoryImpl extends BarcodeDetailsRepository {
  late http.Response barCodeResponse;

  @override
  Future<List<BarcodeModel>> getBarcodeItem(String barcode) async {
    var url = Uri.parse(
        "https://intapi.cooopnet.com/api/v1/items/getbybarcode/$barcode");
    barCodeResponse = await http.get(url);

    if (barCodeResponse.statusCode == 200) {
      print(barCodeResponse.body);
      return barcodeModelFromJson(barCodeResponse.body);
    } else if (barCodeResponse.statusCode == 404) {
      print(barCodeResponse.body);
      throw Exception('Status Code = 404');
    } else {
      throw Exception('Failed to load post');
    }
  }
}
