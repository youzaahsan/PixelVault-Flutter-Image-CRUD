import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String? category;
  final DateTime timestamp;

  ImageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.category,
    required this.timestamp,
  });

  factory ImageModel.fromDynamic(String id, Map<String, dynamic> data) {
    return ImageModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'],
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
