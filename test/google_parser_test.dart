import 'dart:convert';
import 'dart:io';
import 'package:trending_app/google_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final parser = GoogleParser();
  test('amari cooper is the most trending search', () async {
    final jsonObject = await _loadSampleData('google_trends_query.json');
    final firstTrend = parser.parseGoogleTrends(jsonObject);
    expect(firstTrend, 'amari cooper');
  });
}

dynamic _loadSampleData(String testFileName) async {
  final jsonEncodedResponse = await File('test/$testFileName').readAsString();
  return jsonDecode(jsonEncodedResponse);
}
