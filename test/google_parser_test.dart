import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trending_app/google_parser.dart';

void main() {
  final parser = SerpApiTrendsParser();
  test('amari cooper is the most trending search', () async {
    final jsonObject = await _loadSampleData('google_trends_query.json');
    final firstTrend = parser.parseFirstGoogleTrends(jsonObject);
    expect(firstTrend, 'amari cooper');
  });

  test('The first five trends from google trends will be pulled', () async {
    final jsonObject = await _loadSampleData('google_trends_query.json');
    final firstFiveTrends = parser.parseFirstFiveGoogleTrends(jsonObject);
    expect(firstFiveTrends, [
      'amari cooper',
      'kate moss',
      'argentina vs bolivia',
      'méxico - estados unidos',
      'johnny gaudreau'
    ]);
  });
}

dynamic _loadSampleData(String testFileName) async {
  final jsonEncodedResponse = await File('test/$testFileName').readAsString();
  return jsonDecode(jsonEncodedResponse);
}
