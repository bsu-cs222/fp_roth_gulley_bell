import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trending_app/stocks_trends_parser.dart';

void main() {
  final stocksParser = StocksTrendsParser();
  test('The first two stock trends will be pulled', () async {
    final jsonObject = await _loadSampleData('stocks_trends_query.json');
    final firstThreeTrends =
        stocksParser.parseMultipleStockTrends(jsonObject, 2);
    expect(firstThreeTrends,
        "Why Tesla (TSLA) Shares Are Dropping Today\nMixed Performance in U.S. Stocks as Inflation Data Awaited");
  });
}

dynamic _loadSampleData(String testFileName) async {
  final jsonEncodedResponse = await File('test/$testFileName').readAsString();
  return jsonDecode(jsonEncodedResponse);
}
