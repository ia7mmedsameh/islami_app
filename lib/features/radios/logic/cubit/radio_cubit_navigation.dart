class RadioCubitNavigation {
  static int? findNextIndex(List<dynamic> radios, String currentUrl) {
    final i = radios.indexWhere((r) => r.url == currentUrl);
    if (i != -1 && i < radios.length - 1) return i + 1;
    return null;
  }

  static int? findPreviousIndex(List<dynamic> radios, String currentUrl) {
    final i = radios.indexWhere((r) => r.url == currentUrl);
    if (i > 0) return i - 1;
    return null;
  }
}
