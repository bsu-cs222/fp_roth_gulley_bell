import 'dart:convert';
import 'dart:io';
import 'package:trending_app/google_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final parser = GoogleParser();
  test('The first five trends from google trends will be pulled', () async {
    final jsonObject = await _loadSampleData('google_trends_query.json');
    final firstFiveTrends = parser.parseMultipleGoogleTrends(jsonObject, 5);
    expect(firstFiveTrends,
        'amari cooper\nkate moss\nargentina vs bolivia\nméxico - estados unidos\njohnny gaudreau');
  });
}

dynamic _loadSampleData(String testFileName) async {
  final jsonEncodedResponse = await File('test/$testFileName').readAsString();
  return jsonDecode(jsonEncodedResponse);
}
