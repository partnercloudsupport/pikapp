import 'package:pikapp/services/firebase/remote_config.dart';

// Social

final String socialFacebookUrl =
    remoteConfig.getString('social__facebook_url') ??
        'https://urlgeni.us/facebook/pikatea';

final String socialInstagramUrl =
    remoteConfig.getString('social__instagram_url') ??
        'https://urlgeni.us/instagram/pikatea';

final String socialMessengerUrl =
    remoteConfig.getString('social__messenger_url') ??
        'https://urlgeni.us/fb_messenger/pikatea';

final String socialPinterestUrl =
    remoteConfig.getString('social__pinterest_url') ??
        'https://urlgeni.us/pinterest/pikatea';

final String socialTelegramUrl =
    remoteConfig.getString('social__telegram_url') ??
        'https://urlgeni.us/telegram/pikatea';

final String socialTwitchUrl = remoteConfig.getString('social__twitch_url') ??
    'https://www.twitch.tv/pikatea/';

final String socialTwitterUrl = remoteConfig.getString('social__twitter_url') ??
    'https://urlgeni.us/twitter/pikatea';

final String socialYoutubeUrl = remoteConfig.getString('social__youtube_url') ??
    'https://urlgeni.us/youtube/pikatea';

// Store

const String storeAndroidUrl =
    'http://play.google.com/store/apps/details?id=yt.pikatea.app';
