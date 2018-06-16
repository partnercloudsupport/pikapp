import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memoize/memoize.dart';

import 'package:pikapp/src/config/secrets.dart' show youtubeApiKey;
import 'video_card.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  static final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  static final SnackBar _snackBar = SnackBar(
    duration: Duration(seconds: 5),
    content: Text("Oops! Something went wrong..."),
    action: SnackBarAction(
      label: 'RETRY',
      onPressed: () {
        // analytics.logEvent(name: 'notification_okay');
        _refreshIndicatorKey.currentState?.show();
      },
    ),
  );

  static final String authority = 'www.googleapis.com';
  static final String path = '/youtube/v3/search';
  static final String channelId = 'UCBKVQqSRFhhXkULbFsfI3xA';
  static final String part = 'snippet';
  static final String apiKey = youtubeApiKey;

  static final Map<String, String> baseParams = <String, String>{
    'key': apiKey,
    'channelId': channelId,
    'part': part,
  };
  static final Uri baseUrl = Uri.https(authority, path, baseParams);

  static Future<Map<String, dynamic>> _fetchVideos() async {
    Map<String, String> params = <String, String>{
      'maxResults': '50',
      'order': 'date',
      'type': 'video',
    }..addAll(baseParams);
    Uri url = baseUrl.replace(queryParameters: params);
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  static Function _memoFetchVideos = memo0(_fetchVideos);

  Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    super.initState();

    _future = _memoFetchVideos();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future<Null> _onRefresh() async {
    setState(() {
      _future = _memoFetchVideos();
    });
    try {
      await _future;
    } catch (error) {
      Scaffold.of(context).showSnackBar(_snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RefreshIndicator(
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: kMaterialListPadding,
                itemCount: snapshot.data['items'].length,
                itemBuilder: (context, int index) =>
                    VideoCard(snapshot.data['items'][index]));
          } else {
            if (snapshot.hasError) {
              Scaffold.of(context).showSnackBar(_snackBar);
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.accentIconTheme.color),
              ),
            );
          }
        },
      ),
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
    );
  }
}
