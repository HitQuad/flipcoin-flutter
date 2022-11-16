import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final SharedPreferences shared;
  Preferences(this.shared);

  static String keyFlipCountIndex = "FlipCountIndex";
  static String keyIsSwingToss = "IsSwingToss";
  static String keyCheatMode = "CheatMode";
  static String keyCheatResult = "CheatResult";
  static String keyFlipSound = "FlipSound";
  static String keyIsShake = "IsShake";
  static String keyIsVibration = "IsVibrate";
  static String keyBgIndex = "BgIndex";
  static String keyCustomBg = "CustomBg";
  static String keyCustomBgImage = "CustomBgImage";
  static String keyCoinIndex = "CoinIndex";
  static String keyCustomCoin = "CustomCoin";
  static String keyCoinImageHeads = "CoinImageHeads";
  static String keyCoinImageTails = "CoinImageTails";
  static String keyRateComplete = "RateComplete";

  bool getBool(key) => shared.getBool(key) ?? true;
  bool getBoolDefault(key, onDefault) => shared.getBool(key) ?? onDefault;
  String getString(key) => shared.getString(key) ?? "";
  String getStringDefault(key, onDefault) => shared.getString(key) ?? onDefault;
  int getInt(key) => shared.getInt(key) ?? 0;
  int getIntDefault(key, onDefault) => shared.getInt(key) ?? onDefault;

  Future setString(String key, String value) async {
    await shared.setString(key, value);
  }

  Future setBool(String key, bool value) async {
    await shared.setBool(key, value);
  }

  Future setInt(String key, int value) async {
    await shared.setInt(key, value);
  }

  static Future<Preferences> init() =>
      SharedPreferences.getInstance().then((value) => Preferences(value));
}
