import 'package:during/flavor_config.dart';

class AdHelper {
  static String get bannerAdUnitId {
    return FlavorConfig.instance.bannerAdUnitId;
  }

  static String get interstitialAdUnitId {
    return FlavorConfig.instance.interstitialAdUnitId;
  }
}
