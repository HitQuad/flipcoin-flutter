// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_native_admob/native_admob_options.dart';
//
// import 'ClsAdMob.dart';
//
// class NativeAds extends StatefulWidget
// {
//   NativeAdmobType adType;
//   Color? adFontColor;
//   NativeAds(
//       {this.adType: NativeAdmobType.banner, this.adFontColor: Colors.black});
//
//   @override
//   State<StatefulWidget> createState()
//   {
//     return new NativeAdsState();
//   }
// }
//
// class NativeAdsState extends State<NativeAds>
// {
//   var headlineTextStyle;
//   var advertiserTextStyle;
//   var storeTextStyle;
//   var priceTextStyle;
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return Visibility(
//         visible: true,
//         child: Container(
//           height: widget.adType == NativeAdmobType.banner ? 72 : 350,
//           // child: AdWidget(ad: _ad),
//           child: NativeAdmob(
//             adUnitID: AdMobIds.nativeAdUnitId,
//             loading: Center(child: CircularProgressIndicator()),
//             error: Text("Failed to load the ad"),
//             type: widget.adType,
//             // controller: _nativeAdController,
//             options: NativeAdmobOptions(
//               ratingColor: Colors.red,
//               headlineTextStyle: headlineTextStyle,
//               advertiserTextStyle: advertiserTextStyle,
//               storeTextStyle: storeTextStyle,
//               priceTextStyle: priceTextStyle,
//               // Others ...
//             ),
//           ),
//           alignment: Alignment.center,
//         ));
//   }
//
//   // NativeAd _ad;
//   // bool _isAdLoaded = false;
//   // final _nativeAdController = NativeAdmobController();
//   // StreamSubscription _subscription;
//
//
//   @override
//   void initState()
//   {
//     super.initState();
//
//     if (widget.adFontColor != null)
//     {
//         headlineTextStyle = NativeTextStyle(
//           fontSize: 16,
//           color: widget.adFontColor??Colors.black,
//         );
//
//         advertiserTextStyle = NativeTextStyle(
//           fontSize: 14,
//           color: widget.adFontColor??Colors.black,
//         );
//
//         storeTextStyle = NativeTextStyle(
//           fontSize: 12,
//           color: widget.adFontColor??Colors.black,
//         );
//
//         priceTextStyle = NativeTextStyle(
//           fontSize: 12,
//           color: widget.adFontColor??Colors.black,
//         );
//
//     }
//     // _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
//     //if(Platform.isAndroid) {
//     //   _ad = NativeAd(
//     //     adUnitId: AdMobIds.nativeAdUnitId,
//     //     factoryId: widget.adType,
//     //     request: adRequest,
//     //
//     //     listener: NativeAdListener(
//     //       onAdLoaded: (_) {
//     //         setState(() {
//     //           _isAdLoaded = true;
//     //         });
//     //       },
//     //       onAdFailedToLoad: (ad, error) {
//     //         // Releases an ad resource when it fails to load
//     //         ad.dispose();
//     //         print(
//     //             'Ad load failed (code=${error.code} message=${error.message})');
//     //       },
//     //     ),
//     //   );
//     //
//     //   // COMPLETE: Load an ad
//     //   _ad.load();
//     //}
//   }
//   // double _height = 0;
//   // void _onStateChanged(AdLoadState state) {
//   //   switch (state) {
//   //     case AdLoadState.loading:
//   //       setState(() {
//   //         _height = 0;
//   //       });
//   //       break;
//   //     case AdLoadState.loadCompleted:
//   //       setState(() {
//   //         _height = widget.adType==NativeAdmobType.banner?72:350;
//   //       });
//   //       break;
//   //     default:
//   //       break;
//   //   }
//   // }
//
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
//     // _ad.dispose();
//     super.dispose();
//   }
// }
