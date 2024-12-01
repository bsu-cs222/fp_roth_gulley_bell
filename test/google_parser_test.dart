import 'dart:convert';
import 'dart:io';
import 'package:trending_app/google_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final parser = GoogleParser();
  test('amari cooper is the most trending search', () async {
    final jsonObject = await _loadSampleData('google_trends_query.json');
    final firstTrend = parser.parseFirstGoogleTrends(jsonObject);
    expect(firstTrend, '1. amari cooper');
  });

  test('The first five trends from google trends will be pulled', () async {
    final jsonObject = await _loadSampleData('google_trends_query.json');
    final firstFiveTrends = parser.parseMultipleGoogleTrends(jsonObject, 5);
    expect(firstFiveTrends,
        '1. amari cooper\n2. kate moss\n3. argentina vs bolivia\n4. méxico - estados unidos\n5. johnny gaudreau');
  });
}

dynamic _loadSampleData(String testFileName) async {
  final jsonEncodedResponse = await File('test/$testFileName').readAsString();
  return jsonDecode(jsonEncodedResponse);
}
