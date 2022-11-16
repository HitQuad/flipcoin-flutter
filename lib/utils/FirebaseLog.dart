// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intl/intl.dart';

class FirebaseLog
{
  static logEvent(title)
  {
    try
    {
      // FirebaseAnalytics.instance.logEvent(
      //     name: 'CoipFlip_${title}',
      //     parameters: {
      //       "Date": DateFormat('yyyy-MM-dd').format(DateTime.now())
      //     });
    } catch (e) {}
  }
}
