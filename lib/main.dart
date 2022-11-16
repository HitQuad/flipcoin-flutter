import 'dart:async';

import 'dart:convert';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toss_heads_or_tails/ads/AppLifecycleReactor.dart';
import 'package:toss_heads_or_tails/ads/AppOpenAdManager.dart';
import 'package:toss_heads_or_tails/api/AdsModel.dart';
import 'package:toss_heads_or_tails/api/ClsCommon.dart';
import 'package:toss_heads_or_tails/api/constants.dart';
import 'package:toss_heads_or_tails/screens/homePage.dart';
import 'package:toss_heads_or_tails/utils/FirebaseLog.dart';
import 'package:toss_heads_or_tails/utils/common.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';
import 'package:toss_heads_or_tails/utils/show_message_dialog.dart';

import 'ads/ClsAdMob.dart';
// import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  final RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: deviceList);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(EasyLocalization(supportedLocales: [
    Locale('af'),
    Locale('am'),
    Locale('ar'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('es', 'US'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fr'),
    Locale('fr', 'CA'),
    Locale('gl'),
    Locale('gu'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('iw'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('ky'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('ml'),
    Locale('mn'),
    Locale('mr'),
    Locale('ms'),
    Locale('my'),
    Locale('ne'),
    Locale('nl'),
    Locale('no'),
    Locale('pa'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh-CN', 'CN'),
    Locale('zh-CN', 'HK'),
    Locale('zh-TW', "TW"),
    Locale('zu'),
  ], path: 'assets/lang', useOnlyLangCode: true, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "appname".tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Poppins',
      ),
      home: SplashPage(),
      navigatorObservers: [
        // FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    if (Platform.isAndroid) {
      startTime();
    } else if (Platform.isIOS || Platform.isMacOS) {
      try {
        WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
      } catch (e) {
        print(e);
      }
    } else {
      startTime();
    }

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
        appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();

    // WidgetsBinding.instance.addObserver(
    //     LifecycleEventHandler(resumeCallBack: () async => setState(() {
    //
    //     }))
    // );
  }

  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        // Show a custom explainer dialog before the system dialog
        //  if (await showCustomTrackingDialog(context)) {
        // Wait for dialog popping animation

        // }
        await Future.delayed(const Duration(milliseconds: 200));
        // Request system's tracking authorization dialog
        // final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization().whenComplete(() {
          startTime();
        });
      } else {
        startTime();
      }
    } on PlatformException {
      startTime();
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  startTime() async {
    preferences = await Preferences.init();
    var response = json.decode(ADsJson);
    adsModel = AdsModel.fromJson(response);
    loadIds();
    fetchData();
    // var duration = new Duration(seconds: 3);
    // new Timer(duration, route);
  }

  route() async {
    // ClsAdMob.showFullAds(ignorCnt: true, isShow: true);
    AppOpenAdManager()..showAdIfAvailable();

    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        // size:BoxConstraints(
        //       maxWidth: MediaQuery.of(context).size.width,
        //       maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(411, 891));
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 2000),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, -200 * value),
                  child: child,
                );
              },
              child: Container(
                color: Colors.transparent,
                height: 200.w,
                width: 200.w,
                // child: Lottie.asset('assets/flip_gif.json'),
                child: Image.asset('assets/app_icon.png'),
              ),
            ),
          ),
          Positioned(
            top: -40.w,
            right: -40.w,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 2000),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(200 * value, 0.0),
                  child: child,
                );
              },
            ),
          ),
          Positioned(
            bottom: -40.w,
            left: -40.w,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 2000),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(-200 * value, 0.0),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  bool isLoading = true;

  void fetchData() async {
    isLoading = true;
    setState(() {});
    try {
      if (!await checkInternet()) {
        context.showMessageDialog("No Internet Connection!!");
        isLoading = false;
        setState(() {});
        return;
      }

      var responseStr = await ClsCommon().getResponce(ApiAdJson);
      var response = json.decode(responseStr);
      adsModel = AdsModel.fromJson(response);
      loadIds();
      // try {
      //   AdRequestAppOpen targetingInfo = AdRequestAppOpen();
      //
      //   await FlutterAdmobAppOpen.instance.initialize(
      //     // appId: AdMobIds.admobAppId,
      //     appAppOpenAdUnitId: AdMobIds.getOpenAdUnitId,
      //     targetingInfo: targetingInfo,
      //   );
      //
      //   // await FlutterAdmobAppOpen.instance.resume();
      // } catch (e) {
      //   print(e);
      // }

      ClsAdMob.initAd(false);

      var duration = new Duration(seconds: 1);
      new Timer(duration, route);
      // PreferenceUtils.setString(
      //     AppConstants.LoginData, json.encode(response['data']));

      // if (response['MesCode'] == 200) {
      //
      // } else {
      //   context.showMessageDialog(response["Message"]);
      //   // Navigator.of(context).pushReplacement(new MaterialPageRoute<String>(
      //   //     builder: (context) => NewRegistrationNew()));
      // }

    } catch (e, t) {
      context.showMessageDialog(e.toString());
      print("Exception $t");
    }

    isLoading = false;
    setState(() {});
    return;

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => PaymentScreen()),
    // );
  }

  void loadIds() {
    AdMobIds.openAppIdsAndroid = adsModel!.admobAppopenid!;
    AdMobIds.bannerIdsAndroid = adsModel!.admobBannerid!;
    AdMobIds.interstitialIdsAndroid = adsModel!.admobInterid!;
    AdMobIds.nativeIdsAndroid = adsModel!.admobNativeid!;
    adCount = int.parse(adsModel?.interCount ?? "2");

  }
}

AdsModel? adsModel;
String ADsJson = '''{
  "package_name": "app.heads_tails",
  "app_version": "1",
  "is_ad_show": true,
  "admob_appid": "",
  "admob_interid": "/21753324030,22798965566/app.heads_tails_Interstitial",
  "admob_bannerid": "/21753324030,22798965566/app.heads_tails_Banner",
  "admob_nativeid": "/21753324030,22798965566/app.heads_tails_Native",
  "admob_appopenid": "/21753324030,22798965566/app.heads_tails_AppOpen",
  "click_appopen_id": "/21753324030,22798965566/app.heads_tails_AppOpen",
  "admob_reward": "/21753324030,22798965566/app.heads_tails_Native",
  "fb_inter_id": "",
  "fb_banner_id": "",
  "fb_native_id": "",
  "fb_native_banner_id": "",
  "inter_count": "3",
  "ad_splash": "appopen",
  "ad_inter": "admob",
  "ad_appopen": "admob",
  "ad_native": "admob",
  "ad_banner": "admob",
  "privacy_url": ""
}''';