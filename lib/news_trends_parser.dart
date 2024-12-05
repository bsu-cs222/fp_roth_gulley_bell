class NewsTrendsParser {
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
