import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trending_app/google_parser.dart';

import 'google_trends_fetcher.dart';

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
  @override
  Widget build(BuildContext context) {
    final parser = GoogleParser();

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
                      Container(
                        margin: const EdgeInsets.all(50.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(border: Border.all()),
                        child: FutureBuilder<Map<String, dynamic>>(
                            future: fetchGoogleTrends(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                return Center(
                                  child: Text(
                                    "1. ${parser.parseFirstGoogleTrends(snapshot.data)}",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.black),
                                  ),
                                );
                              } else {
                                return Center(
                                    child: Text(
                                        'Please Check your internet connection!'));
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
