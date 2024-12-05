import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trending_app/google_parser.dart';
import 'package:trending_app/news_trends_parser.dart';
import 'package:trending_app/stocks_trends_parser.dart';
import 'package:trending_app/trend_fetchers.dart';
import 'package:trending_app/youtube_trends_parser.dart';

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
          seedColor: Colors.amberAccent,
          primary: Colors.black87,
          secondary: Colors.orangeAccent,
          surface: Colors.amberAccent,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'What’s Trending Right Now?'),
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
  int numOfTrends = 1;
  String? errorText;

  GoogleParser googleParser = GoogleParser();
  YoutubeTrendsParser youtubeParser = YoutubeTrendsParser();
  StocksTrendsParser stocksParser = StocksTrendsParser();
  NewsTrendsParser newsParser = NewsTrendsParser();
  TrendFetchers trendFetcher = TrendFetchers();

  List<String> _googleTrends = [];
  List<String> _youtubeTrends = [];
  List<String> _newsTrends = [];
  List<String> _stocksTrends = [];

  Future<void> fetchTrends() async {
    try {
      final data = await Future.wait([
        trendFetcher.fetchGoogleTrends(),
        trendFetcher.fetchYoutubeTrends(),
        trendFetcher.fetchNewsAPITrends(),
        trendFetcher.fetchFinanceTrends(),
      ]);

      setState(() {
        _googleTrends = googleParser
            .parseMultipleGoogleTrends(data[0], numOfTrends)
            .split('\n');
        _youtubeTrends = youtubeParser
            .parseMultipleYoutubeTrends(data[1], numOfTrends)
            .split('\n');
        _newsTrends = newsParser
            .parseMultipleNewsTrends(data[2], numOfTrends)
            .split('\n');
        _stocksTrends = stocksParser
            .parseMultipleStockTrends(data[3], numOfTrends)
            .split('\n');
      });
    } catch (e) {
      setState(() {
        errorText = "Failed to load data. Please try again.";
      });
    }
  }

  Widget buildTrendCard({
    required String title,
    required IconData icon,
    required List<String> trends,
  }) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: trends.isEmpty
                  ? const Center(
                      child: Text("", style: TextStyle(fontSize: 16)))
                  : ListView.builder(
                      itemCount: trends.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${index + 1}. ${trends[index]}',
                          style: const TextStyle(fontSize: 18),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTrends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildTrendCard(
                    title: "Google Trends",
                    icon: Icons.search,
                    trends: _googleTrends,
                  ),
                  buildTrendCard(
                    title: "YouTube Trends",
                    icon: Icons.video_library,
                    trends: _youtubeTrends,
                  ),
                  buildTrendCard(
                    title: "News Trends",
                    icon: Icons.article,
                    trends: _newsTrends,
                  ),
                  buildTrendCard(
                    title: "Stock Trends",
                    icon: Icons.trending_up,
                    trends: _stocksTrends,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: fetchTrends,
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Fetch New Trends",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter 1-5 for new trends",
                  errorText: errorText,
                ),
                onChanged: (value) {
                  setState(() {
                    try {
                      numOfTrends = int.parse(value);
                      errorText = null;
                      if (numOfTrends < 1 || numOfTrends > 5) {
                        errorText = "Please enter a number between 1-5";
                      }
                    } catch (e) {
                      errorText = "Invalid input. Enter a number.";
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
