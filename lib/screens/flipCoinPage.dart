import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:toss_heads_or_tails/ads/ClsAdMob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shake/shake.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:toss_heads_or_tails/screens/selectCoinPage.dart';
import 'package:toss_heads_or_tails/screens/settingPage.dart';
import 'package:toss_heads_or_tails/utils/common.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';
import 'package:vibration/vibration.dart';
import '../utils/classes.dart';
import '../utils/common.dart';
import 'backgroundPage.dart';
import 'homePage.dart';
import 'package:easy_localization/easy_localization.dart';

class FlipCoin extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return new FlipCoinState();
  }
}

class FlipCoinState extends State<FlipCoin> with TickerProviderStateMixin
{
  AnimationController? animationController;
  String? headsImage;
  String? tailsImage;
  int idx = 5;
  ShakeDetector? shakeDetector;
  final player = AudioPlayer();
  var _alignment = Alignment.bottomCenter;

  @override
  void initState() {
    super.initState();

    String? cIdx =
        coinsList[preferences?.getIntDefault(Preferences.keyCoinIndex, 0) ?? 0]
            .key;
    headsImage = 'assets/coins/coin_${cIdx}_heads.png';
    tailsImage = 'assets/coins/coin_${cIdx}_tails.png';

    idx = fList[preferences?.getInt(Preferences.keyFlipCountIndex) ?? 0].count!;

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500 * idx));
    shakeDetector = ShakeDetector.waitForStart(onPhoneShake: () => _doFlip());

    if ((preferences?.getBoolDefault(Preferences.keyIsShake, true) ?? true) ||
        (preferences?.getBoolDefault(Preferences.keyIsSwingToss, true) ??
            true)) {
      shakeDetector!.startListening();
    }
    if (preferences?.getBoolDefault(Preferences.keyCustomCoin, false) ?? false) {
      headsImage = preferences?.getString(Preferences.keyCoinImageHeads) ?? '';
      tailsImage = preferences?.getString(Preferences.keyCoinImageTails) ?? '';
    }
  }

  @override
  void dispose() {
    result = false;
    shakeDetector!.stopListening();
    animationController!.reset();
    Vibration.cancel();
    flipping = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomePage()));
        return Future.value(false);
      },
      child: Stack(
        children: [
          Scaffold(

            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 0,
              title: Text("Flip Coin",
              style: TextStyle(
                color: primaryColor
              ),),
              backgroundColor: Colors.transparent,
              brightness: Brightness.light,
              leading: GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(builder: (context) => HomePage()),
                ),
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: primaryColor,
                  size: 30.w,
                ),
              ),
              actions: [

                  GestureDetector(

                    onTap: ()=> _showAlertDialog(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0,0,15,0),
                          child: Image.asset("assets/refresh.png",width: 20,height: 20,)
                        ),
                  ),

                GestureDetector(
                  onTap: ()=> Navigator.push(context, new MaterialPageRoute(builder:
                      (context)=>SettingPage())),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0,0,15,0),
                      child: Image.asset("assets/setting.png",width: 25,height: 25,)
                  ),
                ),

              ],
            ),
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Container(
              decoration: BoxDecoration(
                image: (preferences?.getBoolDefault(
                            Preferences.keyCustomBg, false) ??
                        false)
                    ? DecorationImage(
                        image: FileImage(
                          File(preferences
                                  ?.getString(Preferences.keyCustomBgImage) ??
                              ''),
                        ),
                        fit: BoxFit.cover)
                    : DecorationImage(
                        image: AssetImage(bgList[preferences?.getIntDefault(
                                Preferences.keyBgIndex, 0) ??
                            0]),
                        fit: BoxFit.cover,
                      ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50.h,
                    bottom: 200.h,
                    left: (1.sw - 200.w) / 2,
                    right: (1.sw - 200.w) / 2,
                    child: AnimatedBuilder(
                        animation: animationController!,
                        builder: (BuildContext context, _) {
                          // print("idx---- $idx");
                          final newValue = lerpDouble(
                              0.0, 2 * idx * pi, animationController!.value);
                          // print("newValue --- ${newValue! % 2}");
                          return AnimatedContainer(
                            height: 1.sh,
                            width: 200.w,
                            duration: Duration(milliseconds: 250 * idx),
                            alignment: _alignment,
                            curve: (_alignment == Alignment.topCenter)
                                ? Curves.linear
                                : Curves.bounceOut,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 1.0, end: 0.0),
                              curve: Curves.bounceOut,
                              duration: const Duration(milliseconds: 1500),
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0.0, -400 * value),
                                  child: child,
                                );
                              },
                              child: GestureDetector(
                                onTap: () => _doFlip(),
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateX(newValue!),
                                  // ..rotateX((animation!.value % 2 < 0.5)
                                  //     ? pi * animation!.value
                                  //     : pi * (1 + animation!.value)),
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 150.w,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 25.0,
                                            spreadRadius: 25,
                                            offset: Offset(
                                              20,
                                              20,
                                            ),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                      border: (preferences?.getBoolDefault(
                                                  Preferences.keyCustomCoin,
                                                  false) ??
                                              false)
                                          ? Border.all(width: 2)
                                          : Border(),
                                      image: (preferences?.getBoolDefault(
                                                  Preferences.keyCustomCoin,
                                                  false) ??
                                              false)
                                          ? DecorationImage(
                                              image: FileImage(
                                                File(flipping
                                                    ? newValue % 2 < 1.0
                                                        ? headsImage!
                                                        : tailsImage!
                                                    : isShowHeads
                                                        ? headsImage!
                                                        : tailsImage!),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: AssetImage(flipping
                                                  ? newValue % 2 < 0.5
                                                      ? headsImage!
                                                      : tailsImage!
                                                  : isShowHeads
                                                      ? headsImage!
                                                      : tailsImage!),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Positioned(
                    top: 130.h,
                    left: (1.sw - 200.w) / 2,
                    right: (1.sw - 200.w) / 2,
                    child: Container(
                      height: 50.h,
                      width: 200.w,
                      alignment: Alignment.center,
                      color: Colors.transparent,
                        child: InkWell(
                          child: GradientText(
                            flipping
                                ? "flipping".tr()
                                : result
                                    ? isShowHeads
                                        ? "HEADS"
                                        : "TAILS"
                                    : "TOSS",
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ), colors: [
                              Color(0xFF432818),
                              Color(0xFF99582A),
                          ],
                      ),
                          onTap: () async {
                            _doFlip();
                          },
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BannerAds(),
          ),
        ],
      ),
    );
  }

  Future<void> _doFlip() async {
    if (flipping == false) {
      await player.setAsset("assets/coin_sound/coinflip.mp3");
      animationController!.reset();
      setState(() {
        flipping = true;
        _alignment = Alignment.topCenter;
        Timer(Duration(milliseconds: 250 * idx), () {
          setState(() {
            _alignment = Alignment.bottomCenter;
          });
        });
        if (preferences?.getBoolDefault(Preferences.keyIsVibration, true) ??
            true) {
          Vibration.vibrate(pattern: vibrationPattern);
        }
      });

      if (preferences?.getBoolDefault(Preferences.keyFlipSound, true) ?? true)
        player.play();

      await animationController!.forward(from: 0);
      animationController!.reset();
      // print('finish==');
      Vibration.cancel();
      setState(() {
        result = true;
        flipping = false;
        _alignment = Alignment.bottomCenter;
        if (preferences?.getBoolDefault(Preferences.keyCheatMode, false) ??
            false) {
          if (rList[preferences?.getInt(Preferences.keyCheatResult) ?? 0]
                  .index ==
              1) {
            isShowHeads = true;
          } else {
            isShowHeads = false;
          }
        } else {
          isShowHeads = Random().nextBool();
        }

        if (isShowHeads) {
          player.setAsset("assets/coin_sound/heads.mp3");
        } else {
          player.setAsset("assets/coin_sound/tails.mp3");
        }
        if (preferences?.getBoolDefault(Preferences.keyFlipSound, true) ?? true)
          player.play();
      });
    }
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // dialog dismiss when back or screen touch
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          // title: const Text('Cancel booking'),
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: const <Widget>[
          //       Text('Are you sure want to cancel booking?'),
          //     ],
          //   ),
          // ),
          shape : RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),

          backgroundColor: Colors.white,
          actions: <Widget>[
        Column(
        children: [
          Container(
            child: ListTile(
              title: Text(
              "change_coin".tr(),
              style: txtStyleSetting,
              ),

            trailing:Image.asset("assets/arrow_right.png",width: 20,height: 20,),

            onTap: () {
              dismissDailog();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => SelectCoin()))
                  .then((value) {
              });
            }
            ),
          ),
          SizedBox(height: 10.h),
          Container(
              child: ListTile(
                title: Text(
                "changebg".tr(),
                style: txtStyleSetting,
                ),

              trailing:Image.asset("assets/arrow_right.png",width: 20,height: 20,),

              onTap: () {
                dismissDailog();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => BackgroundPage()),)
                    .then((value) {});
              }
              ),
              ),
        ],
        )
          ],
        );
      },
    );
  }

  dismissDailog( ){
    if(context != null){
      Navigator.pop(context!);
    }
  }
}
