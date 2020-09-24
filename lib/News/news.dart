import 'dart:convert';

import 'package:essf/models/articlemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=au&category=health&apiKey=f499f9b740254a65af70464aea4fdee3";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTile({@required this.imageUrl, this.title, this.desc, this.url});

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        InkWell(
          onTap: () async => _launchUrl(url),
          splashColor: Colors.blue,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: Image.network(imageUrl)),
        ),
        SizedBox(height: 8.0),
        InkWell(
         
          child: Text(title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        SizedBox(height: 8.0),
        Text(
      desc,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(height: 8.0),
       
        
      ],
    ));
  }
}
