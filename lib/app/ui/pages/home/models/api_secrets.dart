class ApiSecrets {
  static const String _giftbillsUrlKey = "giftbills_url";
  static const String _giftbillsSecretKey = "giftbills_secret";
  static const String _termiiUrlKey = "termii_url";
  static const String _termiiSecretKey = "termii_secret";

  final String giftbillsUrl;
  final String giftbillsSecret;
  final String termiiUrl;
  final String termiiSecret;

  ApiSecrets({
    required this.giftbillsUrl,
    required this.giftbillsSecret,
    required this.termiiUrl,
    required this.termiiSecret,
  });

  factory ApiSecrets.fromJson(Map<String, dynamic> json) {
    return ApiSecrets(
      giftbillsUrl: json[_giftbillsUrlKey],
      giftbillsSecret: json[_giftbillsSecretKey],
      termiiSecret: json[_termiiSecretKey],
      termiiUrl: json[_termiiUrlKey],
    );
  }
}
