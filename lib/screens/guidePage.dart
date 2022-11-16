import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:toss_heads_or_tails/utils/common.dart';
import 'package:easy_localization/easy_localization.dart';

class GuidePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return GuidePageState();
  }
}

class GuidePageState extends State<GuidePage> {
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
                    // shape: ContinuousRectangleBorder(
                    //   borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(15.r),
                    //     bottomRight: Radius.circular(15.r),
                    //   ),
                    // ),
                    title: Text(
                      "Guide".tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    titleSpacing: 2,
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 25.w,
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),

                            child: ExpansionTile(
                              backgroundColor: bgContainerSetting,
                              collapsedBackgroundColor: bgContainerSetting,
                              initiallyExpanded: false,
                              title: Text(
                                "how".tr(),
                                style: txtStyleSetting,
                                textAlign: TextAlign.center,
                              ),
                              trailing: Image.asset('assets/arrow_down.png',width: 20,height: 20,),
                              children: [
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text("g1".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                ),
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text("g2".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                ),
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text("g3".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            child: ExpansionTile(
                              backgroundColor: bgContainerSetting,
                              collapsedBackgroundColor: bgContainerSetting,
                              initiallyExpanded: false,
                              title: Text(
                                "g4".tr(),
                                style: txtStyleSetting,
                                textAlign: TextAlign.center,
                              ),
                              trailing: Image.asset('assets/arrow_down.png',width: 20,height: 20,),
                              children: [
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text("g5".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                ),
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text(
                                      "g6".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            child: ExpansionTile(
                              backgroundColor: bgContainerSetting,
                              collapsedBackgroundColor: bgContainerSetting,
                              initiallyExpanded: false,
                              title: Text(
                                "g7".tr(),
                                style: txtStyleSetting,
                                textAlign: TextAlign.center,
                              ),
                              trailing: Image.asset('assets/arrow_down.png',width: 20,height: 20,),
                              children: [
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text(
                                      "g8".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                ),
                                ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text(
                                      "g9".tr(),
                                      style: txtStyleSetting),
                                  leading: Image.asset(
                                    'assets/round.png',
                                    color: primaryColor,
                                    height: 15.w,
                                    width: 15.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
