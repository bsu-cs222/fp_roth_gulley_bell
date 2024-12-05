class StocksTrendsParser {
  String parseMultipleStockTrends(dynamic jsonData, int numOfTrends) {
    List<String> stockTrends = [];
    for (int i = 0; i < numOfTrends; i++) {
      String trend = jsonData['data'][i]['title'];
      stockTrends.add(trend);
    }
    return stockTrends.join("\n");
  }
}
