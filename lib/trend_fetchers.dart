import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TrendFetchers {
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

  Future<Map<String, dynamic>> fetchYoutubeTrends() async {
    final youtubeKey = dotenv.env['YOUTUBE_KEY'];
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&regionCode=US&key=$youtubeKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<Map<String, dynamic>> fetchNewsAPITrends() async {
    final newsKey = dotenv.env['NEWS_KEY'];
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$newsKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<Map<String, dynamic>> fetchFinanceTrends() async {
    final financeKey = dotenv.env['FINANCE_KEY'];
    final response = await http.get(Uri.parse(
        'https://api.stockdata.org/v1/news/all?&filter_entities=true&language=en&api_token=$financeKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
