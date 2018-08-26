import 'package:pikapp/services/firebase/remote_config.dart';

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

// ---------

const String storeAndroidUrl =
    'http://play.google.com/store/apps/details?id=yt.pikatea.app';

const String sentryDsn =
    'https://b98c7b2b8d9649ec92e4802c87b30767:60e2747913514272b9fe9ac0aabc0868@sentry.io/289984';

// ---------

const bool debugMode = !bool.fromEnvironment('dart.vm.product');
