import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:pikapp/src/config/secrets.dart' show youtubeApiKey;

final Map<String, String> _baseParams = <String, String>{
  'key': youtubeApiKey,
  'channelId': 'UCBKVQqSRFhhXkULbFsfI3xA',
  'part': 'snippet',
};

final Uri _baseUrl =
    Uri.https('www.googleapis.com', '/youtube/v3/search', _baseParams);

class YoutubeApi {
  static Map<String, dynamic> data = {};

  static Future<Map<String, dynamic>> fetchData(
      {int maxResults = 50, String order = 'date'}) async {
    Map<String, String> params = <String, String>{
      'maxResults': maxResults.toString(),
      'order': order,
      'type': 'video',
    }..addAll(_baseParams);

    Uri url = _baseUrl.replace(queryParameters: params);
    Response response = await get(url);
    data = json.decode(response.body);

    return data;
  }
}
