class YoutubeTrendsParser {
  String parseFirstYoutubeTrend(dynamic jsonData) {
    String firstTrend = jsonData['items'][0]['snippet']['title'];
    return firstTrend;
  }

  List<String> parseFirstFiveYoutubeTrends(dynamic jsonData) {
    List<String> youtubeTrends = [];
    for (int i = 0; i <= 4; i++) {
      youtubeTrends.add(jsonData['items'][i]['snippet']['title']);
    }
    return youtubeTrends;
  }
}
