class FlavorConfig {
  String flavor;
  String bannerAdUnitId;
  String interstitialAdUnitId;

  static FlavorConfig? _instance;

  FlavorConfig._createObject(
    this.flavor,
    this.bannerAdUnitId,
    this.interstitialAdUnitId,
  );

  factory FlavorConfig(
      String flavor, String bannerAdUnitId, String interstitialAdUnitId) {
    return _instance ??= FlavorConfig._createObject(
        flavor, bannerAdUnitId, interstitialAdUnitId);
  }

  static FlavorConfig get instance {
    return _instance!;
  }
}
