import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/FirebaseLog.dart';
import 'AdMobIds.dart';

export 'AdMobIds.dart';
export 'BannerAds.dart';
export 'NativeAds.dart';

int adCount = 2;
int currentCount = 0;

const List<String> deviceList = [
  /*"19B7C9939D63D11A83304BDDC8A5CFB4"*/
  // "F0D5EADFE29E8256379271067C5D2F5D"
];

const AdManagerAdRequest adRequest = AdManagerAdRequest();
InterstitialAd? _interstitialAd;

class ClsAdMob {
  static void initAd(isShow) async {
    print('$currentCount >= $adCount');
    if (_interstitialAd == null) {
      InterstitialAd.load(
        adUnitId: AdMobIds.getInterstitialAdUnitId,
        request: adRequest,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
            _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (InterstitialAd ad) {
                currentCount = 0;
                // FirebaseLog.logEvent("InterAdShow");
                print('$ad onAdShowedFullScreenContent.');
              },
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
                _interstitialAd = null;
                initAd(false);
              },
              onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
                _interstitialAd = null;
              },
              onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
            );
            if(isShow){
              _interstitialAd?.show();
            }
            // FirebaseLog.logEvent("InterAdLoad");
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  static void showFullAds({isShow: false, ignorCnt: false}) async {
    if (currentCount >= adCount || ignorCnt) {
      if (_interstitialAd != null) {
        print('showFullAds');
        _interstitialAd?.show();
      }else{
          initAd(isShow);
      }
    } else {
      currentCount++;
      if (_interstitialAd == null) {
        initAd(isShow);
      }
    }
  }
}
