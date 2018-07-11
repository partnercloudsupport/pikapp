import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class VideoCard extends StatelessWidget {
  VideoCard({
    @required String this.videoId,
    @required String this.thumbnailUrl,
    @required String this.title,
    @required String this.description,
  });

  VideoCard.fromData(Map<String, dynamic> data)
      : videoId = data['id']['videoId'],
        thumbnailUrl = data['snippet']['thumbnails']['high']['url'],
        title = data['snippet']['title'],
        description = data['snippet']['description'];

  final String videoId;
  final String thumbnailUrl;
  final String title;
  final String description;

  String get videoUrl => 'https://youtu.be/$videoId';

  void _watch() => url_launcher.launch(videoUrl);

  void _share() => share(videoUrl);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        child: InkWell(
          onTap: _watch,
          // onLongPress: _share,
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: thumbnailUrl,
                  fit: BoxFit.fitWidth,
                  fadeOutDuration: Duration(milliseconds: 0),
                  fadeInDuration: kThemeAnimationDuration,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        description,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    IconButton(
                      color: themeData.accentColor,
                      icon: Icon(Icons.play_circle_filled),
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
