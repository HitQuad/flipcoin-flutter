import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/common.dart';
import 'createCoin.dart';
import 'flipCoinPage.dart';

class BackgroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BackgroundPageState();
  }
}

class BackgroundPageState extends State<BackgroundPage> {
  @override
  Widget build(BuildContext context) {
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
                        bottomLeft: Radius.circular(15.sp),
                        bottomRight: Radius.circular(15.sp),
                      ),
                    ),
                    title: Text(
                      "changebg".tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    centerTitle: true,
                    titleSpacing: 2,

                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 25.sp,
                      ),
                    ),

                    actions: [

                      GestureDetector(
                        onTap: () async {
                          await showCupertinoModalPopup(
                            context: context,
                            builder: (context) => buildBottomSheet(context),
                          ).then((_) {
                            if (tempImageFile != null) {
                              preferences?.setBool(
                                  Preferences.keyCustomBg, true);
                              preferences?.setString(
                                  Preferences.keyCustomBgImage,
                                  tempImageFile!.path);
                              tempImageFile = null;
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => FlipCoin()));
                            }
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0,0,15,0),
                            child: Image.asset("assets/plus.png",width: 20,height: 20,)
                        ),
                      ),
                    ],

                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Column(
                      children: [
                        SizedBox(height: 25.sp),
                        Expanded(
                          child: GridView.builder(
                            itemCount: bgList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.landscape
                                      ? 3
                                      : 2,
                              crossAxisSpacing: 20.sp,
                              mainAxisSpacing: 20.sp,
                            ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  await preferences?.setInt(
                                      Preferences.keyBgIndex, index);
                                  preferences?.setBool(
                                      Preferences.keyCustomBg, false);
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => FlipCoin()));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.sp))),
                                  elevation: 0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.sp)),
                                    child: Image.asset(
                                      bgList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
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
