import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trending_app/youtube_trends_parser.dart';

void main() {
  final youtubeParser = YoutubeTrendsParser();
  test("My Daughter's 15 Birthday Surprise is the most trending video",
      () async {
    final jsonObject = await _loadSampleData('youtube_trends_query.json');
    final firstTrend = youtubeParser.parseFirstYoutubeTrend(jsonObject);
    expect(firstTrend, "My Daughter's Emotional 15th BIRTHDAY SURPRISE");
  });

  test("The top five trending videos will be returned", () async {
    final jsonObject = await _loadSampleData('youtube_trends_query.json');
    final firstFiveTrends =
        youtubeParser.parseMultipleYoutubeTrends(jsonObject, 5);
    expect(firstFiveTrends,
        "My Daughter's Emotional 15th BIRTHDAY SURPRISE\n\$1 vs \$500,000 Experiences!\nI Tested Restaurants with No Reviews\n\$10,000 If You Can Beat My Rock, Paper, Scissors Robot\nWe Won Every Game at the State Fair!");
  });
}

dynamic _loadSampleData(String testFileName) async {
  final jsonEncodedResponse = await File('test/$testFileName').readAsString();
  return jsonDecode(jsonEncodedResponse);
}
