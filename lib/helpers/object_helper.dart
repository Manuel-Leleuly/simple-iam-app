class ObjectHelper {
// this is to remove keys that have a value of null or empty string
  static Map<String, dynamic> cleanObject(Map<String, dynamic> data) {
    final result = Map<String, dynamic>.from(data);

    final List<String> keysToRemove = [];

    result.forEach(
      (key, value) {
        if (value == null) keysToRemove.add(key);
        if (value != null && value is String && value.isEmpty) {
          keysToRemove.add(key);
        }
      },
    );

    for (var key in keysToRemove) {
      result.remove(key);
    }

    return result;
  }
}
