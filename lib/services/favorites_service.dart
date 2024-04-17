import 'package:dvt_interview/services/firestore_service.dart';

class FavoritesService {
  final FirestoreService _firestoreService;

  FavoritesService({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  Future<void> addFavorite(String userId, String productId) async {
    try {
      await _firestoreService.addData('favorites', {
        'userId': userId,
        'productId': productId,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    try {
      final favorites = await _firestoreService.getData('favorites');
      return favorites.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((data) => data['userId'] == userId)
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
