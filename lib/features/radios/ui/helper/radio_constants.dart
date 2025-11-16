class RadioConstants {
  static const String baseUrl = "https://www.mp3quran.net/api/v3";
  static const String radiosEndpoint = "/radios";
  static const String language = "ar";

  static String getRadiosUrl() {
    return "$baseUrl$radiosEndpoint?language=$language";
  }
}
