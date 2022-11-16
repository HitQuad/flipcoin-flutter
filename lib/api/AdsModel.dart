class AdsModel {
  String? packageName;
  String? appVersion;
  bool? isAdShow;
  String? admobAppid;
  String? admobInterid;
  String? admobBannerid;
  String? admobNativeid;
  String? admobAppopenid;
  String? clickAppopenId;
  String? admobReward;
  String? fbInterId;
  String? fbBannerId;
  String? fbNativeId;
  String? fbNativeBannerId;
  String? interCount;
  String? adSplash;
  String? adInter;
  String? adAppopen;
  String? adNative;
  String? adBanner;
  String? privacyUrl;

  AdsModel(
      {this.packageName,
        this.appVersion,
        this.isAdShow,
        this.admobAppid,
        this.admobInterid,
        this.admobBannerid,
        this.admobNativeid,
        this.admobAppopenid,
        this.clickAppopenId,
        this.admobReward,
        this.fbInterId,
        this.fbBannerId,
        this.fbNativeId,
        this.fbNativeBannerId,
        this.interCount,
        this.adSplash,
        this.adInter,
        this.adAppopen,
        this.adNative,
        this.adBanner,
        this.privacyUrl});

  AdsModel.fromJson(Map<String, dynamic> json) {
    packageName = json['package_name'];
    appVersion = json['app_version'];
    isAdShow = json['is_ad_show'];
    admobAppid = json['admob_appid'];
    admobInterid = json['admob_interid'];
    admobBannerid = json['admob_bannerid'];
    admobNativeid = json['admob_nativeid'];
    admobAppopenid = json['admob_appopenid'];
    clickAppopenId = json['click_appopen_id'];
    admobReward = json['admob_reward'];
    fbInterId = json['fb_inter_id'];
    fbBannerId = json['fb_banner_id'];
    fbNativeId = json['fb_native_id'];
    fbNativeBannerId = json['fb_native_banner_id'];
    interCount = json['inter_count'];
    adSplash = json['ad_splash'];
    adInter = json['ad_inter'];
    adAppopen = json['ad_appopen'];
    adNative = json['ad_native'];
    adBanner = json['ad_banner'];
    privacyUrl = json['privacy_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_name'] = this.packageName;
    data['app_version'] = this.appVersion;
    data['is_ad_show'] = this.isAdShow;
    data['admob_appid'] = this.admobAppid;
    data['admob_interid'] = this.admobInterid;
    data['admob_bannerid'] = this.admobBannerid;
    data['admob_nativeid'] = this.admobNativeid;
    data['admob_appopenid'] = this.admobAppopenid;
    data['click_appopen_id'] = this.clickAppopenId;
    data['admob_reward'] = this.admobReward;
    data['fb_inter_id'] = this.fbInterId;
    data['fb_banner_id'] = this.fbBannerId;
    data['fb_native_id'] = this.fbNativeId;
    data['fb_native_banner_id'] = this.fbNativeBannerId;
    data['inter_count'] = this.interCount;
    data['ad_splash'] = this.adSplash;
    data['ad_inter'] = this.adInter;
    data['ad_appopen'] = this.adAppopen;
    data['ad_native'] = this.adNative;
    data['ad_banner'] = this.adBanner;
    data['privacy_url'] = this.privacyUrl;
    return data;
  }
}
