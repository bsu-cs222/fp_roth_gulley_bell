class GoogleParser {
  String parseFirstGoogleTrends(dynamic jsonData) {
    String firstTrend = jsonData['trending_searches'][0]['query'];
    return firstTrend;
  }

  List<String> parseFirstFiveGoogleTrends(dynamic jsonData) {
    String firstTrend = jsonData['trending_searches'][0]['query'];
    String secondTrend = jsonData['trending_searches'][1]['query'];
    String thirdTrend = jsonData['trending_searches'][2]['query'];
    String fourthTrend = jsonData['trending_searches'][3]['query'];
    String fifthTrend = jsonData['trending_searches'][4]['query'];
    List<String> trends = <String>[
      firstTrend,
      secondTrend,
      thirdTrend,
      fourthTrend,
      fifthTrend
    ];
    return trends;
  }
}
