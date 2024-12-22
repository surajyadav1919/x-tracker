class Validation {
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) return 'Please enter an amount';
    if (double.tryParse(value) == null) return 'Please enter a valid number';
    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a title';
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a description';
    return null;
  }

  static String? validatePlace(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a place';
    return null;
  }

  static String? validateNote(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a note';
    return null;
  }
}
