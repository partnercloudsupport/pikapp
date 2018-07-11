import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../config/constants.dart';
import '../locale/localizations.dart';

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

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  void _goTo(url) => url_launcher.launch(url);

  void _goToFacebook() => _goTo(socialFacebookUrl);
  void _goToInstagram() => _goTo(socialInstagramUrl);
  void _goToMessenger() => _goTo(socialMessengerUrl);
  void _goToPinterest() => _goTo(socialPinterestUrl);
  void _goToTelegram() => _goTo(socialTelegramUrl);
  void _goToTwitch() => _goTo(socialTwitchUrl);
  void _goToTwitter() => _goTo(socialTwitterUrl);
  void _goToYoutube() => _goTo(socialYoutubeUrl);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);

    final TextStyle header = TextStyle(
        fontFamily: 'Courgette', fontSize: 48.0, fontWeight: FontWeight.bold);
    final TextStyle body = TextStyle(fontSize: 24.0);
    final TextStyle footer =
        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

    final EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0);

    final ButtonThemeData buttonTheme =
        ButtonTheme.of(context).copyWith(minWidth: 36.0);

    return ListView(
      padding: EdgeInsets.only(bottom: 160.0),
      children: <Widget>[
        Padding(
          padding: padding,
          child: Text(localizations.translate('home_header'), style: header),
        ),
        Image.asset('lib/resources/assets/home_1.jpg', fit: BoxFit.fitWidth),
        Padding(
          padding: padding,
          child: Text(localizations.translate('home_body'), style: body),
        ),
        Image.asset('lib/resources/assets/home_2.jpg', fit: BoxFit.fitWidth),
        Padding(
          padding: padding,
          child: Text(localizations.translate('home_footer'), style: body),
        ),
        Padding(
          padding: padding,
          child: Column(
            children: <Widget>[
              Text(
                localizations.translate('home_social'),
                style: footer,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ButtonTheme.fromButtonThemeData(
                  data: buttonTheme,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: <Widget>[
                      SocialIconButton(
                        FontAwesomeIcons.facebookF,
                        onPressed: _goToFacebook,
                        color: Color.fromRGBO(65, 89, 147, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.facebookMessenger,
                        onPressed: _goToMessenger,
                        color: Color.fromRGBO(0, 132, 255, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.instagram,
                        onPressed: _goToInstagram,
                        color: Color.fromRGBO(205, 72, 107, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.twitter,
                        onPressed: _goToTwitter,
                        color: Color.fromRGBO(0, 172, 237, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.youtube,
                        onPressed: _goToYoutube,
                        color: Color.fromRGBO(230, 33, 23, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.telegramPlane,
                        onPressed: _goToTelegram,
                        color: Color.fromRGBO(0, 136, 204, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.pinterestP,
                        onPressed: _goToPinterest,
                        color: Color.fromRGBO(189, 8, 28, 1.0),
                      ),
                      SocialIconButton(
                        FontAwesomeIcons.twitch,
                        onPressed: _goToTwitch,
                        color: Color.fromRGBO(75, 54, 124, 1.0),
                      ),
                      // SocialIconButton(
                      //   FontAwesomeIcons.snapchatGhost,
                      //   color: Color.fromRGBO(255, 252, 0, 1.0),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
