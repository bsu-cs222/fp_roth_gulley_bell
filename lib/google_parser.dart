class GoogleParser {
  String parseFirstGoogleTrends(dynamic jsonData) {
    String firstTrend = jsonData['trending_searches'][0]['query'];
    return firstTrend;
  }
}
