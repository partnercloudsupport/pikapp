import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';

class VideosApi {
  static Map<String, dynamic> data = {};

  static Future<Map<String, dynamic>> fetchData(
      {int maxResults = 50, String order = 'date'}) async {
    final Map response =
        await CloudFunctions.instance.call(functionName: 'getVideos');
    return data = Map<String, dynamic>.unmodifiable(response);
  }
}
