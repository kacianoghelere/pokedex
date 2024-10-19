class FlavorTextHelper {
  static String extract(Map<String, dynamic> data, {
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
}