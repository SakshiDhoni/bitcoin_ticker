import 'package:http/http.dart' as http;
import 'dart:convert'  ;

class netWork{

  netWork({
    required this.url,
  });
  String url;

  Future getDATA() async {
    try {
      final uri = Uri.parse(url);
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        String data = response.body;
       var decodedData =  jsonDecode(data);
        var lastPrice = decodedData['rate'];
        return lastPrice;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}