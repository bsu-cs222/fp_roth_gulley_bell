class NewsTrendsParser {
  String parseFirstNewsTrend(dynamic jsonData) {
    String firstTrend = jsonData['articles'][0]['title'];
    return firstTrend;
  }

  List<String> parseMultipleNewsTrends(dynamic jsonData, int numOfTrends) {
    List<String> newsTrends = [];
    numOfTrends = numOfTrends - 1;
    for (int i = 0; i <= numOfTrends; i++) {
      newsTrends.add(jsonData['articles'][i]['title']);
    }
    return newsTrends;
  }
}
