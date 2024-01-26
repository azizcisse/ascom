// ignore_for_file: prefer_const_constructors

class AFormatException implements Exception {
  /// The associated error message
  final String message;

  /// Default constructor with a generic error message
  const AFormatException(
      [this.message =
          'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message
  factory AFormatException.fromMessage(String message) {
    return AFormatException(message);
  }

  /// Get the corresponding error message
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory AFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return AFormatException(
            'The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return AFormatException(
            'The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return AFormatException(
            'The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return AFormatException(
            'The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return AFormatException(
            'The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return AFormatException(
            'The input should be a valid numeric format.');
      default:
      throw AFormatException('An unexpected Firebase error occurred. Please try again.');
          
    }
  }
}
