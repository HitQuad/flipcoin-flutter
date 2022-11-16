import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobIds {
  /** Android Ids
   *

   * **/

  static String appIdsAndroid = '';
  static String bannerIdsAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static String interstitialIdsAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static String openAppIdsAndroid = 'ca-app-pub-3940256099942544/3419835294';
  static String nativeIdsAndroid = '	ca-app-pub-3940256099942544/2247696110';

  /** IOS Ids
      App ID - ca-app-pub-8040184828005537~4602569239
      banner - ca-app-pub-8040184828005537/3559992449
      Intertitial - ca-app-pub-8040184828005537/2035281495
      Native - ca-app-pub-8040184828005537/7246608358
      App Open - ca-app-pub-8040184828005537/8013976689
   **/

  static String appIdsIos = 'ca-app-pub-8040184828005537~4602569239';
  static String bannerIdsIos = 'ca-app-pub-8040184828005537/3559992449';
  static String interstitialIdsIos = 'ca-app-pub-8040184828005537/2035281495';
  static String openAppIdsIos = 'ca-app-pub-8040184828005537/8013976689';
  static String nativeIdsIos = 'ca-app-pub-8040184828005537/7246608358';

  static String get admobAppId {
    if (Platform.isIOS) {
      return appIdsIos.isNotEmpty ? appIdsIos : "";
    } else if (Platform.isAndroid) {
      return appIdsAndroid.isNotEmpty
          ? appIdsAndroid
          : "";
    }
    return "";
  }

  static String get getBannerAdUnitId {
    if (Platform.isIOS) {
      return bannerIdsIos.isNotEmpty ? bannerIdsIos : "";
    } else if (Platform.isAndroid) {
      return bannerIdsAndroid.isNotEmpty
          ? bannerIdsAndroid
          : "";
    }
    return "";
  }

  static String get getInterstitialAdUnitId {
    if (Platform.isIOS) {
      return interstitialIdsIos.isNotEmpty
          ? interstitialIdsIos
          : "";
    } else if (Platform.isAndroid) {
      return interstitialIdsAndroid.isNotEmpty
          ? interstitialIdsAndroid
          : "";
    }
    return "";
  }

  static String get getOpenAdUnitId {
    if (Platform.isIOS) {
      return openAppIdsIos.isNotEmpty
          ? openAppIdsIos
          : "";
    } else if (Platform.isAndroid) {
      return openAppIdsAndroid.isNotEmpty
          ? openAppIdsAndroid
          : "";
    }
    return "";
  }

  static String get nativeAdUnitId {
    if (Platform.isIOS) {
      return nativeIdsIos.isNotEmpty ? nativeIdsIos : "";
    } else if (Platform.isAndroid) {
      return nativeIdsAndroid.isNotEmpty
          ? nativeIdsAndroid
          : "";
    }
    return "";
  }
}
