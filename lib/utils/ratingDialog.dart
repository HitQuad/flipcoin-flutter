import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:toss_heads_or_tails/ads/BannerAds.dart';
import 'package:easy_localization/easy_localization.dart';

import 'common.dart';

// ignore: must_be_immutable
class RatingDialog extends StatelessWidget {
  double padding = 16.0;
  double avatarRadius = 30.0;

  VoidCallback? cancel;
  VoidCallback? rateIt;
  VoidCallback? hateIt;

  RatingDialog({
    this.cancel,
    this.rateIt,
    this.hateIt,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context)
  {
    return Stack(
      children: <Widget>[
        Container(
          width: 1.sw,
          padding: EdgeInsets.only(
            top: avatarRadius + 10,
            bottom: padding + 55,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                'rate_app'.tr(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'rate_msg'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

  (Platform.isAndroid)?Expanded(
                    child:
                         Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 90,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                hateIt!();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                              ),
                              child: Text(
                                'HateIt'.tr(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )

                  ) : Container(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.zero,
                      width: 90,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          rateIt!();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                        ),
                        child: Text(
                          'RateIt'.tr(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      width: 90,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          cancel!();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0))),
                        ),
                        child: Text(
                          'Cancel'.tr(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: Container(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Image.asset(
                  "assets/app_icon_android.png",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          left: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(padding),
                bottomRight: Radius.circular(padding)),
            child: BannerAds(
              bannerSize: AdSize.banner,
            ),
          ),
        ),
      ],
    );
  }
}
