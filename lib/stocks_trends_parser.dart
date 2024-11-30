class StocksTrendsParser {
  String parseFirstStocksTrend(dynamic jsonData) {
    if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
      String firstTrend = jsonData['data'][0]['title'];
      return firstTrend;
    } else {
      return "No data available";
    }
  }

  List<String> parseMultipleStockTrends(dynamic jsonData, int numOfTrends) {
    List<String> stockTrends = [];
    numOfTrends = numOfTrends - 1;
    if (jsonData['data'] != null && jsonData['data'].length >= 3) {
      for (int i = 0; i < numOfTrends; i++) {
        stockTrends.add(jsonData['data'][i]['title']);
      }
    } else if (jsonData['data'] != null) {
      for (var item in jsonData['data']) {
        stockTrends.add(item['title']);
      }
    }

    return stockTrends;
  }
}
