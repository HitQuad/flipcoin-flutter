import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:toss_heads_or_tails/ads/ClsAdMob.dart';
import 'package:toss_heads_or_tails/utils/classes.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';

import '../utils/common.dart';
import 'createCoin.dart';
import 'flipCoinPage.dart';

class SelectCoin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelectCoinState();
  }
}

class SelectCoinState extends State<SelectCoin> {
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
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                    ),
                    title: Text(
                      "select_coin".tr(),
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
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 25.sp,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => CreateCoin())),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Image.asset(
                              "assets/plus.png",
                              width: 20,
                              height: 20,
                            )),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),
                        Expanded(
                          child: ListView.builder(
                            itemCount: coinsList.length,
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 1 : 1,
                            //   childAspectRatio: 0.85,
                            //   crossAxisSpacing: 20.sp,
                            //   mainAxisSpacing: 20.sp,
                            // ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  await preferences?.setBool(Preferences.keyCustomCoin, false);
                                  await preferences?.setInt(Preferences.keyCoinIndex, index);
                                  Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => FlipCoin()));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                  ),
                                  elevation: 2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.r),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/coins/coin_${coinsList[index].key}_tails.png', width: 0.4.sw),
                                            SizedBox(width: 10.h),
                                            Image.asset(
                                              'assets/coins/coin_${coinsList[index].key}_heads.png',
                                              width: 0.4.sw,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2.h),
                                        Container(
                                          height: 40.h,
                                          width: 1.sw,
                                          color: primaryColor,
                                          child: DefaultTextStyle(
                                            textAlign: TextAlign.center,
                                            style: TextStyle(),
                                            child: Center(child: Text('${coinsList[index].name}')),
                                          ),
                                        )
                                      ],
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
