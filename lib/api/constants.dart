import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';


// const String hostUrl = "https://shreemedia.s3.us-west-2.amazonaws.com/";
const String hostUrl = "https://raw.githubusercontent.com/hims1008/demojson/main/";
const String ApiAdJson = "com.test.json";
// const String ApiAdJson = "app.heads_tails.json";


typedef void OneArgCallback(dynamic foo);

void showSnackBar(String s, BuildContext context, {Color? barColor}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      elevation: 6.0,
      backgroundColor: barColor ?? Colors.black87,
      behavior: SnackBarBehavior.floating,
      content: new Text(s)));
}


TextStyle bntText = TextStyle(
  color:  Colors.grey.shade600,
  fontWeight: FontWeight.w500,
  fontSize: 12
);
