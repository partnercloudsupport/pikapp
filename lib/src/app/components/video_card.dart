import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class VideoCard extends StatelessWidget {
  final Map<String, dynamic> data;

  VideoCard(Map<String, dynamic> this.data);

  void _watch() async {
    final String url =
        "https://www.youtube.com/watch?v=${data['id']['videoId']}";
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    }
  }

  void _share() {
    final String url = "https://youtu.be/${data['id']['videoId']}";
    share(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: InkWell(
          onTap: _watch,
          // onLongPress: _share,
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: data['snippet']['thumbnails']['high']['url'],
                  fit: BoxFit.fitWidth,
                  fadeOutDuration: Duration(),
                  fadeInDuration: Duration(milliseconds: 150),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      data['snippet']['title'],
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        data['snippet']['description'],
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: _watch,
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: _share,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
