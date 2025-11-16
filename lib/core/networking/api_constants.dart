class ApiConstants {
  static const String apiBaseUrl = 'https://api.alquran.cloud/v1/';
  static const String surah = 'surah';
  static const String surahByNumber = '/surah/{number}';
  static const String apiKey =
      r'$2y$10$oI9gqN0aLP4GnPn6ddMWDrDxaEF1eubikXBtkNz6S1AljyppG';
  static const String apiBaseUrlAhadith = 'https://hadithapi.com/public/api/';
  static const String ahadith = 'hadiths';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
