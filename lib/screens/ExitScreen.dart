import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:toss_heads_or_tails/utils/FirebaseLog.dart';
import '/ads/ClsAdMob.dart';
import '../utils/common.dart';
import 'homePage.dart';

class ExitScreen extends StatefulWidget
{
    @override
    State<StatefulWidget> createState()
    {
        return new ExitScreenState();
    }
}

class ExitScreenState extends State<ExitScreen>
{

  @override
  Widget build(BuildContext context)
  {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
       statusBarColor: Colors.transparent,
       statusBarBrightness: Brightness.dark,
       statusBarIconBrightness: Brightness.dark));

    return WillPopScope(

      onWillPop: ()
      {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute<String>(builder: (context) => HomePage()));
          return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          (Platform.isAndroid)
                              ? 'assets/app_icon_android.png'
                              : 'assets/app_icon_ios.png',
                          height: 100.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                          "appname".tr(),
                          style: TextStyle(fontSize: 18.sp),
                        )),
                      ],
                    ),
                  ),
                ),
                // NativeAds(
                //   adType: NativeAdmobType.full,
                //   adFontColor: Colors.black,
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                              width:(MediaQuery.of(context).size.width/2)-30 ,
                              height: 40.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: ()
                                {
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute<String>(
                                      builder: (context) => HomePage()));
                                },
                                child: Text('Cancel').tr(),
                              ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: (MediaQuery.of(context).size.width/2)-30,
                            height: 40.h,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: ()
                                {
                                    if (Platform.isAndroid)
                                    {
                                       SystemChannels.platform.invokeMethod('SystemNavigator.pop', true);
                                    }
                                    else
                                    {
                                      FirebaseLog.logEvent("Appclose");
                                      exit(0);
                                    }
                                },
                              child: Text('Exit').tr(),
                            ),
                          ),
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
    );
  }

  @override
  void initState()
  {
      super.initState();
  }

  @override
  void setState(fn)
  {
    if (mounted)
    {
        super.setState(fn);
    }
  }

}
