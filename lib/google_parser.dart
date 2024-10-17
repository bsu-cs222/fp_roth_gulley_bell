class GoogleParser {
  List<dynamic> parseGoogleTrends(dynamic jsonData) {
    List<dynamic> firstTrend = jsonData['trending_searches'];
    return firstTrend;
  }
}
