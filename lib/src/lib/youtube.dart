import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart';

import 'package:pikapp/src/config/secrets.dart' show youtubeApiKey;

final Map<String, String> _baseParams = <String, String>{
  'key': youtubeApiKey,
  'channelId': 'UCBKVQqSRFhhXkULbFsfI3xA',
  'part': 'snippet',
};

class YoutubeApi {
  static final _dataCache = AsyncCache(Duration(hours: 1));

  static final Uri baseUrl =
      Uri.https('www.googleapis.com', '/youtube/v3/search', _baseParams);

  static Future<Map<String, dynamic>> fetchData(
      {int maxResults = 50, String order = 'date'}) async {
    Map<String, String> params = <String, String>{
      'maxResults': maxResults.toString(),
      'order': order,
      'type': 'video',
    }..addAll(_baseParams);
    Uri url = baseUrl.replace(queryParameters: params);

    Response response = await get(url);
    return json.decode(response.body);
  }

  static Future fetchCachedData() => _dataCache.fetch(fetchData);
}
