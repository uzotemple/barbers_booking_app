// import 'package:flutter/material.dart';

// class NewsScreen extends StatelessWidget {
//   const NewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News'),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF001F5F),
//         foregroundColor: Colors.white,
//       ),
//       body: ListView(
//         children: const <Widget>[
//           ListTile(
//             title: Text('News Item 1'),
//             subtitle: Text('Details about news item 1.'),
//           ),
//           ListTile(
//             title: Text('News Item 2'),
//             subtitle: Text('Details about news item 2.'),
//           ),
//           // Add more news items here
//         ],
//       ),
//     );
//   }
// }

// import 'dart:convert';  // For jsonDecode

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _NewsScreenState createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<dynamic> _newsArticles = [];
//   bool _isLoading = true;
//   final String _apiKey = '33b05efd201245ff85ec39e13bc08ccc';  // Replace with your API key
//   final String _newsUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';

//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();
//   }

//   Future<void> _fetchNews() async {
//     final response = await http.get(Uri.parse('$_newsUrl$_apiKey'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         _newsArticles = data['articles'];
//         _isLoading = false;
//       });
//     } else {
//       // Handle the error
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News'),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF001F5F),
//         foregroundColor: Colors.white,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _newsArticles.length,
//               itemBuilder: (context, index) {
//                 final article = _newsArticles[index];
//                 return ListTile(
//                   title: Text(article['title']),
//                   subtitle: Text(article['description'] ?? ''),
//                   onTap: () {
//                     // Handle tap if you want to open the full article
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _newsArticles = [];
  bool _isLoading = true;
  final String _apiKey = '06017040-a3d4-4581-8e2d-86ce73e343f6'; // Replace with your API key
  final String _newsUrl = 'https://content.guardianapis.com/search?api-key='; // Removed leading space

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final response = await http.get(Uri.parse('$_newsUrl$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _newsArticles = data['response']['results']; // Corrected JSON path
        _isLoading = false;
      });
    } else {
      // Handle the error
      print('Failed to fetch news: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('News'),
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: const Color(0xFF001F5F),
      //   foregroundColor: Colors.white,
      // ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _newsArticles.length,
              itemBuilder: (context, index) {
                final article = _newsArticles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // No direct `urlToImage`, use `fields` or similar based on API response structure
                      article['fields'] != null && article['fields']['thumbnail'] != null
                          ? Image.network(article['fields']['thumbnail']) // Display image if available
                          : const SizedBox.shrink(), // Placeholder if no image is available
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(article['webTitle']),
                          subtitle: Text(article['sectionName'] ?? ''),
                          onTap: () {
                            // Handle tap if you want to open the full article
                            final url = article['webUrl'];
                            if (url != null) {
                              // Replace this with the URL launching logic
                              print('Open full article at: $url');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _NewsScreenState createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   List<dynamic> _newsArticles = [];
//   bool _isLoading = true;
//   final String _apiKey = '33b05efd201245ff85ec39e13bc08ccc'; // Replace with your API key
//   final String _newsUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=';

//   @override
//   void initState() {
//     super.initState();
//     _fetchNews();
//   }

//   Future<void> _fetchNews() async {
//     final response = await http.get(Uri.parse('$_newsUrl$_apiKey'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         _newsArticles = data['articles'];
//         _isLoading = false;
//       });
//     } else {
//       // Handle the error
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _launchURL(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       // Handle error if the URL can't be launched
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News'),
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF001F5F),
//         foregroundColor: Colors.white,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _newsArticles.length,
//               itemBuilder: (context, index) {
//                 final article = _newsArticles[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
//                   child: InkWell(
//                     onTap: () {
//                       if (article['url'] != null) {
//                         _launchURL(article['url']);
//                       }
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         article['urlToImage'] != null
//                             ? Image.network(article['urlToImage']) // Display image if available
//                             : const SizedBox.shrink(), // Placeholder if no image is available
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ListTile(
//                             title: Text(article['title']),
//                             subtitle: Text(article['description'] ?? ''),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


