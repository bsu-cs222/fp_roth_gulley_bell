import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trending_app/google_parser.dart';
import 'package:trending_app/news_trends_parser.dart';
import 'package:trending_app/stocks_trends_parser.dart';
import 'package:trending_app/youtube_trends_parser.dart';
import 'package:trending_app/trend_fetchers.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTRN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            primary: Colors.amber,
            secondary: Colors.orangeAccent,
            seedColor: Colors.grey,
            shadow: Colors.black12),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Whats Trending Right Now?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textEditingController = TextEditingController();
  int numOfTrends = 0;
  GoogleParser googleParser = GoogleParser();
  YoutubeTrendsParser youtubeParser = YoutubeTrendsParser();
  StocksTrendsParser stocksParser = StocksTrendsParser();
  NewsTrendsParser newsParser = NewsTrendsParser();
  TrendFetchers trendFetcher = TrendFetchers();
  List<Map<String, dynamic>>? trendsData;
  String? errorText;

  Future<void> fetchTrends() async {
    try {
      final data = await Future.wait([
        trendFetcher.fetchGoogleTrends(),
        trendFetcher.fetchYoutubeTrends(),
        trendFetcher.fetchNewsAPITrends(),
      ]);
      setState(() {
        trendsData = data;
      });
    } catch (e) {
      Text("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "What's Trending Right Now?",
            style: TextStyle(color: Colors.white60),
          ),
          backgroundColor: Colors.black87,
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: Future.wait([
                        trendFetcher.fetchGoogleTrends(),
                        trendFetcher.fetchYoutubeTrends(),
                        trendFetcher.fetchNewsAPITrends(),
                        trendFetcher.fetchFinanceTrends()
                      ]),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return Row(
                            children: [
                              Center(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      padding: const EdgeInsets.all(5.0),
                                      width: 350.0,
                                      height: 350.0,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Column(children: [
                                        Text("Google"),
                                        Text(
                                          textEditingController.text.isEmpty
                                              ? googleParser
                                                  .parseFirstGoogleTrends(
                                                      snapshot.data![0])
                                              : googleParser
                                                  .parseMultipleGoogleTrends(
                                                      snapshot.data![0],
                                                      numOfTrends),
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.black),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      padding: const EdgeInsets.all(5.0),
                                      width: 350.0,
                                      height: 350.0,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Column(
                                        children: [
                                          Text("Youtube"),
                                          Text(
                                            textEditingController.text.isEmpty
                                                ? youtubeParser
                                                    .parseFirstYoutubeTrend(
                                                        snapshot.data![1])
                                                : youtubeParser
                                                    .parseMultipleYoutubeTrends(
                                                        snapshot.data![1],
                                                        numOfTrends),
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      padding: const EdgeInsets.all(5.0),
                                      width: 350.0,
                                      height: 350.0,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Column(
                                        children: [
                                          Text("News API"),
                                          Text(
                                            "1. ${newsParser.parseFirstNewsTrend(snapshot.data![2])}",
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      padding: const EdgeInsets.all(5.0),
                                      width: 350.0,
                                      height: 350.0,
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Column(
                                        children: [
                                          Text("StockDataAPI"),
                                          Text(
                                            "1. ${stocksParser.parseFirstStocksTrend(snapshot.data![3])}",
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                              child: Text(
                                  'Please Check your internet connection!'));
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: TextButton(
                              onPressed: fetchTrends,
                              child: Text(("Fetch New Trends!"),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 100.0,
                        width: 225.0,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "Enter 1-10 For New Trends!",
                              hintStyle: TextStyle(color: Colors.black),
                              errorText: errorText),
                          controller: textEditingController,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              try {
                                numOfTrends =
                                    int.parse(textEditingController.text);
                                // Clear error message if input is valid
                                errorText = null;
                                // Ensure the number is between 1 and 10
                                if (numOfTrends < 1 || numOfTrends > 5) {
                                  errorText =
                                      "Please enter a number between 1 and 5";
                                }
                              } catch (e) {
                                errorText = "Please enter a number from 1 - 5";
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
