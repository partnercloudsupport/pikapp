import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color;

  SocialIconButton(
    this.icon, {
    @required Function this.onPressed,
    Color this.color: Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Icon(
        icon,
        color: Colors.white,
        size: 32.0,
      ),
      color: color,
      onPressed: onPressed,
      padding: EdgeInsets.all(12.0),
    );
  }
}

class HomeTab extends StatelessWidget {
  void _goTo(String url) async {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    }
  }

  void _goToFacebook() => _goTo('https://www.facebook.com/pikateadiys/');
  void _goToInstagram() => _goTo('https://www.instagram.com/pikateayt/');
  void _goToTwitter() => _goTo('https://twitter.com/pikateayt/');
  void _goToYoutube() => _goTo('https://www.youtube.com/user/Pikatea/');
  void _goToPinterest() => _goTo('https://pinterest.com/Pikatea/pins/');
  void _goToTwitch() => _goTo('https://www.twitch.tv/pikatea/');
  void _goToGooglePlus() =>
      _goTo('https://plus.google.com/u/0/107914231113095144113/');

  @override
  Widget build(BuildContext context) {
    final TextStyle display1 = TextStyle(fontSize: 34.0);
    final TextStyle headline = TextStyle(fontSize: 24.0);
    final TextStyle title =
        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
    final padding =
        EdgeInsets.only(top: 24.0, bottom: 120.0, left: 16.0, right: 16.0);

    final ButtonThemeData buttonTheme =
        ButtonTheme.of(context).copyWith(minWidth: 36.0);

    return Center(
      child: ListView(
        padding: padding,
        children: <Widget>[
          Text(
            'Ciao!',
            style: display1,
            textAlign: TextAlign.left,
          ),
          Text(
            "\nMi chiamo Altea e sono una studentessa appassionata di videogiochi e anime.\n\nQuesta è la mia app in cui potrai trovare tutti i video del mio canale YouTube e i prodotti che pubblico su Etsy.\n",
            style: headline,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              'Puoi trovarmi su questi social:',
              style: title,
            ),
          ),
          ButtonTheme.fromButtonThemeData(
            data: buttonTheme,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.0,
              runSpacing: 16.0,
              children: <Widget>[
                SocialIconButton(FontAwesomeIcons.facebook,
                    onPressed: _goToFacebook,
                    color: Color.fromRGBO(65, 89, 147, 1.0)),
                SocialIconButton(FontAwesomeIcons.instagram,
                    onPressed: _goToInstagram,
                    color: Color.fromRGBO(205, 72, 107, 1.0)),
                SocialIconButton(FontAwesomeIcons.twitter,
                    onPressed: _goToTwitter,
                    color: Color.fromRGBO(0, 172, 237, 1.0)),
                SocialIconButton(FontAwesomeIcons.youtube,
                    onPressed: _goToYoutube,
                    color: Color.fromRGBO(230, 33, 23, 1.0)),
                SocialIconButton(FontAwesomeIcons.pinterest,
                    onPressed: _goToPinterest,
                    color: Color.fromRGBO(189, 8, 28, 1.0)),
                SocialIconButton(FontAwesomeIcons.twitch,
                    onPressed: _goToTwitch,
                    color: Color.fromRGBO(75, 54, 124, 1.0)),
                // SocialIconButton(FontAwesomeIcons.snapchatGhost,
                //     color: Color.fromRGBO(255, 252, 0, 1.0)),
                SocialIconButton(FontAwesomeIcons.googlePlusG,
                    onPressed: _goToGooglePlus,
                    color: Color.fromRGBO(211, 72, 54, 1.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
