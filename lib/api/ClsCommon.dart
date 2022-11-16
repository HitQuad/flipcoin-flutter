import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:toss_heads_or_tails/api/constants.dart';
import 'package:toss_heads_or_tails/api/date_utils.dart';


class ClsCommon {
  Context? _context;

  Future<String> postResponse(var servicename, Map<String, dynamic> map,
      {bool auth: false}) async {

//    var body = parse(envelope);
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       // I am connected to a mobile network..
//       return json.encode({
//         "Message": "No Internet!",
//         "statusCode":0,
//         "Data": "Internet connection not available."
//       });
//     }

    try {

      DateTime startTime = DateTime.now();
      String envelope = json.encode(map);
      print('Request==' + envelope);
      String requrl = '${hostUrl}${servicename}';
      print('RequestUrl==' + requrl);


      // HttpClient client = new HttpClient();
      // HttpClientRequest request = await client.postUrl(Uri.parse(requrl));
      // request.headers.contentType = new ContentType("application", "json", charset: "utf-8");
      // request.write(envelope);
      // HttpClientResponse response = await request.close();

      var hearder = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // if (auth) {
      //   hearder["x-access-token"] = loginData?.token??"";
      //   // hearder["x-access-token"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ijk3MjUwNTA0NjMiLCJVc2VySWQiOjIsImlhdCI6MTY0OTA2NjAxNywiZXhwIjoxNjQ5MDY2Mzc3fQ.H8URmNP9uDb6UYGxJWeMiPgBtnCi4VHr3gnIsrmUkm8";
      // }
      Response response = await post(Uri.parse(requrl),
          headers:hearder,
          body: envelope);

      if (response.statusCode == 200) {
        String _response = "null";
        //
        // response.transform(utf8.decoder).listen((event) {
        //   print("ClsResponse=" + event.toString());
        //   _response = event;
        //   return event;
        // });

        _response = response.body;
        DateTime endTime = DateTime.now();
        String duration = ClsDateUtil
            .calculateDurationDifference(startTime, endTime)
            .inMilliseconds
            .toString();
        showToast("Response in ${duration} ms");
        print("Response Time=" + duration);
        log("ClsResponse=" + _response.toString());
        return _response;
      } else {
        print(response.body);
        return response.body.toString();
      }
    } catch (e,t) {
      print(t);
      return '{"Message":"Catch Error!","Data":"${e
          .toString()}","statusCode":0}';
    }
  }

  Future<String> getResponce(String servicename) async {
    try {
      DateTime startTime = DateTime.now();
      String requrl = '${hostUrl}${servicename}';
      print('RequestUrl==' + requrl);
      // HttpClient client = new HttpClient();

      // HttpClientRequest request = await client.getUrl(Uri.parse(requrl));
      // HttpClientResponse response = await request.close();
      Response response = await get(Uri.parse(requrl));
      if (response.statusCode == 200) {
        // String _response="null";
        // response.transform(utf8.decoder).listen((event) {
        //   _response = event;
        // });
        var _response = response.body;
        DateTime endTime = DateTime.now();
        String duration = ClsDateUtil
            .calculateDurationDifference(startTime, endTime)
            .inMilliseconds
            .toString();
        showToast("Response in ${duration} ms");
        print("Response Time=" + duration);
        log("ClsResponse=" + _response.toString());
        return _response;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return '{"Message":"Catch Error!","Data":"${e
          .toString()}","statusCode":0,}';
    }
  }

  showToast(String msg) {
    // Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.black54,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
  }
}
