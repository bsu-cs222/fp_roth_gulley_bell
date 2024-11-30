class YoutubeTrendsParser {
  String parseFirstYoutubeTrend(dynamic jsonData) {
    String firstTrend = jsonData['items'][0]['snippet']['title'];
    return firstTrend;
  }

  List<String> parseMultipleYoutubeTrends(dynamic jsonData, int numOfTrends) {
    List<String> youtubeTrends = [];
    numOfTrends = numOfTrends - 1;
    for (int i = 0; i <= numOfTrends; i++) {
      youtubeTrends.add(jsonData['items'][i]['snippet']['title']);
    }
    return youtubeTrends;
  }
}
