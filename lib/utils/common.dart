import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_extend/share_extend.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:toss_heads_or_tails/utils/ConnectionStatusSingleton.dart';
import 'package:toss_heads_or_tails/utils/preferences.dart';
import 'package:toss_heads_or_tails/utils/ratingDialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

Color primaryColor = Color(0xFF432818);
Color bgContainerSetting = Color(0xFFf2eee2);
Color tossBg = Color(0xFFC4C4C4);
Color flippingBg = Color(0xFFD3DAFF);
Color headsBg = Color(0xFFF1CCCC);
Color tailsBg = Color(0xFFD0FFFA);
Color tossColor = Color(0xFF000000);
Color flippingColor = Color(0xFF3949AB);
Color tailsColor = Color(0xFF00887A);
Color headsColor = Color(0xFFB80000);
Color lightBrown = Color(0xFFf2eee2);

String appStoreUrl =
    'https://apps.apple.com/us/app/coin-flip-head-or-tail-2017/id1312263110';

String playStoreUrl =
    'https://play.google.com/store/apps/details?id=app.heads_tails';

String hateItUrl =
    "https://docs.google.com/forms/d/e/1FAIpQLSenE14nlAigh2xZrgRKNeAms6y2wvlieO64vXzclyt7cK2EkA/viewform";

Preferences? preferences;

//String appName = "appname".tr();
bool flipping = false;
bool result = false;
bool isShowHeads = true;

LinearGradient buttonHome = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF432818),
    Color(0xFF99582A),
  ],
);

LinearGradient backgroundMain = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF000E36),
    Color(0xFF003974),
  ],
);

TextStyle txtStyleSetting = TextStyle(
  color: primaryColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
);

BoxDecoration settingBoxDecoration = BoxDecoration(
  color: bgContainerSetting,
  borderRadius: BorderRadius.all(
    Radius.circular(10.r),
  ),
    border: Border.all(color: primaryColor,
        width: 3,
        style: BorderStyle.solid)
);

List bgList = [
  "assets/bg/bg1.jpg",
  "assets/bg/bg2.jpg",
  "assets/bg/bg3.jpg",
  "assets/bg/bg4.jpg",
  "assets/bg/bg5.jpg",
  "assets/bg/bg6.jpg",
  "assets/bg/bg7.jpg",
  "assets/bg/bg8.jpg",
];

Widget buildBottomSheet(BuildContext context) {
  return CupertinoActionSheet(
    title: Text("sel_img").tr(),
    message: Text("sel").tr(),
    actions: [
      CupertinoActionSheetAction(
        onPressed: () async {
          await getImage(ImageSource.camera);
          Navigator.pop(context, true);
        },
        child: Text("Camera").tr(),
      ),
      CupertinoActionSheetAction(
        onPressed: () async {
          await getImage(ImageSource.gallery);
          Navigator.pop(context, true);
        },
        child: Text("Gallery").tr(),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      onPressed: () {
        Navigator.pop(context, true);
        return null;
      },
      child: Text(
        "Cancel".tr(),
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

cameraContainer() {
  return Container(
    height: 200.sp,
    width: 200.sp,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black12,
      border: Border.all(
        color: primaryColor,
        width: 2.sp,
      ),
    ),
    child: Center(
      child: SvgPicture.asset(
        'assets/camera.svg',
        width: 40.sp,
        color: primaryColor,
      ),
    ),
  );
}

imageContainer(File file) {
  return Container(
    height: 200.sp,
    width: 200.sp,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: FileImage(file),
        fit: BoxFit.cover,
      ),
      border: Border.all(
        color: primaryColor,
        width: 2.sp,
      ),
    ),
  );
}

final picker = ImagePicker();
File? tempImageFile;

Future getImage(ImageSource imageSource) async {
  final pickedFile = await picker.getImage(source: imageSource);

  try {
    if (pickedFile != null) {
      tempImageFile = File(pickedFile.path);
      return tempImageFile!.path;
    } else {
      print('No image selected.');
    }
  } catch (e) {
    print(e);
  }
}

menuButton(String name, VoidCallback callback) {
  return Column(
    children: [
      Container(
        height: 60.h,
        width: 150.w,
        decoration: BoxDecoration(
          gradient: buttonHome,
          border: Border.all(
            width: 2.sp
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: ElevatedButton(
          onPressed: callback,
          child: GradientText(
                name,
              style: TextStyle(fontSize: 16.0,),

              colors: [
              Color(0xFF432818),
              Color(0xFF99582A),
              ]),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            side: BorderSide(color: Color(432818)),

          ),
        ),
      ),
      SizedBox(height: 15.h),
    ],
  );
}

Future shareApp(String text) async {
  await ShareExtend.share(text, 'text', subject: "appname".tr());
}

Future showRatingDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => RatingDialog(
      cancel: () {
        Navigator.pop(context);
      },
      hateIt: () async {
        await canLaunch(hateItUrl)
            ? await _launchUrl(hateItUrl)
            : throw 'Could not launch $hateItUrl';
        Navigator.pop(context);
      },
      rateIt: () async {
        String url = playStoreUrl;
        if (Platform.isIOS) {
          url = appStoreUrl;
        }
        await canLaunch(url)
            ? await _launchUrl(url)
            : throw 'Could not launch $url';

        Navigator.pop(context);
      },
    ),
  );
}

_launchUrl(String url) async {
  await launch(url);
  preferences!.setBool(Preferences.keyRateComplete, true);
}

List<int> vibrationPattern = [
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500,
  500
];


Future<bool> checkInternet() async {
  // return true;
  return ConnectionStatus.getInstance().checkConnection();
}