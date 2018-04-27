import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class InfoTab extends StatelessWidget {
  void _onPressed() async {
    String url = 'https://flutter.io';
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(fontSize: 24.0);
    final padding = EdgeInsets.symmetric(horizontal: 8.0);
    return FlatButton(
      onPressed: _onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Made with', style: textStyle),
          Padding(
            padding: padding,
            child: Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
          ),
          Text('in', style: textStyle),
          Padding(padding: padding, child: FlutterLogo())
        ],
      ),
    );
  }
}
