import 'package:flutter/foundation.dart';

enum LanguageCode { th, en }

class AppLanguage {
  static final ValueNotifier<LanguageCode> current =
      ValueNotifier<LanguageCode>(LanguageCode.th);

  static bool get isEnglish => current.value == LanguageCode.en;
  static String get code => isEnglish ? 'en' : 'th';

  static void toggle() {
    current.value = isEnglish ? LanguageCode.th : LanguageCode.en;
  }
}
