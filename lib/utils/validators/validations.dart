class AValidation {
  /// Empty Text Validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName est Obligatoire';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Adresse Email est obligatoire.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'L\'adresse email n\'est pas valide';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est obligatoire';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit avoir au moins une lettre masjuscule.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[!@#$^%&*(),.":{}|<>]'))) {
      return 'Le mot de passe doit avoir au moins un caractère spécial.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est obligatoire.';
    }

    //  Regular  expression for phone number validation  (assuming  a 9-digit SN phone phone number format)
    final phoneRegExp = RegExp(r'^\d{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Le numéro de téléphone n\'est pas valide (9 nombres obligatoire).';
    }
    return null;
  }
  // Add more custom validators as needed for your specific requirements.
}
