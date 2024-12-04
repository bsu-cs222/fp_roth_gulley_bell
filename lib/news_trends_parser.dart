class NewsTrendsParser {
  String parseFirstNewsTrend(dynamic jsonData) {
    String firstTrend = jsonData['articles'][0]['title'];
    return firstTrend;
  }

  String parseMultipleNewsTrends(dynamic jsonData, int numOfTrends) {
    List<String> newsTrends = [];
    numOfTrends = numOfTrends - 1;
    for (int i = 0; i <= numOfTrends; i++) {
      String trend = jsonData['articles'][i]['title'];
      newsTrends.add(trend);
    }
    return newsTrends.join("\n");
  }
}
