import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String targetScreen;
  String imageUrl;
  final bool active;

  BannerModel({
    required this.targetScreen,
    required this.imageUrl,
    required this.active,
  });

  /// Convert model to Json so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'TargetScreen': targetScreen,
      'ImageUrl': imageUrl,
      'Active': active,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;

      /// Map JSON Record to the Model
      return BannerModel(
        targetScreen: data['TargetScreen'] ?? '',
        imageUrl: data['ImageUrl'] ?? '',
        active: data['Active'] ?? false,
      );
    
    }
}
