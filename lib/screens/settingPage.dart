import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:toss_heads_or_tails/ads/ClsAdMob.dart';
import 'package:toss_heads_or_tails/screens/backgroundPage.dart';
import 'package:toss_heads_or_tails/screens/selectCoinPage.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';

import '../utils/classes.dart';
import '../utils/common.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark));

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Scaffold(
                  appBar: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle.dark,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                    ),
                    title: Text(
                      "Setting".tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    titleSpacing: 2,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 30.sp,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: ListTile(
                            title: Text(
                              "change_coin".tr(),
                              style: txtStyleSetting,
                            ),
                            trailing: Image.asset(
                              "assets/arrow_right.png",
                              width: 20,
                              height: 20,
                            ),
                            onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => SelectCoin())).then((value) {
                              ClsAdMob.showFullAds();
                            }),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: ListTile(
                            title: Text(
                              "changebg".tr(),
                              style: txtStyleSetting,
                            ),
                            trailing: Image.asset(
                              "assets/arrow_right.png",
                              width: 20,
                              height: 20,
                            ),
                            onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => BackgroundPage())).then((value) {
                              ClsAdMob.showFullAds();
                            }),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "duration_flip".tr(),
                                  style: txtStyleSetting,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: 1.sw,
                                child: Row(
                                  children: fList
                                      .map((data) => Expanded(
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: data,
                                                  activeColor: primaryColor,
                                                  groupValue: fList[preferences?.getIntDefault(Preferences.keyFlipCountIndex, 0) ?? 0],
                                                  onChanged: (val) {
                                                    preferences?.setInt(Preferences.keyFlipCountIndex, fList.indexOf(val as Flips));
                                                    setState(() {
                                                      // print(
                                                      //     "count --- ${fList[preferences?.getInt(Preferences.keyFlipCountIndex) ?? 0].count}");
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "${data.name}",
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: ListTile(
                            title: Text(
                              "SwingToss".tr(),
                              style: txtStyleSetting,
                            ),
                            trailing: CupertinoSwitch(
                              trackColor: primaryColor.withOpacity(0.2),
                              activeColor: primaryColor,
                              value: preferences?.getBoolDefault(Preferences.keyIsSwingToss, true) ?? true,
                              onChanged: (bool value) {
                                print(value);
                                preferences?.setBool(Preferences.keyIsSwingToss, value);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "CheatMode".tr(),
                                  style: txtStyleSetting,
                                ),
                                trailing: CupertinoSwitch(
                                  trackColor: primaryColor.withOpacity(0.2),
                                  activeColor: primaryColor,
                                  value: preferences?.getBoolDefault(Preferences.keyCheatMode, false) ?? false,
                                  onChanged: (bool value) {
                                    print(value);
                                    preferences?.setBool(Preferences.keyCheatMode, value);
                                    setState(() {});
                                  },
                                ),
                              ),
                              (preferences?.getBoolDefault(Preferences.keyCheatMode, false) ?? false)
                                  ? Container(
                                      width: 1.sw,
                                      child: Row(
                                        children: rList
                                            .map((data) => Expanded(
                                                  child: RadioListTile(
                                                    activeColor: primaryColor,
                                                    title: Text(
                                                      "${data.name}",
                                                      style: txtStyleSetting,
                                                    ),
                                                    value: data,
                                                    groupValue: rList[preferences?.getIntDefault(Preferences.keyCheatResult, 0) ?? 0],
                                                    onChanged: (val) {
                                                      preferences?.setInt(Preferences.keyCheatResult, rList.indexOf(val as RadioClass));
                                                      setState(() {
                                                        print(rList[preferences?.getInt(Preferences.keyCheatResult) ?? 0].index);
                                                      });
                                                    },
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: ListTile(
                            title: Text(
                              "FlipSound".tr(),
                              style: txtStyleSetting,
                            ),
                            trailing: CupertinoSwitch(
                              trackColor: primaryColor.withOpacity(0.2),
                              activeColor: primaryColor,
                              value: preferences?.getBoolDefault(Preferences.keyFlipSound, true) ?? true,
                              onChanged: (bool value) {
                                preferences?.setBool(Preferences.keyFlipSound, value);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: ListTile(
                            title: Text(
                              "Shake".tr(),
                              style: txtStyleSetting,
                            ),
                            trailing: CupertinoSwitch(
                              trackColor: primaryColor.withOpacity(0.2),
                              activeColor: primaryColor,
                              value: preferences?.getBoolDefault(Preferences.keyIsShake, true) ?? true,
                              onChanged: (bool value) {
                                preferences?.setBool(Preferences.keyIsShake, value);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: settingBoxDecoration,
                          child: ListTile(
                            title: Text(
                              "Vibration".tr(),
                              style: txtStyleSetting,
                            ),
                            trailing: CupertinoSwitch(
                              trackColor: primaryColor.withOpacity(0.2),
                              activeColor: primaryColor,
                              value: preferences?.getBoolDefault(Preferences.keyIsVibration, true) ?? true,
                              onChanged: (bool value) {
                                preferences?.setBool(Preferences.keyIsVibration, value);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BannerAds(),
            ],
          ),
        ],
      ),
    );
  }
}
