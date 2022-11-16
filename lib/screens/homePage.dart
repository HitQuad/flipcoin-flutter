import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toss_heads_or_tails/ads/ClsAdMob.dart';
import 'package:toss_heads_or_tails/screens/settingPage.dart';
import 'package:toss_heads_or_tails/utils/FirebaseLog.dart';
import 'package:toss_heads_or_tails/utils/common.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';

import 'ExitScreen.dart';
import 'flipCoinPage.dart';
import 'guidePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseLog.logEvent("AppOpen");
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));

    return WillPopScope(
      onWillPop: () async {
        ClsAdMob.showFullAds(ignorCnt: true);
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => ExitScreen()));
        return Future.value(false);
      },
      child: Container(
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: Stack(
          children: [
            Stack(

              children: [
                Scaffold(
                  appBar: null,
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.fill
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset("assets/toss_img.png",
                          height: 200,width: 200),

                          Padding(padding: EdgeInsets.all(10.0),

                          child:menuButton(
                            "Flip Coin",
                            () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => FlipCoin())).then((value) {
                                ClsAdMob.showFullAds();
                              });
                            },
                          ),
                          ),

                          new Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              menuButton("Setting".tr(), () {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => SettingPage())).then((value) {
                                  ClsAdMob.showFullAds();
                                });
                              }),

                              SizedBox(width: 10),

                              menuButton("Guide".tr(), () {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => GuidePage())).then((value) {
                                  ClsAdMob.showFullAds();
                                });
                              }),
                            ],
                          ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),

                          child:new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              (preferences?.getBoolDefault(Preferences.keyRateComplete, false) ?? false)
                                  ? Container()
                                  : menuButton("RateUs".tr(), () async {
                                await showRatingDialog(context).then((value) {
                                  ClsAdMob.showFullAds();
                                });
                              }),

                              SizedBox(width: 10),

                              menuButton("ShareApp".tr(), () async {
                                String share = "appname".tr() + "\n\n " + "sharemsg".tr() + "\nPlayStore : $playStoreUrl\nAppStoreUrl : $appStoreUrl";
                                await shareApp(share);
                              }),
                            ],
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  // child: AnchoredAdaptiveExample(),
                  child: BannerAds(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
