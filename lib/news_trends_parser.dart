class NewsTrendsParser {
  String parseFirstNewsTrend(dynamic jsonData) {
    String firstTrend = jsonData['articles'][0]['title'];
    return firstTrend;
  }

  List<String> parseFirstFiveNewsTrends(dynamic jsonData) {
    List<String> newsTrends = [];
    for (int i = 0; i <= 4; i++) {
      newsTrends.add(jsonData['articles'][i]['title']);
    }
    return newsTrends;
  }
}
