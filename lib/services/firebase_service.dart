import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/image_model.dart';

class FirebaseService {
  final CollectionReference _imagesCollection = FirebaseFirestore.instance
      .collection('images');

  // Stream for real-time updates
  Stream<List<ImageModel>> getImages() {
    return _imagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ImageModel.fromDynamic(
              doc.id,
              doc.data() as Map<String, dynamic>,
            );
          }).toList();
        });
  }

  // Save image as Base64 string to Firestore
  Future<void> addImage(
    Uint8List imageBytes,
    String title,
    String description, {
    String? category,
  }) async {
    try {
      debugPrint('STARTING BASE64 CONVERSION: ${imageBytes.length} bytes');

      // Convert bytes to Base64
      String base64Image = base64Encode(imageBytes);
      debugPrint('CONVERSION COMPLETE.');

      debugPrint('SAVING TO FIRESTORE...');
      await _imagesCollection.add({
        'title': title,
        'description': description,
        'imageUrl': base64Image, // We use the same field name for simplicity
        'category': category,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint('FIRESTORE SAVE COMPLETE.');
    } catch (e) {
      debugPrint('ERROR IN FIREBASE SERVICE: $e');
      throw 'Database save failed: $e';
    }
  }

  // Update existing image metadata and/or Base64 string
  Future<void> updateImage(
    String id, {
    Uint8List? imageBytes,
    String? title,
    String? description,
    String? category,
    String? oldImageUrl,
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (title != null) data['title'] = title;
      if (description != null) data['description'] = description;
      if (category != null) data['category'] = category;

      if (imageBytes != null) {
        debugPrint('UPDATING BASE64 IMAGE...');
        data['imageUrl'] = base64Encode(imageBytes);
      }

      await _imagesCollection.doc(id).update(data);
      debugPrint('UPDATE COMPLETE.');
    } catch (e) {
      debugPrint('ERROR IN UPDATE: $e');
      throw 'Update failed: $e';
    }
  }

  // Delete metadata from Firestore
  Future<void> deleteImage(String id, String imageUrl) async {
    try {
      await _imagesCollection.doc(id).delete();
      debugPrint('DELETE COMPLETE.');
    } catch (e) {
      debugPrint('ERROR IN DELETE: $e');
      throw 'Delete failed: $e';
    }
  }
}
