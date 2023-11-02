 String getFontFamily(String text) {
    if (RegExp(r'[가-힣]').hasMatch(text)) {
      return 'EliceDXNeolli';
    } else {
      return 'HemingVariable';
    }
  }