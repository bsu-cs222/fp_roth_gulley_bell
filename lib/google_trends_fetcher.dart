import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchGoogleTrends() async {
  final googleKey = dotenv.env['GOOGLE_KEY'];
  final response = await http.get(Uri.parse(
      'https://serpapi.com/search.json?engine=google_trends_trending_now&geo=US&api_key=$googleKey'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Data');
  }
}