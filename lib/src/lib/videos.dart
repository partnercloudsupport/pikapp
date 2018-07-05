import 'dart:async';
import 'dart:convert';

// import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;

class VideosApi {
  static Map<String, dynamic> data = {};

  static Future<Map<String, dynamic>> fetchData(
      {int maxResults = 50, String order = 'date'}) async {
    // dynamic response =
    //     await CloudFunctions.instance.call(functionName: 'getVideos');
    http.Response response = await http
        .get('https://us-central1-pikapp-mobile.cloudfunctions.net/getVideos');
    data = json.decode(response.body);
    return data;
  }
}
