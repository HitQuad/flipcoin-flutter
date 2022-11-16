import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/common.dart';
import 'flipCoinPage.dart';

class CreateCoin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateCoinState();
  }
}

class CreateCoinState extends State<CreateCoin> {
  File? headsFile;
  File? tailsFile;

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
                      "custm_coin".tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    centerTitle: true,
                    titleSpacing: 2,
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 25.sp,
                      ),
                    ),
                    actions: [
                      (headsFile != null && tailsFile != null)
                          ? GestureDetector(
                              onTap: () async {
                                await preferences?.setBool(
                                    Preferences.keyCustomCoin, true);
                                await preferences?.setString(
                                    Preferences.keyCoinImageHeads,
                                    headsFile!.path);
                                await preferences?.setString(
                                    Preferences.keyCoinImageTails,
                                    tailsFile!.path);
                                Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => FlipCoin()),
                                );
                              },
                              child: Icon(
                                Icons.done_all,
                                size: 25.sp,
                                color: primaryColor,
                              ),
                            )
                          : Container(),
                      SizedBox(width: 15.sp),
                    ],
                  ),
                  body: SafeArea(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 0.43.sh,
                              width: 1.sw,
                              color: Colors.transparent,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 23.sp),
                                child: Column(
                                  children: [
                                    SizedBox(height: 25.sp),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Select".tr()+" Heads "+"Image".tr()+":",
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) =>
                                                buildBottomSheet(context),
                                          ).then((_) {
                                            if (tempImageFile != null) {
                                              headsFile = tempImageFile;
                                              tempImageFile = null;
                                              setState(() {});
                                            }

                                          });
                                        },
                                        child: (headsFile == null)
                                            ? cameraContainer()
                                            : imageContainer(headsFile!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.sp),
                              child: Divider(
                                thickness: 1.5,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              height: 0.43.sh,
                              width: 1.sw,
                              color: Colors.transparent,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 23.sp),
                                child: Column(
                                  children: [
                                    SizedBox(height: 25.sp),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Select".tr()+" Tails "+"Image".tr()+":",
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) =>
                                                buildBottomSheet(context),
                                          ).then((_) {
                                            if (tempImageFile != null) {
                                              tailsFile = tempImageFile;
                                              tempImageFile = null;
                                              setState(() {});
                                            }
                                          });
                                        },
                                        child: (tailsFile == null)
                                            ? cameraContainer()
                                            : imageContainer(tailsFile!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
