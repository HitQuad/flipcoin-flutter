// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:microwave_recipe/ads/ClsAdMob.dart';
//
// class FullScreenAds extends StatefulWidget {
//   FullScreenAds({Key key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return new FullScreenAdsState();
//   }
// }
//
// class FullScreenAdsState<T extends FullScreenAds> extends State<T> {
//
//   InterstitialAd interstitialAd;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     print('currentCount='+currentCount.toString());
//     initAd();
//   }
//
//   void initAd({isShow: false ,ignorCnt: false}) async {
//     if (currentCount >= adCount) {
//       if (interstitialAd != null && await interstitialAd.isLoaded()) {
//         interstitialAd.show();
//         // return;
//       }
//
//       interstitialAd = InterstitialAd(
//         adUnitId: getInterstitialAdUnitId,
//         request: adRequest,
//         listener: AdListener(
//           // Called when an ad is successfully received.
//           onAdLoaded: (Ad ad) {
//             if (isShow) {
//               showFullAds();
//             }
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             ad.dispose();
//             print('Ad failed to load: $error');
//           },
//           // Called when an ad opens an overlay that covers the screen.
//           onAdOpened: (Ad ad) {
//             currentCount = 0;
//             print('Ad opened.');
//           },
//           // Called when an ad removes an overlay that covers the screen.
//           onAdClosed: (Ad ad) {
//             ad.dispose();
//             print('Ad closed.');
//           },
//           // Called when an ad is in the process of leaving the application.
//           onApplicationExit: (Ad ad) => showFullAds(),
//         ),
//       );
//       interstitialAd.load();
//     } else {
//       currentCount++;
//     }
//   }
//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     showFullAds();
//     print('currentCount'+currentCount.toString());
//   }
//
//   void showFullAds() async {
//     if (interstitialAd != null && await interstitialAd.isLoaded()) {
//       interstitialAd.show();
//     }
//     // else if (currentCount >= adCount) {
//     //   initAd(isShow: true);
//     // }
//   }
// }
