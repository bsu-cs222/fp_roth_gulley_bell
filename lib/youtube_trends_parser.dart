class YoutubeTrendsParser {
  String parseFirstYoutubeTrend(dynamic jsonData) {
    String firstTrend = jsonData['items'][0]['snippet']['title'];
    return "${1}. $firstTrend";
  }

  String parseMultipleYoutubeTrends(dynamic jsonData, int numOfTrends) {
    List<String> youtubeTrends = [];
    numOfTrends = numOfTrends - 1;
    for (int i = 0; i <= numOfTrends; i++) {
      String trend = (jsonData['items'][i]['snippet']['title']);
      youtubeTrends.add("${i + 1}. $trend");
    }
    return youtubeTrends.join("\n");
  }
}
