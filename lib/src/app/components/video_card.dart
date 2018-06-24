import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class VideoCard extends StatelessWidget {
  VideoCard({
    @required String videoId,
    @required String this.thumbnailUrl,
    @required String this.title,
    @required String this.description,
  }) : videoUrl = 'https://youtu.be/$videoId';

  VideoCard.fromData(Map<String, dynamic> data)
      : videoUrl = 'https://youtu.be/${data['id']['videoId']}',
        thumbnailUrl = data['snippet']['thumbnails']['high']['url'],
        title = data['snippet']['title'],
        description = data['snippet']['description'];

  final String videoUrl;
  final String thumbnailUrl;
  final String title;
  final String description;

  void _watch() => url_launcher.launch(videoUrl);

  void _share() => share(videoUrl);

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
                  image: thumbnailUrl,
                  fit: BoxFit.fitWidth,
                  fadeOutDuration: Duration(milliseconds: 0),
                  fadeInDuration: Duration(milliseconds: 150),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        description,
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
