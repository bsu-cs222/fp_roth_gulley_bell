class StocksTrendsParser {
  String parseFirstStocksTrend(dynamic jsonData) {
    if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
      String firstTrend = jsonData['data'][0]['title'];
      return firstTrend;
    } else {
      return "No data available";
    }
  }

  String parseMultipleStockTrends(dynamic jsonData, int numOfTrends) {
    List<String> stockTrends = [];
    for (int i = 0; i < numOfTrends; i++) {
      String trend = jsonData['data'][i]['title'];
      stockTrends.add(trend);
    }
    return stockTrends.join("\n");
  }
}
