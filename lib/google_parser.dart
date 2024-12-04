class GoogleParser {
  String parseFirstGoogleTrends(dynamic jsonData) {
    String firstTrend = jsonData['trending_searches'][0]['query'];
    return firstTrend;
  }

  String parseMultipleGoogleTrends(dynamic jsonData, int numOfTrends) {
    List<String> trendList = <String>[];
    numOfTrends = numOfTrends - 1;
    for (int i = 0; i <= numOfTrends; i++) {
      String trend = jsonData['trending_searches'][i]['query'];
      trendList.add(trend);
    }
    return trendList.join("\n");
  }
}
