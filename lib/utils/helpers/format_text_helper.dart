import 'package:intl/intl.dart';

class FormatTextHelper {
  static String formatFlavorText(Map<String, dynamic> data, {
    String collection = 'flavor_texts',
    String key = 'flavor_text'
  }) {
    final flavorTexts = data[collection] != null
      ? (data[collection] as List)
      : null;

    if (flavorTexts != null && flavorTexts.isNotEmpty) {
      return flavorTexts[0][key].replaceAll('\n', ' ');
    }

    return '';
  }
  
  static String formatName(String name) {
    return toBeginningOfSentenceCase(name.replaceAll('-', ' '));
  }
}