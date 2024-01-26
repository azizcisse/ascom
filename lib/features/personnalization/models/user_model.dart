import 'package:ascom/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing user data.
class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number
  String get formattedPhoneNo => AFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );

  /// Convert model to JSON structure for starting data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Votre Prénom': firstName,
      'Votre Nom': lastName,
      'Nom d\'Utilisateur': username,
      'E-Mail': email,
      'Numéro Téléphone': phoneNumber,
      'Photo Profil': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['Votre Prénom'] ?? '',
        lastName: data['Votre Nom'] ?? '',
        username: data['Nom d\'Utilisateur'] ?? '',
        email: data['E-Mail'] ?? '',
        phoneNumber: data['Numéro Téléphone'] ?? '',
        profilePicture: data['Photo Profil'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
