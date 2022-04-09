import 'package:http/http.dart' as http;

abstract class ReportItemRepository {
  Future sendReportInfo(String name, String mobile, String message,
      String? imageBytes, var imageExtension);
}

class ReportItemRepositoryImpl extends ReportItemRepository {
  late http.Response reportResponse;

  @override
  Future sendReportInfo(String name, String mobile, String message,
      String? imageBytes, var imageExtension) async {
    var url = Uri.parse("https://api.cooopnet.com/api/Particibate/Add");
    reportResponse =
        await http.post(url, body: {
      "Name": name,
      "Mobile": mobile,
      "Message": message,
      "Base64String": imageBytes,
      "Extension": imageExtension,
    });

    if (reportResponse.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>> 200:' + reportResponse.body);
    } else if (reportResponse.statusCode == 404) {
      print(reportResponse.body);
      throw Exception('Status Code = 404');
    } else {
      print("failed to looooooooooooooooad");
      throw Exception('Failed to load post');
    }
  }
}
