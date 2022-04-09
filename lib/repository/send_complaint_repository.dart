import 'package:http/http.dart' as http;

abstract class SendComplaintRepository {
  Future sendComplaint(String name, String mobile, String message);
}

class SendComplaintRepositoryImpl extends SendComplaintRepository {
  late http.Response complaintResponse;

  @override
  Future sendComplaint(String name, String mobile, String message) async {
    var url = Uri.parse("https://api.cooopnet.com/api/Complaint/Add");
    complaintResponse = await http.post(
        url,
        body: {"Name": name, "Mobile": mobile, "Message": message});

    if (complaintResponse.statusCode == 200) {
      print('>>>>>>>>>>>>>>>>>> 200:' + complaintResponse.body);
    } else if (complaintResponse.statusCode == 404) {
      print(complaintResponse.body);
      throw Exception('Status Code = 404');
    } else {
      print("failed to looooooooooooooooad");
      throw Exception('Failed to load post');
    }
  }
}
