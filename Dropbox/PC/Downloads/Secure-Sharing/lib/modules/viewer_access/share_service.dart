import 'dart:convert';
import 'package:http/http.dart' as http;

class ShareService {
  final String _baseUrl =
      "https://your-backend.com"; // Replace with your backend

  Future<Map<String, dynamic>> fetchCertificate(String token) async {
    final res = await http.get(Uri.parse("$_baseUrl/api/view/$token"));
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception("Failed to fetch: ${res.body}");
    }
  }
}
