import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = "https://fakerapi.it/api/v2/users";

  Future<List<dynamic>> fetchPersons() async {
    final Uri url = Uri.parse(apiUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']; // Ensure the API response structure matches this
    } else {
      throw Exception("Failed to load persons");
    }
  }
}
