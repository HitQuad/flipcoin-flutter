import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ClsAdMob.dart';

class BannerAds extends StatefulWidget {
  AdSize? bannerSize;
  VoidCallback? voidCallback;

  BannerAds({this.bannerSize, this.voidCallback});

  @override
  State<StatefulWidget> createState() {
    return new BannerAdsState();
  }
}

class BannerAdsState extends State<BannerAds> {
  // var myBanner;
  bool isload = false;

  AdWidget? adWidget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isload,
        child: Container(
          alignment: Alignment.center,
          child: adWidget,
          // width: myBanner?.size?.width.toDouble()??0,
          height: myBanner?.size?.height?.toDouble() ?? 0,
          constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: isload && myBanner.size.height.toDouble() > 0
                  ? myBanner.size.height.toDouble()
                  : 0),
        ));
  }

  var myBanner;

  @override
  void initState() {
    try {
      WidgetsBinding.instance!.addPostFrameCallback((_) => loadBanner());
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  AdSize? bannerSize;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    if (widget.voidCallback != null) widget.voidCallback!();
    super.setState(fn);
  }

  void loadBanner() async {
    print(1.sw.truncate());
    bannerSize = widget.bannerSize ??
        await AdSize.getAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).orientation, 1.sw.truncate());
    myBanner = BannerAd(
      adUnitId: AdMobIds.getBannerAdUnitId,
      size: bannerSize ?? AdSize.banner,
      request: adRequest,
      listener: BannerAdListener(onAdLoaded: (value) {
        isload = true;
        myBanner = value;
        log('adSize=${myBanner.size.height.toDouble()}');
        setState(() {});
      }, onAdFailedToLoad: (ad, error) {
        isload = false;
        setState(() {});
      }),
    );
    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
  }
}
