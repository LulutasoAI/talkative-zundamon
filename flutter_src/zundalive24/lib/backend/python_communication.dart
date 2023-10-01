 import 'package:http/http.dart' as http;
import 'dart:convert'; // for the json.decode
import "flutter_information_cupsule.dart";

class pythonCommunicationHandler {
  Future<dynamic> fetchMessageFromServer({required String question}) async {
    final Uri uri = Uri.http('localhost:5000', '/get_message', {'question': question});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load message from the server');
    }
  }

 Future<bool> initiateCommentsFetch() async {
    final Uri uri = Uri.http('localhost:5000', '/fetch_comments');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // The comments fetching was initiated successfully.
      // You can add further handling if needed.
      return true;
    } else {
      return false;
      //throw Exception('Failed to initiate comments fetch');
      
    }
  }
  Future<FlutterInformationCapsule?> fetchInformationCapsuleFromServer() async {
    final Uri uri = Uri.http('localhost:5000', '/fetch_latest_info');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if(jsonResponse["result"] == false){
        return null;
      }else{
        print(jsonResponse);
        return FlutterInformationCapsule.fromJson(jsonResponse);
      }
    } else {
      throw Exception('Failed to load message from the server');
    }
  }
}
