class GoogleParser {
  String parseFirstGoogleTrends(dynamic jsonData) {
    String firstTrend = jsonData['trending_searches'][0]['query'];
    return firstTrend;
  }

  List<String> parseFirstFiveGoogleTrends(dynamic jsonData) {
    List<String> trendList = <String>[];
    for (int i = 0; i <= 4; i++) {
      String trend = jsonData['trending_searches'][i]['query'];
      trendList.add(trend);
    }
    return trendList;
  }
}
